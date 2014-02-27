" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'razor'
endif

"syn match razorCsharpKeyword contained containedin=razorCsharpBlock "[a-zA-Z0-9.-]"
"syn match razorCsharpKeyword contained containedin=htmlTag "[a-zA-Z0-9.-]"
"hi link razorCsharpKeyword SpecialComment
syn match razorCsharpKeyword contained "\w\@<!\(using\|if\|for\|each\)\w\@!\s*"

unlet! b:current_syntax
runtime! syntax/html.vim
unlet! b:current_syntax

syn include @razorCsharp syntax/cs.vim
syn include @razorHtml syntax/html.vim
"syn match razorCsharpString matchGroup=String +"([^"]|\\")*\"+
syn region razorCsharpBlock matchGroup=Comment contained start="(" end=")\_s*" contains=@razorCsharp,razorCsharpBlock,razorCsharpKeyword,razorCsharpBlockLong,razorCsharpBlockShort
syn region razorCsharpBlock matchGroup=Comment contained start="{" end="}\_s*" contains=@razorCsharp,razorCsharpBlock,@razorHtml,razorCsharpKeyword,razorInnerHtmlBlock nextgroup=razorCsharpBlockLongElse
syn region razorCsharpBlock matchGroup=Comment contained start="[[]" end="[]]\_s*" contains=@razorCsharp,razorCsharpBlock,@htmlCss,@htmlJavaScript,@razorHtml,razorCsharpKeyword
syn region razorCsharpBlockShort matchGroup=razorStatement start="@" end="\_s\|['"@<]"me=s-1 contains=@razorCsharp,razorCsharpBlock,razorCsharpKeyword containedin=htmlString,@htmlJavaScript,@htmlCss,razorInnerHtmlBlock,razorHtml,razorInnerCsBlock
syn match razorCsharpBlockLong "@\(using\|if\|foreach\|for\)\s*" nextgroup=razorCsharpBlockLongParam containedin=htmlString,@htmlJavaScript,@htmlCss,razorInnerHtmlBlock,razorHtml
syn match razorCsharpBlockLongElse "\_s*else\_s*" nextgroup=razorCsharpBlock,razorCsharpBlockLongElseContinuation contained
syn match razorCsharpBlockLongElseContinuation  "if\s*" nextgroup=razorCsharpBlockLongParam
syn region razorCsharpBlockLongParam matchGroup=Comment contained start="(" end=")\_s*" contains=@razorCsharp,razorCsharpBlock,razorCsharpKeyword nextGroup=razorCsharpBlock
"syn region razorCsharpBlock matchGroup=razorStatement start="@" end="\s\|["]\|<"me=e-1 contains=razorCsharpKeyword containedin=htmlString,@htmlJavaScript,@htmlCss
"syn match razorCsharpKeyword contained containedin=razorCsharpBlock "[a-zA-Z0-9.-]"
"syn match razorCsharpKeyword contained containedin=htmlTag "[a-zA-Z0-9.-]"
"hi link razorCsharpKeyword SpecialComment
syntax region razorHtml start="@<\z\([a-z]\w*\)" end="</\z1>\|\(<\z1[^>]*\)\@<=\(/>\)" extend keepend contains=@razorHtml containedin=@razorSharp,razorCsharpBlock,razorInnerHtmlBlock,razorHtml
syntax region razorInnerCsBlock start="{" end="}" extend keepend containedin=@razorCsharpBlock,@razorCsharp,razorInnerCsBlock contains=razorInnerHtmlBlock
syntax region razorInnerHtmlBlock start="\(<\z\(bool\|byte\|sbyte\|char\|decimal\|double\|float\|int\|uint\|long\|ulong\|object\|short\|ushort\|string\)\@!\([a-z]\w\+\)\)" end="\(</\z1[^>]*>\)\|\(<\z1[^>]*\)\@<=\(/>\)" extend keepend contains=@htmlCss,@htmlJavaScript,@razorHtml,razorCsharpBlockLong,razorCsharpBlockShort,razorInnerHtmlBlock

syntax region razorComment matchGroup=razorComment start="@[*]" end="[*]@" contains=razorCommentPart,razorCommentError containedin=ALL keepend extend
syntax match razorCommentError contained "[^*@]"
syntax match razorCommentPart  contained "[*][^@]"
hi link razorCommentError  razorComment
hi link razorCommentPart razorComment
hi link razorComment Comment

syn region razorSection matchGroup=razorStatement start="^\s*@section\s*\w*\s{" end="}" contains=TOP
syn match razorModel "^\s*@model\s*[a-zA-Z0-9-.<>]*"
syn region razorCsharpBlock matchGroup=razorStatement start="@{" end="}" contains=@razorCsharp,razorCsharpBlockText,razorCsharpKeyword,razorInnerCsBlock,razorInnerHtmlBlock,razorHtml
hi link razorCsharpBlockLong razorStatement
hi link razorCsharpBlockLongElse razorStatement
hi link razorCsharpBlockLongElseContinuation razorStatement
hi link razorStatement SpecialComment
hi link razorSection SpecialComment
hi link razorModel SpecialComment

let b:current_syntax = "razor"
