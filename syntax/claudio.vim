if exists("b:current_syntax")
  finish
endif

syn region claudioFold start='.' end='^result>' transparent fold contains=claudioAssistant,claudioSystem,claudioUser

syn match claudioPrompt '^claudio> ' nextgroup=claudioFold

syn match claudioAssistant '^assistant> ' nextgroup=claudioAssistantOutput
syn match claudioAssistantOutput '.*$' contained
syn match claudioSystem '^system> .*$'
syn match claudioUser   '^user> .*$'

hi def link claudioAssistant Comment
hi def link claudioAssistantOutput Comment
hi def link claudioFold Question
hi def link claudioPrompt WarningMsg
hi def link claudioSystem Comment
hi def link claudioUser Comment

let b:current_syntax = "claudio"
