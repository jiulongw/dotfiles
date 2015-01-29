if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead *.script setfiletype scope
  au! BufNewFile,BufRead *.module setfiletype scope
augroup END

