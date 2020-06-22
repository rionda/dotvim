" Some settings for emails, including how to get flowed text in emails as per
" RFC 3676.
"
" Adapted from https://incenp.org/notes/2020/format-flowed-neomutt-vim.html
" and http://www.mdlerch.com/emailing-mutt-and-vim-advanced-config.html
setlocal textwidth=72
" a: automatic formatting of paragraphs;
" w: trailing space denotes that paragraph continues on next line, as required
" by the "flowed" format for emails;
" q: allow formatting of comments with "gq".
" Remember to set text_flowed in .muttrc or similar
setlocal formatoptions=awq
" Highlight trailing whitespaces, so we can distinguish between soft and hard
" breaks.
match ErrorMsg '\s\+$'

" Get flowed text in replies, and try to remove old signatures.
"
" The only reason for using  a function and not just a list of commands is that
" a function is easier to debug because it can be called.
function! MailPreProcess() abort
	" Move back to the beginning
	call cursor(1, 1)
	let inReplyToLine = search('^In-Reply-To:')
	if inReplyToLine != 0
		call cursor(line('$'), 1)
		let l = search('^>', 'bc', inReplyToLine)
		let f = inReplyToLine + 1
		" Get rid of the last person signature, if any, by looking for a line
		" starting with '>' followed by zero or one space, followed by two
		" dashes '--', followed by zero or 1 space, and deleting everything
		" in the quoted text coming after it. Feels a bit dangerous and likely
		" not general enough, but it is a start.
		let oldSigLine = search('^>\s\=--\s\=$', 'bc', l)
		if oldSigLine != 0
			execute oldSigLine .. ',' .. l .. ':delete'
			" Update l because it will have changed.
			let l = oldSigLine - 1
		endif
		" Use the command "par", if available to reflow the quoted text with a
		" text width of 72, and taking care of the quotes. Note that the line
		" "On ... wrote:" is also included, because it may be too long.
		let parpath = exepath('par')
		if ! empty(parpath)
			execute ':' .. f .. ',' .. l .. '!' .. parpath .. ' w72q'
			" Update l because it may have changed.
			call cursor(line('$'), 1)
			let l = search('^>', 'bc', inReplyToLine)
		endif
		" Format quoted text to use flowed text: search for any line that is not
		" zero characters, followed by a line that is *not* 0 characters or only
		" '>' characters. The actual match is the "first" line. The substitution
		" is the match with a space at the end.
		execute ':' .. f .. ',' .. l .. 's/^.\+\ze\n\(>*$\)\@!/\0 /e'
		" Ensure that blank lines are preserved in flowed text in quotes: look
		" for any line that is any number of '>' followed by one or more
		" whitespaces. The match is just the whitespace part. The substitution
		" is the empty string, which means that the whitespace part is removed.
		execute ':' .. f .. ',' .. l .. 's/^>*\zs\s\+$//e'
		" Go back to the first line
		call cursor(1,1)
	endif
endfunction

call MailPreProcess()
