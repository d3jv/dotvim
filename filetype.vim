if exists("did_load_filetypes")
	  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ad		setfiletype asciidoctor
  au! BufRead,BufNewFile *.tsx,*.jsx	setfiletype typescriptreact
  au! BufRead,BufNewFile *.yml,*.js,*.ts,*.tsx,*.jsx setlocal shiftwidth=2 tabstop=2 expandtab
augroup END
