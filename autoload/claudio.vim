vim9script

def NextCommand(): string
  if (has_key(b:, 'claudio_uuid'))
    return 'claude --permission-mode plan -p -r ' .. b:claudio_uuid
  else
    b:claudio_uuid = expand('%:t:r')
    return 'claude --permission-mode plan -p --session-id ' .. b:claudio_uuid
  endif
enddef

def GotOutput(ch: channel, msg: string)
  append(line('$') - 1, msg)
  setlocal nomodified
enddef
def JobExit(job: job, status: number)
  append(line('$') - 1, ['']) # Give some space after Claude's answer
  setlocal nomodified
enddef

def TextEntered(text: string)
  b:claudio_job = job_start(NextCommand(), {
    out_cb: GotOutput,
    err_cb: GotOutput,
    exit_cb: JobExit,
  })
  ch_sendraw(b:claudio_job, text .. "\n")
  ch_close_in(b:claudio_job)
enddef

export def New()
  setlocal buftype=prompt
  setlocal bufhidden=hide
  setlocal noswapfile
  # TODO: syntax=claudio??
  # setlocal syntax=java

  prompt_setcallback(bufnr(), TextEntered)
  prompt_setprompt(bufnr(), 'claudio> ')
  startinsert
enddef

export def Start()
  const uuid = systemlist('uuidgen')[0]
  exe 'edit claudio://' .. uuid
enddef
