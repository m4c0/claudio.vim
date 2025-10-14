vim9script

import autoload 'claudio.vim'

augroup Claudio
  au!
  au BufNew claudio://* claudio.New()
augroup END

command Claudio claudio.Start()

