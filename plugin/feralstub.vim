"	vim:ff=unix ts=4 ss=4
"	vim60:fdm=marker
"	\file		feralstub.vim
"	\date		Thu, 24 Jun 2004 06:44 PST
"
"	\brief		Flexable stubs (think template)
"	\note		This is an evolution of my (unpublished) fork/hack/mangle of
"				Dr.Chip's CSTUBS which is such a nice idea.. at least, I think
"				I never published my changes..
"	\note		This is VIMSCRIPT#«TODO»,
"					«URL»
"
"	\author		Robert KellyIV <sreny@rpyrpgvpjvmneq.pbz> (Rot13ed)
"	\version	$Id$
"	Version:	0.1
"	History:	{{{
"	[Feral:170/04@09:04] 0.1
"	Initial.
"		[Feral:171/04@03:45] Much tweaking and I think it is done, or at
"		least stable and usable and such.
"	}}}
"
"	Preferances:
"	Var:	'g:FeralStub_Pref_GlobalEntriesFirstOfAfter'
"	Brief:	Process global entries before or after filetype entries..
"	Params:	0 for globals first i.e. BEFORE filetype entries(if any)
"	This is the default.
"	let g:FeralStub_Pref_GlobalEntriesFirstOfAfter = 0
"			1 for globals last i.e. AFTER filetype entries (if any)
"	let g:FeralStub_Pref_GlobalEntriesFirstOfAfter = 1
"
"	Var:	'g:FeralStub_CharToInsertOnFailure' .. see below under Usage->Invokation.
"
"
"
"
"	TODO:
"	*	Testing.. More testing never hurts but it has preformed as expected
"		and flawlessly so going to release like this."
"	*	Documtation, probably not a bad idea but hopefully the documtation
"		here is clear enough.
"
"	Issues:
"	*	None known currently...
"
"
"	Usage: {{{
"
"	Invokation:
"	Invoke this by typing a keyword and pressing '`' while in insert mode.
"	i.e.
"	fts`
"	which should result in
"	[Feral:171/04@03:20] <cursor>
"
"	The char/key you press can be changed in the plug mapping below, or
"	elsewhere via normal plug style. Note however you must also change the
"	g:FeralStub_CharToInsertOnFailure variable to the char.
"		Examples: in .vimrc
"		To Specify A Different Typable Char:
"imap	<unique>	~	<Plug>FeralStub_DO
"let g:FeralStub_CharToInsertOnFailure = '~'
"		To Specify A Non Typable Char:
"imap	<unique>	<F12>	<Plug>FeralStub_DO
"let g:FeralStub_CharToInsertOnFailure = ''
"
"
"call FeralStub_AddNewPattern(Filetype, Pattern, CallOrExecute, FuncName)
"	Filetype:	This is what filetype  this entry applies for, often this is
"	simply &ft which you'll want to use for filetype plugin stubs, or '' for
"	global stubs (ones that can be called regardless of the file's filetype).
"	Explicitly setting this on a per entry basis like this allows you to
"	specify both global and explicit file type entries from any location.
"
"	I found a need for this in my project local vim script which is only sourced
"	if I edit files from a specific directory tree.
"		See:	:h 'filetype'
"
"	Pattern:	This is the pattern to use to match() against the keyword that
"	is found when FeralStub_DO() is invoked. This is the {pat} param of
"	match() and is fed directly to match() thus any pattern you can use with
"	match() will work here.
"		See:	:h match()
"		For Example:	i.e. fts
"			'\<fts\>'
"			Or:			i.e. fu[nction]
"			'\<fu\%[nction]\>'
"			Or Even:	i.e. s[ave]m[ark]
"			'\c\<s\%[ave]m\%[ark]\>'
"
"	CallOrExecute: 0 to 'call' 1 to 'execute' the string in FuncName. If you
"	do not want to mess with this you can use the helper functions
"
"	FeralStub_AddNewFunction(Filetype, Pat, FuncName)
"	or
"	FeralStub_AddNewExecute(Filetype, Pat, FuncName)
"
"	Which are just wrappers around FeralStub_AddNewPattern() with the
"	CallOrExecute param set as approperate. The parameters to these two
"	functions are identical to and directly passed onto
"	FeralStub_AddNewPattern().
"
"	FuncName:	This is either a fnuction name to be 'call'ed if CallOrExecute
"	is 0, or a string of commands to be 'execute'ed.
"		For Example: The result is the same.
"			As A Function:
"call FeralStub_AddNewPattern('', '\<fts\>', 0, 'STUB_FTS')
"function STUB_FTS()
"	exe "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>"
"endfunction
"			As A Execute:
"call FeralStub_AddNewPattern('', '\<fts\>', 1, "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>")
"
"
"
"
"
"	Here Are Some Example Entries:
"		Call Function Style:
"call FeralStub_AddNewPattern('', '\<fts\>', 0, 'STUB_FTS')
"function STUB_FTS()
"	exe "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>"
"endfunction
"		Or: (using helper function)
"call FeralStub_AddNewPattern('', '\<fts4\>', 0, 'STUB_FTS2')
"function STUB_FTS2()
"	exe "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>"
"endfunction
"		Or: (using helper function) -- and an existing function.
"call FeralStub_AddNewPattern('', '\<fts4\>', 0, 'STUB_FTS')
"
"		Execute Style:
"call FeralStub_AddNewPattern('', '\<fts2\>', 1, "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>")
"		Or: (using helper function)
"call FeralStub_AddNewExecute('', '\<fts3\>', "norm! ".'"_ciw'."[Feral:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>")
"
"
"
"		You Can Also:... (say put this in a file that is only sourced when you do something)
"call FeralStub_AddNewPattern(&ft, "LOG", 0, 'STUB_DM_LOG')
"function STUB_DM_LOG()
"	exe "norm! ".'"_ciw'."g_pTheLog->LogMe(\"\")\<esc>2F\""
"endfunction

