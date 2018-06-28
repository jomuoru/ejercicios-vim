" Aplicar el script con:
"
"       source %
"
scriptencoding utf-8

noremap <silent> f :call SiguienteChar(getchar(), 'adelante', 'inclusiva')<return>
noremap <silent> F :call SiguienteChar(getchar(), 'atras', 'inclusiva')<return>

noremap <silent> t :call SiguienteChar(getchar(), 'adelante', 'noinclusiva')<return>
noremap <silent> T :call SiguienteChar(getchar(), 'atras', 'noinclusiva')<return>

noremap <silent> ; :call RepetirBusqueda('misma_direccion')<return>
noremap <silent> , :call RepetirBusqueda('direccion_contraria')<return>

" Una variable global que sirve de caché
let g:busqueda_anterior = {
\   'caracter': 0,
\   'direccion': '',
\   'tipo': ''
\}

" Función que hace la búsqueda
function! SiguienteChar(codigo_char, direccion, tipo_busqueda)
    " Guardando los datos de búsqueda para futuras repeticiones
    let g:busqueda_anterior.caracter = a:codigo_char
    let g:busqueda_anterior.direccion = a:direccion
    let g:busqueda_anterior.tipo = a:tipo_busqueda

    " Preparando datos de búsqueda
    let l:char_buscado = nr2char(a:codigo_char) " nr2char => number 2 char

    let l:banderas = 'W' " No da la vuelta si encuentra fin/inicio de archivo
    if a:direccion ==# 'atras'
        let l:banderas .= 'b' "La búsqueda se da en reversa
    endif

    " Realizando la búsqueda

    if a:tipo_busqueda ==# 'noinclusiva'
        if a:direccion ==# 'adelante'
            normal! l
        else
            normal! h
        endif
    endif

    if search('\V' . l:char_buscado . '\C', l:banderas)
        if a:tipo_busqueda ==# 'noinclusiva'
            if a:direccion ==# 'adelante'
                normal! h
            else
                normal! l
            endif
        endif
    endif
endfunction

" Función que repite conservando el caché de búsqueda
function! RepetirBusqueda(direccion)
    if g:busqueda_anterior.caracter == 0
        " No hay búsqueda previa así que no se puede hacer repetición
        return
    endif

    " Se cambia la dirección si es necesario
    let l:vieja_dir = g:busqueda_anterior.direccion
    if a:direccion ==# 'direccion_contraria'
        if g:busqueda_anterior.direccion ==# 'adelante'
            let g:busqueda_anterior.direccion = 'atras'
        else
            let g:busqueda_anterior.direccion = 'adelante'
        endif
    endif

    " Se realiza la búsqueda
    call SiguienteChar(g:busqueda_anterior.caracter,
                     \ g:busqueda_anterior.direccion,
                     \ g:busqueda_anterior.tipo)

    " Regresando el estado original
    let g:busqueda_anterior.direccion = l:vieja_dir
endfunction
