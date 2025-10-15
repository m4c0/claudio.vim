if exists("b:current_syntax")
  finish
endif

syn match claudioPrompt '^claudio> ' nextgroup=claudioPromptInput
syn match claudioPromptInput '.*$' contained

syn match claudioAssistant '^assistant> .*$'
syn match claudioSystem '^system> .*$'
syn match claudioUser   '^user> .*$'

hi def link claudioAssistant Comment
hi def link claudioPrompt WarningMsg
hi def link claudioPromptInput Question
hi def link claudioSystem Comment
hi def link claudioUser Comment

let b:current_syntax = "claudio"
