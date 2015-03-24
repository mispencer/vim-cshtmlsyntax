" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'cshtml'
endif

syn include @cshtmlCsharp syntax/cs.vim
syn include @cshtmlHtml syntax/html.vim
syn cluster cshtmlRazor contains=ALL
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained start="(" end=")\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpKeyword,cshtmlCsharpBlockLong,cshtmlCsharpBlockShort
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained start="{" end="}\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock,@cshtmlHtml,cshtmlCsharpKeyword,cshtmlInnerHtmlBlock nextgroup=cshtmlCsharpBlockLongElse
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained start="[[]" end="[]]\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock,@htmlCss,@htmlJavaScript,javaScript,@cshtmlHtml,cshtmlCsharpKeyword
syn region cshtmlCsharpBlockShort matchGroup=cshtmlStatement start="@" end="\_s\|['"@<)]"me=s-1 contains=@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpKeyword containedin=htmlString,@htmlJavaScript,javaScript,@htmlCss,cshtmlInnerHtmlBlock,cshtmlHtml,cshtmlInnerCsBlock,cshtmlCsharpBlock
syn region cshtmlCsharpBlockShort matchGroup=cshtmlStatement start="@helper" end="{"me=s-1 contains=@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpKeyword  nextgroup=cshtmlCsharpBlock containedin=htmlString,@htmlJavaScript,javaScript,@htmlCss,cshtmlInnerHtmlBlock,cshtmlHtml,cshtmlInnerCsBlock,cshtmlCsharpBlock
syn match cshtmlCsharpBlockLong "@\(using\|if\|foreach\|for\)\s*" nextgroup=cshtmlCsharpBlockLongParam containedin=htmlString,@htmlJavaScript,javascript,@htmlCss,cshtmlInnerHtmlBlock,cshtmlHtml
syn match cshtmlCsharpBlockLongElse "\_s*else\_s*" nextgroup=cshtmlCsharpBlock,cshtmlCsharpBlockLongElseContinuation contained
syn match cshtmlCsharpBlockLongElseContinuation  "if\s*" nextgroup=cshtmlCsharpBlockLongParam
syn region cshtmlCsharpBlockLongParam matchGroup=cshtmlStatement contained start="(" end=")\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpKeyword nextGroup=cshtmlCsharpBlock
syn region cshtmlHtml matchGroup=cshtmlStatement contained start="<text>" end="</text>" contains=@cshtmlCsharp,@htmlCss,@htmlJavaScript,@cshtmlHtml,cshtmlCsharpKeyword containedin=cshtmlCsharpBlock
syn region cshtmlHtml matchGroup=cshtmlStatement contained start="@:" end="\n" contains=@cshtmlCsharp,@htmlCss,@htmlJavaScript,@cshtmlHtml,cshtmlCsharpKeyword containedin=CshtmlCsharpBlock
syn region cshtmlHtml start="@<\z\([a-z]\w*\)" end="</\z1>\|\(\/>\(<\z1[^>]*\/>\)\@<=\)" extend keepend contains=@cshtmlHtml containedin=@cshtmlSharp,cshtmlCsharpBlock,cshtmlInnerHtmlBlock,cshtmlHtml
syn region cshtmlInnerCsBlock start="{" end="}" extend keepend containedin=@cshtmlCsharpBlock,@cshtmlCsharp,cshtmlInnerCsBlock contains=cshtmlInnerHtmlBlock
syn region cshtmlInnerHtmlBlock start="\(<\(bool\|byte\|sbyte\|char\|decimal\|double\|float\|int\|uint\|long\|ulong\|object\|short\|ushort\|string\)\@!\z([a-z]\w\+\)\)" end="\(<\/\z1[^>]*>\)\|\(/>\(<\z1[^>]*\/>\)\@<=\)" extend keepend contains=@htmlCss,@htmlJavaScript,@cshtmlHtml,cshtmlCsharpBlockLong,cshtmlCsharpBlockShort,cshtmlInnerHtmlBlock
syn region cshtmlComment matchGroup=cshtmlComment start="@[*]" end="[*]@" contains=NONE containedin=@cshtmlHtml,@cshtmlCsharp,@cshtmlRazor keepend extend
syn region cshtmlSection matchGroup=cshtmlStatement start="^\s*@section\s*\w*\s{" end="}" contains=TOP
syn match cshtmlModel "^\s*@model\s*[a-zA-Z0-9-.<>]*"
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement start="@{" end="}" contains=@cshtmlCsharp,cshtmlCsharpBlockText,cshtmlCsharpKeyword,cshtmlInnerCsBlock,cshtmlInnerHtmlBlock,cshtmlHtml

hi link cshtmlComment Comment
hi link cshtmlCsharpBlockShort cshtmlStatement
hi link cshtmlCsharpBlockLong cshtmlStatement
hi link cshtmlCsharpBlockLong cshtmlStatement
hi link cshtmlCsharpBlockLongElse cshtmlStatement
hi link cshtmlCsharpBlockLongElseContinuation cshtmlStatement
hi link cshtmlStatement Special
hi link cshtmlSection Special
hi link cshtmlModel Special

syn sync fromstart
"syn sync clear
"syn sync minlines=1
"syn sync match csBlock  grouphere cshtmlCsharpBlock "@{"
"syn sync match csBlock  grouphere cshtmlCsharpBlockLongParam "^\s*@\(using\|if\|foreach\|for\)\s*\zs("
"syn sync match csScript grouphere javaScript "<script"
"syn sync match csHtml   grouphere cshtmlInnerHtmlBlock "\(<\(bool\|byte\|sbyte\|char\|decimal\|double\|float\|int\|uint\|long\|ulong\|object\|short\|ushort\|string\)\@!\([a-z]\w\+\)\)"

let b:current_syntax = "cshtml"