"		Or Even This:... (say put this in ftplugin/vim)
"call FeralStub_AddNewPattern(&ft, '\<fu\%[nction]\>', 0, 'STUB_FUNCTION')
"function STUB_FUNCTION()
"	exe "norm! ".'"_ciw'."function\<CR>endfunction\<ESC>kA \<ESC>"
"endfunction
"
"	Now the neat thing about this is you can *easily* add new entries or
"	remove old ones.. and more importantly easily limit when an entry is in
"	existance. Meaning you can define your entries in a ftplugin so (for
"	example) you can have the function one only available in a .vim file.. or
"	you can define in a script that is included becaues of an autocommand ..
"	say a local.vim file that is sourced depending on the location of the file
"	you are editing (handy for project specific configurations), this way we
"	can have the LOG one only available in the project that impliments it for
"	example.
"
"
"	CAVEAT:
"	The functions must be global, that is to say NOT 's:' nor '<SID>'. ...
"	unless someone can tell me how to feed <SID> into
"	FeralStub_AddNewPattern.. I'd much rather the stub functions be script
"	local.
"
"	}}}

if exists("loaded_feralstubs")
	finish
endif
let loaded_feralstubs = 1

let s:save_cpo = &cpo
set cpo&vim

":call confirm("Hello from feralstub.vim")

"Preferance: Globals checked first(0), or after(1) current &ft ?
if !exists("g:FeralStub_Pref_GlobalEntriesFirstOfAfter")
	let g:FeralStub_Pref_GlobalEntriesFirstOfAfter = 0
endif



" How to add a new entry...
" Filetype:			File type this pattern is for, often &ft
" Pat:				Pattern to match, if the word matches this pattern then
"					Call-or-Execute FuncName
" CallOrExecute:	0 to Call, (else)1 to Execute.
" FuncName:			string name of (global) function to call when word matches
"					pattern. I.e. this is what is done when this entry is
"					triggered.
function FeralStub_AddNewPattern(filetype, Pat, CallOrExecute, FuncName) " {{{



	" Initilize this file type if we've not got a count yet.
	if exists("s:Count{a:filetype}") == 0
		let s:Count{a:filetype} = 0
	endif


	let Index = 0
	while Index < s:Count{a:filetype}
		if exists("s:Pattern{a:filetype}{Index}") && a:Pat == s:Pattern{a:filetype}{Index}
			" matches
			call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern\nDuplicate found:\n".a:Pat." Already exists, ignoring add of\n".a:FuncName)
			break
		endif
		let Index = Index + 1
	endwhile


	if Index == s:Count{a:filetype}
		" Did not find the pattern
