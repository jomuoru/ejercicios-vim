scriptencoding utf-8

" Se establece que la función de completado con <C-x><C-u> sea la función
" CompletarMeses que se define a continuación
set completefunc=CompletarMeses

" Se define la función personalizada de completado
" Este tipo de función es invocada dos veces para cada intento se uso.
" La primera vez se recibe 1 como primer argumento y una base vacía y debe
" de retornarse la posición de inicio de la palabra a completar.
" En la segunda invocación se recibe 0 como primer argumento
" que la segunda vez se recibirá 0 como primer argumento y como base el
" texto que se va a completar
function! CompletarMeses(primera_llamada, base)
    if a:primera_llamada
        " Ubicar el inicio de la palabra buscando la primera vocal
        let l:linea = getline('.')
        let l:posicion_inicio = col('.') - 1

        " =~ es el operador "match" para corroborar que un texto coincida
        " con una expresión regular
        while l:posicion_inicio > 0 && l:linea[l:posicion_inicio - 1] =~ '\a'
            let l:posicion_inicio -= 1
        endwhile
        return l:posicion_inicio
    else
        " Regresa los datos que coincidan con el nombre del mes
        let l:meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo',
                     \ 'Junio', 'Agosto', 'Septiembre', 'Octuber',
                     \ 'Noviembre', 'Diciembre']

        let l:respuesta = []
        for l:mes in l:meses
            if l:mes =~ '^' . a:base
                " Cada elemento que coincida se añade a la lista
                call add(l:respuesta, l:mes)
            endif
        endfor

        " La lista final representara los posibles completados
        return l:respuesta
    endif
endfun
