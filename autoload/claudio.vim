vim9script

def NextCommand(): string
  if (has_key(b:, 'claudio_uuid'))
    return 'claude --permission-mode plan -p -r ' .. b:claudio_uuid
  else
    b:claudio_uuid = expand('%:t:r')
    return 'claude --permission-mode plan -p --session-id ' .. b:claudio_uuid
  endif
enddef

def TextEntered(text: string)
  var cmd = NextCommand()
  append(line('$'), systemlist(cmd, text))
  append(line('$'), ['', '']) # Give some space after Claude's answer
  # setlocal nomodified
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
