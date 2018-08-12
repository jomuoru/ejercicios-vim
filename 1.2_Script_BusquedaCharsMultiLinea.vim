" Aplicar el script con:
"
"       source %
"
scriptencoding utf-8

" noremap cubre nnoremap y onoremap
noremap <silent> f :call SiguienteChar(getchar(), 'adelante', 'inclusiva')<Return>
noremap <silent> F :call SiguienteChar(getchar(), 'atras', 'inclusiva')<Return>

noremap <silent> t :call SiguienteChar(getchar(), 'adelante', 'noinclusiva')<Return>
noremap <silent> T :call SiguienteChar(getchar(), 'atras', 'noinclusiva')<Return>

noremap <silent> ; :call RepetirBusqueda('misma_direccion')<Return>
noremap <silent> , :call RepetirBusqueda('direccion_contraria')<Return>

" Una variable global que sirve de caché
let s:busqueda_anterior = {
\   'caracter': 0,
\   'direccion': '',
\   'tipo': ''
\}

" Función que hace la búsqueda
function! SiguienteChar(codigo_char, direccion, tipo_busqueda)
    " Guardando los datos de búsqueda para futuras repeticiones
    let s:busqueda_anterior.caracter = a:codigo_char
    let s:busqueda_anterior.direccion = a:direccion
    let s:busqueda_anterior.tipo = a:tipo_busqueda

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
    if s:busqueda_anterior.caracter == 0
        " No hay búsqueda previa así que no se puede hacer repetición
        return
    endif

    " Se cambia la dirección si es necesario
    let l:vieja_dir = s:busqueda_anterior.direccion
    if a:direccion ==# 'direccion_contraria'
        if s:busqueda_anterior.direccion ==# 'adelante'
            let s:busqueda_anterior.direccion = 'atras'
        else
            let s:busqueda_anterior.direccion = 'adelante'
        endif
    endif

    " Se realiza la búsqueda
    call SiguienteChar(s:busqueda_anterior.caracter,
                     \ s:busqueda_anterior.direccion,
                     \ s:busqueda_anterior.tipo)

    " Regresando el estado original
    let s:busqueda_anterior.direccion = l:vieja_dir
endfunction
