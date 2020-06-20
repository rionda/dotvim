" Some settings to get flowed text in emails as per RFC 3676
"
" Adapted from https://incenp.org/notes/2020/format-flowed-neomutt-vim.html
" and http://www.mdlerch.com/emailing-mutt-and-vim-advanced-config.html
setlocal textwidth=72
" a: automatic formatting of paragraphs;
" w: trailing space denotes that paragraph continues on next line, as required
" by the "flowed" format for emails;
" q: allow formatting of comments with "gq".
" Remember to set text_flowed in .muttrc or similar
setlocal formatoptions="awq"
" Highlight trailing whitespaces, so we can distinguish between soft and hard
" breaks.
match ErrorMsg '\s\+$'

function! IsReply()
	" Use the command "par" to reflow quoted text in replies.
    if line('$') > 1 " If there are more than 1 line in the buffer
        :g/^>\s\=--\s\=$/,$ delete
        :%!par w72q
        :%s/^.\+\ze\n\(>*$\)\@!/\0 /e
        :%s/^>*\zs\s\+$//e
    endif
endfunction

autocmd BufEnter call IsReply()
