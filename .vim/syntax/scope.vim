" Vim syntax file
" Language:		SCOPE
" Maintainer:		Nikolay Zakharov <nizakha@microsoft.com>
" Latest Revision:	5 May 2014
" Filenames:		*.script *.module *.view

" Copyright Microsoft Corp., 2014
"
" This is Vim syntax file for SCOPE Language and it is internal to Microsoft.
" This file doesn't check for different versions of Vim so it might not work
" for some very old versions. Consider using latest stable version if you have
" any problems.
"
" To install, copy scope.vim to $HOME\vimfiles\syntax directory and add the
" following line in your $HOME\_vimrc:
" au BufRead,BufNewFile *.script set filetype=scope
" au BufRead,BufNewFile *.module set filetype=scope
" au BufRead,BufNewFile *.view set filetype=scope
"
" For proper installation you could put those lines in the
" $HOME\vimfiles\ftdetect\scope.vim file

if exists("b:current_syntax")
  finish
endif

" We use same group scopeKeywords for (almost all) keywords to have consistent
" highlighting inside of single statement. This is also done to be consistent
" with SCOPE Studio highlighting
" TODO: Add missing keywords if any
syn keyword	scopeKeywords		REDUCE PROCESS EXTRACT COMBINE SELECT OUTPUT PRODUCE SSTREAM USING
syn keyword	scopeKeywords		REFERENCE RESOURCE DEFINE MODULE VIEW FUNCTION IMPORT PARAMS
syn keyword	scopeKeywords		PRESORT ASC DESC WHERE SAMPLE PERCENT HAVING INNER JOIN OUTER LEFT RIGHT FULL SEMIJOIN
syn keyword	scopeKeywords		UNION INTERSECT ALL DISTINCT REGEX ON TO FROM GROUP ORDER BY AS LOCAL
syn keyword	scopeKeywords		WITH STREAMEXPIRY RANGE CLUSTERED INTO SORTED HASH REFERENCES
syn keyword	scopeKeywords		OVER PARTITION

" ALL is already in scopeKeywords (like in UNION ALL)
" TODO: highlight ALL in ALL(a, b, c) differently from ALL in UNION ALL
syn keyword	scopeLogic		AND NOT OR ANY

syn keyword	scopeAggregates		COUNT COUNTIF MAX MIN SUM AVG STDEV VAR FIRST LAST ARGMAX LIST
" Not exactly aggregates (windowing/analytical functions), but for the sake of
" highlighting we treat them same as aggregates
syn keyword	scopeAggregates		ROW_NUMBER DENSE_RANK NTILE RANK CUME_DIST PERCENT_RANK PERCENTILE_CONT PERCENTILE_DISC

syn keyword	scopeBuiltInClasses	DefaultTextExtractor DefaultTextOutputter
syn keyword	scopeDefaultTypes	int long float double string bool

" Variables like @fooBar or "@@fooBar@@"
syn match	scopePreProcVariable	/@[a-zA-Z][a-zA-Z0-9_]*\>/
syn match	scopeInputVariable	/@@[a-zA-Z][a-zA-Z0-9_]*@@/

" Preprocessor directives
syn match	scopeDeclare		"^\s*#DECLARE"
syn match	scopeSet		"^\s*#SET"
syn match	scopeIF			"^\s*#IF"
syn match	scopeENDIF		"^\s*#ENDIF"
syn match	scopeELSE		"^\s*#ELSE"

" Inlined C#
syn match	scopeCSStart		"^\s*#CS"
syn match	scopeCSEnd		"^\s*#ENDCS"
syn cluster	scopeCSPreProc		contains=scopeCSStart,scopeCSEnd
" Reuse C# syntax definition and enable it inside of scopeInlinedCsharp region
syn include	@scopeCsharp		syntax/cs.vim
unlet b:current_syntax
syn region	scopeInlinedCsharp	start="^\s*#CS" keepend end="#ENDCS"me=s-1 contains=@scopeCsharp,scopeCSStart,scopeCSEnd

" Comments
syn region	scopeCommentL		start="//" skip="\\$" end="$" keepend
syn region	scopeComment		matchgroup=scopeCommentStart start="/\*" end="\*/" extend

" Constants and variables (mostly taken from cs.vim)
syn keyword	scopeConstant	true false null
syn match	scopeSpecialError	contained "\\."
syn match	scopeSpecialCharError	contained "[^']"
" Character literals
syn match	scopeSpecialChar	contained +\\["\\'0abfnrtvx]+
" unicode characters
syn match	scopeUnicodeNumber	+\\\(u\x\{4}\|U\x\{8}\)+ contained contains=scopeUnicodeSpecifier
syn match	scopeUnicodeSpecifier	+\\[uU]+ contained
syn region	scopeVerbatimString	start=+@"+ end=+"+ skip=+""+ contains=scopeVerbatimSpec,@Spell
syn match	scopeVerbatimSpec	+@"+he=s+1 contained
syn region	scopeString		start=+"+  end=+"+ end=+$+ contains=scopeSpecialChar,scopeSpecialError,scopeUnicodeNumber,@Spell
syn match	scopeCharacter		"'[^']*'" contains=scopeSpecialChar,scopeSpecialCharError
syn match	scopeCharacter		"'\\''" contains=scopeSpecialChar
syn match	scopeCharacter		"'[^\\]'"
syn match	scopeNumber		"\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match	scopeNumber		"\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match	scopeNumber		"\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match	scopeNumber		"\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

hi def link scopeKeywords		Keyword
hi def link scopeLogic			Conditional
hi def link scopeKeywordsVarious	Type
hi def link scopeAggregates		Type
hi def link scopeDefaultTypes		Type
hi def link scopeBuiltInClasses		Type

hi def link scopeCommentStart		scopeComment
hi def link scopeCommentL		Comment
hi def link scopeComment		Comment

hi def link scopeDeclare		PreProc
hi def link scopeSet			PreProc
hi def link scopeIF			PreProc
hi def link scopeELSE			PreProc
hi def link scopeENDIF			PreProc
hi def link scopeCSStart		PreProc
hi def link scopeCSEnd			PreProc
hi def link scopePreProcVariable	PreProc
hi def link scopeInputVariable		PreProc

hi def link scopeConstant		Constant
" This part is for strings/numbers literals and it is taken from cs.vim
hi def link scopeSpecialError		Error
hi def link scopeSpecialCharError	Error
hi def link scopeString			String
hi def link scopeVerbatimString		String
hi def link scopeVerbatimSpec		SpecialChar
hi def link scopeCharacter		Character
hi def link scopeSpecialChar		SpecialChar
hi def link scopeNumber			Number
hi def link scopeUnicodeNumber		SpecialChar
hi def link scopeUnicodeSpecifier	SpecialChar

let b:current_syntax = "scope"
" vim: ts=8 sw=8 softtabstop=8 noexpandtab