"		call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern:\ns:Count".a:filetype.":".s:Count{a:filetype}."\na:Pat:".a:Pat."\na:FuncName:".a:FuncName)
"		call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern:\ns:Count".a:filetype.":".s:Count{a:filetype}."\na:Pat:".a:Pat)
"		call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern:\ns:Count".a:filetype.":".s:Count{a:filetype}."\na:Pat:".a:Pat)
		let s:Pattern{a:filetype}{Index} = a:Pat
		let s:Pattern{a:filetype}{Index}_CallorExecute = a:CallOrExecute
		let s:Pattern{a:filetype}{Index}_Func = a:FuncName
"		call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern:\ns:Count".a:filetype.":".s:Count{a:filetype}."\na:Pat:".a:Pat ."\ns:Pattern".a:filetype.Index.":".s:Pattern{a:filetype}{Index} ."\ns:Pattern".a:filetype.Index."_CallorExecute.:".s:Pattern{a:filetype}{Index}_CallorExecute ."\ns:Pattern".a:filetype.Index."_Func.:".s:Pattern{a:filetype}{Index}_Func)
		let s:Count{a:filetype} = s:Count{a:filetype} + 1
	endif




"	call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern\na:filetype:".a:filetype."\ns:Count{a:filetype}:\n".s:Count{a:filetype})

"	call confirm("Hello from feralstub.vim's FeralStub_AddNewPattern:\ns:Count:".s:Count)
endfunction " }}}

" Helper: For user convience.
" Filetype:			File type this pattern is for, often &ft
" Pat:				Pattern to match, if the word matches this pattern then
"					Call FuncName
" FuncName:			string name of (global) function to call when word matches
"					pattern. I.e. this is what is done when this entry is
"					triggered.
function FeralStub_AddNewFunction(Filetype, Pat, FuncName) " {{{
	call FeralStub_AddNewPattern(a:Filetype, a:Pat, 0, a:FuncName)
endfunction " }}}

" Helper: For user convience.
" Filetype:			File type this pattern is for, often &ft
" Pat:				Pattern to match, if the word matches this pattern then
"					Execute FuncName
" FuncName:			string name of (global) function to call when word matches
"					pattern. I.e. this is what is done when this entry is
"					triggered.
function FeralStub_AddNewExecute(Filetype, Pat, FuncName) " {{{
	call FeralStub_AddNewPattern(a:Filetype, a:Pat, 1, a:FuncName)
endfunction " }}}

" Helper: To simplify FeralStub_DO
function s:FeralStub_ProcessFileTypes(word, filetype) "{{{
"	echo "FeralStub_ProcessFileTypes: word:".a:word
"	echo "FeralStub_ProcessFileTypes: filetype:".a:filetype
"	call confirm("Hello from feralstub.vim's FeralStub_ProcessFileTypes:\na:word:".a:word."\na:filetype:".a:filetype)
	let Index = 0
	let MatchedEntry = 0
	while Index < s:Count{a:filetype}

"		call confirm("Hello from feralstub.vim's FeralStub_ProcessFileTypes:\nIndex:".Index."\na:word:".a:word."\na:a:filetype:".a:filetype."\ns:Pattern".a:filetype.Index.":".s:Pattern{a:filetype}{Index})
		
		if match(a:word, s:Pattern{a:filetype}{Index}) > -1
			" matches
			let MatchedEntry = 1

"			call confirm("Hello from feralstub.vim's FeralStub_ProcessFileTypes:\nMatch!\ns:Pattern".a:filetype.Index."_Func:".s:Pattern{a:filetype}{Index}_Func."\na:filetype:".a:filetype)

			if s:Pattern{a:filetype}{Index}_CallorExecute == 0
				execute "call ".s:Pattern{a:filetype}{Index}_Func."()"
			else
				execute s:Pattern{a:filetype}{Index}_Func
			endif

			break
		endif
		let Index = Index + 1
	endwhile

	return MatchedEntry
