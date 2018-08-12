" Operador comentar líneas:
"
" Leer el script con:
"
"   :so %
"
" Tras interpretar este archivo se dispondrá de un nuevo operador llamado 'gc'
" para comentar y descomentar texto

" Mapeo del operador gc en modo normal
nnoremap gc :set operatorfunc=OperadorComentarLineas<Return>g@
" Mapeo para modo visual
xnoremap gc :<C-u>call OperadorComentarLineas(visualmode(), 1)<Return>

" Función que define la acción del operador
function! OperadorComentarLineas(tipo, ...)
    " Si el operador se usó desde modo normal las marcas que se establecen son
    " '[ y ']. Si se usa desde modo visual las marcas son '< y  '>
    let l:marca_inicio = (a:0 ? "'<" : "'[")
    let l:marca_final  = (a:0 ? "'>" : "']")

    let l:primera_liena = getline(line(l:marca_inicio))
    let l:rango = l:marca_inicio . ',' . l:marca_final
    if l:primera_liena =~# '^\s*//'
        execute l:rango . 's/\v(^\s*)' . escape('//', '\/') . '\v\s*/\1/e'
    else
        execute l:rango . 's/^\s*/&' . escape('//', '\/') . ' /e'
    endif
    execute 'normal! ' . l:marca_inicio
endfunction
