"{{{ File header information
"	vim:ff=unix ts=4 ss=4
"	vim60:fdm=marker
"	\file		feralstubs_vim.vim
"	\date		Thu, 24 Jun 2004 06:34 PST
"
"	\brief		entries for FeralStub for .vim files.
"				Drop this in your ~/.vim/ftplugin/vim/ directory
"				I.e. this is a ftplugin.
"	\note		See feralstub.vim for more information.
"
"	\author		Robert KellyIV <sreny@rpyrpgvpjvmneq.pbz> (Rot13ed)
"	\version	$Id$
"	Version:	0.1
"	History:	{{{
"	[Feral:170/04@12:38] 0.1
"	Initial.
"	}}}
"
"}}}

if exists("g:loaded_feralstubs_".&ft."")
	finish
endif
let g:loaded_feralstubs_{&ft} = 1

"//////////////////////////////////////////////////////////////////////////
"//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //
"//////////////////////////////////////////////////////////////////////////
" Insert your entries here!
":s//\\<CR>/ge|:s//\\<ESC>/&|s/"/\\"/&|s/\t/\\t/&|:noh


"fu[nction]
call FeralStub_AddNewExecute(&ft, '\<fu\%[nction]\>', "norm! ciwfunction\<CR>endfunction\<ESC>kA \<ESC>")

"i[f]
call FeralStub_AddNewExecute(&ft, '\<i\%[f]\>', "norm! ciwif\<CR>endif\<ESC>kA \<ESC>")

"s[ave]m[ark]
call FeralStub_AddNewFunction(&ft, '\c\<s\%[ave]m\%[ark]\>', 'STUB_VIM_SaveMark')
function STUB_VIM_SaveMark()
	"[Feral:298/02@12:32] I think this would have been easier as a fte...
	exe "norm! ciw\" Save where we are"
	exe "norm! o\<esc>Slet SavedMark = line('.').'G'.virtcol('.').'|'"
	exe "norm! onormal! H"
	exe "norm! olet SavedMark = 'normal! '.line('.').'Gzt'.SavedMark"
	exe "norm! oexecute SavedMark"
	exe "norm! 3o"
	exe "norm! o\" Return to where we were"
	exe "norm! o\<esc>Sexecute SavedMark"
	exe "norm! ounlet SavedMark"
	exe "norm! ^5k"
endfunction

"//////////////////////////////////////////////////////////////////////////
"//  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //  //
"//////////////////////////////////////////////////////////////////////////

"EOF
