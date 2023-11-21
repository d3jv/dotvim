if exists("did_load_filetypes")
	  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ad		setfiletype asciidoctor
  au! BufRead,BufNewFile *.tsx,*.jsx	setfiletype typescriptreact
augroup END
