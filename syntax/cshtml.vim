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

runtime! syntax/html.vim
unlet b:current_syntax
syn include @cshtmlCsharp syntax/cs.vim
syn include @cshtmlHtml syntax/html.vim
syn include @cshtmlJavascript syntax/javascript.vim
syn cluster cshtmlRazor contains=ALL

syn cluster csHtmlContainingRazor contains=cshtmlInnerHtmlBlock,@htmlCss,@cshtmlHtml,cshtmlInnerRazor,cshtmlHtml
syn cluster csHtmlContainingInlineRazor contains=htmlString,@csHtmlContainingRazor
syn cluster csHtmlContainedInRazor contains=cshtmlInnerHtmlBlock,@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpBlockLong,cshtmlCsharpBlockShort,cshtmlHtml

syn region cshtmlSection matchGroup=cshtmlStatement start="^\s*@section\s*\w*\s{" end="}" contains=TOP
syn match cshtmlModel "^\s*@model\s*[a-zA-Z0-9-.<>]*"
syn region cshtmlInnerHtmlBlock start="\C\(<\(bool\|byte\|sbyte\|char\|decimal\|double\|float\|int\|uint\|long\|ulong\|object\|short\|ushort\|string\)\@!\z([a-z]\w*\)\)" end="\(<\/\z1[^>]*>\)\|\(/>\(<\z1[^>]*\/>\)\@<=\)" extend keepend containedin=@csHtmlContainedInRazor contains=@csHtmlContainingRazor

syn region cshtmlInnerRazor matchGroup=cshtmlStatement contained start="{" end="}\_s*" contains=@csHtmlContainedInRazor nextgroup=cshtmlCsharpBlockLongElse containedin=NONE
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained containedin=cshtmlCsharpBlock start="(" end=")\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained containedin=cshtmlCsharpBlock start="{" end="}\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement contained containedin=cshtmlCsharpBlock start="[[]" end="[]]\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock
syn region cshtmlCsharpBlockShort matchGroup=cshtmlStatement start="@" end="\_s\|['"@<)]"me=s-1 contains=@cshtmlCsharp,cshtmlCsharpBlock containedin=@cshtmlContainingInlineRazor
syn match cshtmlCsharpBlockLong "@\(using\|if\|foreach\|for\)\s*" nextgroup=cshtmlCsharpBlockLongParam containedin=@cshtmlContainingRazor
syn match cshtmlCsharpBlockLongElse "\_s*else\_s*" nextgroup=cshtmlInnerRazor,cshtmlCsharpBlockLongElseContinuation contained containedin=NONE
syn match cshtmlCsharpBlockLongElseContinuation  "if\s*" nextgroup=cshtmlCsharpBlockLongParam contained containedin=NONE
syn region cshtmlCsharpBlockLongParam matchGroup=cshtmlStatement contained start="(" end=")\_s*" contains=@cshtmlCsharp,cshtmlCsharpBlock nextgroup=cshtmlInnerRazor
syn region cshtmlHtml matchGroup=cshtmlStatement contained containedin=@cshtmlInnerRazor start="<text>" end="</text>" contains=@cshtmlCsharp,@cshtmlJavascript
syn region cshtmlHtml matchGroup=cshtmlStatement contained containedin=@cshtmlInnerRazor start="@:" end="\n" contains=@cshtmlCsharp,@cshtmlJavascript
syn region cshtmlCsharpBlock matchGroup=cshtmlStatement start="@{" end="}" containedin=cshtmlContainingRazor contains=@cshtmlContainedInRazor
syn region cshtmlComment matchGroup=cshtmlComment start="@[*]" end="[*]@" contains=NONE containedin=@cshtmlHtml,@cshtmlCsharp,@cshtmlRazor,cshtmlInnerRazor,cshtmlHtml keepend extend

syn match cshtmlCsharpBlockShort "@functions\_s*" nextgroup=cshtmlCsharpBlock containedin=@csHtmlContainedInRazor
syn region cshtmlCsharpBlockShort matchGroup=cshtmlStatement start="@helper" end="{"me=s-1 contains=@cshtmlCsharp,cshtmlCsharpBlock,cshtmlCsharpKeyword  nextgroup=cshtmlInnerRazor containedin=@csHtmlContainedInRazor

syn cluster cshtmlJsContainingRazor contains=javascript,@cshtmlJavascript,cshtmlJsInnerRazor,cshtmlJsHtml
syn cluster cshtmlJsContainingInlineRazor contains=@cshtmlJsContainingRazor
syn cluster cshtmlJsContainedInRazor contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock,cshtmlJsCsharpBlockLong,cshtmlJsCsharpBlockShort,cshtmlJsHtml