endfunction " }}}

" ---------------------------------------------------------------------
" Changes the preceding <cword> based on what it is.
function s:FeralStub_DO() "{{{


"	call confirm("Hello from feralstub.vim's FeralStub_DO\n&ft:".&ft."\ns:Count".&ft.":\n".s:Count{&ft})


	" Add '#' to isk so we can detect #if, etc. (mostly for C/C++ codeing)
	let Old_isk = &isk
	set isk+=#
"	let word=expand("<cWORD>")
	let word=expand("<cword>") " FERAL: a <cword> matches 'while', while a <cWORD> matches 'while()'.

	" Flag:	have we matched an entry, i.e. only check other scopes if we have
	"		NOT matched an entry already.
	let MatchedEntry = 0

	" 0 = check global first
	" 1(else) = check globals last
	if g:FeralStub_Pref_GlobalEntriesFirstOfAfter == 0
"		echo "FeralStub_DO: FeralStub_Pref_GlobalEntriesFirstOfAfter: globals first"
"		call confirm("Hello from feralstub.vim's FeralStub_DO\n&ft:".&ft."\nword:".word."\nGlobals first")
		let MatchedEntry = s:FeralStub_ProcessFileTypes(word, "")
	endif
"	echo "FeralStub_DO: MatchedEntry:".MatchedEntry

	" If we have entries for this file type, and we have not matched an entry
	" yet.
	if exists("s:Count".&ft) && MatchedEntry == 0
"		echo "FeralStub_DO: FeralStub_Pref_GlobalEntriesFirstOfAfter: entries for ft:".&ft
"		call confirm("Hello from feralstub.vim's FeralStub_DO\n&ft:".&ft."\nword:".word."\nEntries for ft:".&ft)
		let MatchedEntry = s:FeralStub_ProcessFileTypes(word, &ft)
	endif
"	echo "FeralStub_DO: MatchedEntry:".MatchedEntry

	" 0 = check global first
	" 1(else) = check globals last
	if g:FeralStub_Pref_GlobalEntriesFirstOfAfter == 1 && MatchedEntry == 0
"		echo "FeralStub_DO: FeralStub_Pref_GlobalEntriesFirstOfAfter: globals last"
"		call confirm("Hello from feralstub.vim's FeralStub_DO\n&ft:".&ft."\nword:".word."\nGlobals last")
		let MatchedEntry = s:FeralStub_ProcessFileTypes(word, "")
	endif
"	echo "FeralStub_DO: MatchedEntry:".MatchedEntry


"	if Index == s:Count{&ft}
	if MatchedEntry == 0 && exists("g:FeralStub_CharToInsertOnFailure") && g:FeralStub_CharToInsertOnFailure != ''
		" Did not find the pattern
"		echo "FeralStub_Pref_GlobalEntriesFirstOfAfter: Did not find the pattern"
		if col('.') == 1
			exe "norm! i".g:FeralStub_CharToInsertOnFailure."\<Esc>"
		else
			exe "norm! a".g:FeralStub_CharToInsertOnFailure."\<Esc>"
		endif
	endif

	let &isk=Old_isk
endfunction " }}}







"///////////////////////////////////////////////////////////////////////////
"// {{{ -[ Mappings ]-------------------------------------------------------
"///////////////////////////////////////////////////////////////////////////

"if !hasmapto('<Plug>FeralStub') && mapcheck("`", "i") == ""
if !hasmapto('<Plug>FeralStub_DO', 'i')
	imap	<unique>	`	<Plug>FeralStub_DO
	let g:FeralStub_CharToInsertOnFailure = '`'
endif
inoremap <unique> <script> <Plug>FeralStub_DO <Esc>:call <SID>FeralStub_DO()<CR>a

"// }}} --------------------------------------------------------------------



" suck in the global entries
:runtime /plugin/feralstub_globals.vim
":runtime feralstub_globals.vim


let &cpo = s:save_cpo
"// -- if you have ever had a mess of crosslinked files You'd mark you eof too! :)
"///EOF
