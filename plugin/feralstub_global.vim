"{{{ File header information
"	vim:ff=unix ts=4 ss=4
"	vim60:fdm=marker
"
"	\file		feralstub_global.vim
"	\date		Thu, 24 Jun 2004 06:33 PST
"
"	\brief		Global stubs for feralstub.vim
"	\brief		entries for FeralStub for ALL files.
"				Drop this in your ~/.vim/plugin/ directory
"				I.e. this is a normal plugin which feralstub.vim sources.
"	\note		See feralstub.vim for more information.
"
"	\author		Robert KellyIV <sreny@rpyrpgvpjvmneq.pbz> (Rot13ed)
"	\version	$Id$
"	Version:	0.1
"	History:	{{{
"	[Feral:170/04@12:30]
"	Initial.
"	}}}
"
"}}}

if exists("loaded_feralstubglobal")
	finish
endif
let loaded_feralstubglobal = 1

let s:save_cpo = &cpo
set cpo&vim




" [Feral:170/04@13:12]
call FeralStub_AddNewExecute('', '\<fts\>', "norm! ".'"_ciw'."[YOU:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] \<esc>")

" // [Feral:178/02@07:47] `cursor`
call FeralStub_AddNewPattern('', "//[", 1, "norm! \"_s [YOU:\<C-R>=strftime('%j/%y@%H:%M')\<CR>] ")

"// -[Feral]---------------------------------------------------------------
"// `cursor`
call FeralStub_AddNewExecute('', "//", "norm! \"_a -[YOU]\<esc>$75a-\<esc>76|\"_DA\<cr>\<esc>A ")

"/* -[Feral:150/02@10:17]--------------------------------------------------
" * `cursor`
" * -------------------------------------------------------------------- */
call FeralStub_AddNewExecute('', '/\*', "norm! a -[YOU:\<C-R>=strftime('%j/%y@%H:%M')\<CR>]\<esc>$lv75|r-$a\<cr>\<cr>\<esc>2lv72|r-$a */\<esc>k$a ")



let &cpo = s:save_cpo
"EOF

