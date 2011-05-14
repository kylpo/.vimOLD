" Vim syntax file
" Language: .wlog
" Maintainer: Kyle Poole
" Latest Revision: Aug 4, 2010

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword break waiting waited break lunch contained
syn keyword tags anki hudson bsf bpms sonar eclipse
syn keyword PMP analyzed designed diagramed coded
"syn match todo '[ ]*$' contains=break
"syn match testComment "\*\*\*"
"syn region lineComment start="" end="" contains=testComment
syn match com "#.*$" contains=break

let b:current_syntax = "wlog"

hi def link break Statement
hi def link tags Comment
hi def link com Constant
hi def link PMP Function