syn region cshtmlJsInnerRazor matchGroup=cshtmlJsStatement contained start="{" end="}\_s*" contains=@cshtmlJsContainingRazor nextgroup=cshtmlJsCsharpBlockLongElse containedin=NONE
syn region cshtmlJsCsharpBlock matchGroup=cshtmlJsStatement contained containedin=cshtmlJsCsharpBlock start="(" end=")\_s*" contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock
syn region cshtmlJsCsharpBlock matchGroup=cshtmlJsStatement contained containedin=cshtmlJsCsharpBlock start="{" end="}\_s*" contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock
syn region cshtmlJsCsharpBlock matchGroup=cshtmlJsStatement contained containedin=cshtmlJsCsharpBlock start="[[]" end="[]]\_s*" contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock
syn region cshtmlJsCsharpBlockShort matchGroup=cshtmlJsStatement start="@" end="\_s\|['"@<)]"me=s-1 contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock contained containedin=@cshtmlJsContainingInlineRazor
syn match cshtmlJsCsharpBlockLong "@\(using\|if\|foreach\|for\)\s*" nextgroup=cshtmlJsCsharpBlockLongParam contained containedin=@cshtmlJsContainingRazor
syn match cshtmlJsCsharpBlockLongElse "\_s*else\_s*" nextgroup=cshtmlJsInnerRazor,cshtmlJsCsharpBlockLongElseContinuation contained containedin=NONE
syn match cshtmlJsCsharpBlockLongElseContinuation  "if\s*" nextgroup=cshtmlJsCsharpBlockLongParam contained containedin=NONE
syn region cshtmlJsCsharpBlockLongParam matchGroup=cshtmlJsStatement contained start="(" end=")\_s*" contains=@cshtmlJsCsharp,cshtmlJsCsharpBlock nextgroup=cshtmlJsInnerRazor
syn region cshtmlJsHtml matchGroup=cshtmlJsStatement contained containedin=@cshtmlJsInnerRazor start="<text>" end="</text>" contains=@cshtmlJsCsharp,@cshtmlJavascript
syn region cshtmlJsHtml matchGroup=cshtmlJsStatement contained containedin=@cshtmlJsInnerRazor start="@:" end="\n" contains=@cshtmlJsCsharp,@cshtmlJavascript
syn region cshtmlJsCsharpBlock matchGroup=cshtmlJsStatement start="@{" end="}" contained containedin=cshtmlJsContainingRazor contains=@cshtmlJsContainedInRazor
syn region cshtmlJsComment matchGroup=cshtmlComment start="@[*]" end="[*]@" contains=NONE containedin=@cshtmlHtml,@cshtmlCsharp,@cshtmlRazor,cshtmlJsInnerRazor,cshtmlJsHtml keepend extend

hi link cshtmlComment Comment
hi link cshtmlCsharpBlockShort cshtmlStatement
hi link cshtmlCsharpBlockLong cshtmlStatement
hi link cshtmlCsharpBlockLongElse cshtmlStatement
hi link cshtmlCsharpBlockLongElseContinuation cshtmlStatement
hi link cshtmlSection cshtmlStatement
hi link cshtmlModel cshtmlStatement
hi link cshtmlStatement Special

hi link cshtmlJsComment Comment
hi link cshtmlJsHtml javascript
hi link cshtmlJsInnerRazor javascript
hi link cshtmlJsCsharpBlock cshtmlJsStatement
hi link cshtmlJsCsharpBlockShort cshtmlJsStatement
hi link cshtmlJsCsharpBlockLong cshtmlJsStatement
hi link cshtmlJsCsharpBlockLong cshtmlJsStatement
hi link cshtmlJsCsharpBlockLongElse cshtmlJsStatement
hi link cshtmlJsCsharpBlockLongElseContinuation cshtmlJsStatement
hi link cshtmlJsCsharpBlockLongParam cshtmlJsStatement
hi link cshtmlJsStatement cshtmlStatement
hi link javascript PreProc

"syn sync fromstart
syn sync clear
syn sync minlines=1
syn sync match csBlock  grouphere cshtmlCsharpBlock "@{"
syn sync match csBlock  grouphere cshtmlCsharpBlockLongParam "^\s*@\(using\|if\|foreach\|for\)\s*\zs("
syn sync match csScript grouphere javaScript "<script"
syn sync match csHtml   grouphere cshtmlInnerHtmlBlock "\(<\(bool\|byte\|sbyte\|char\|decimal\|double\|float\|int\|uint\|long\|ulong\|object\|short\|ushort\|string\)\@!\([a-z]\w\+\)\)"

let b:current_syntax = "cshtml"
