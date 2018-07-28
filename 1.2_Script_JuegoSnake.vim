" Juego de snake implementado en VimL
"
" Se puede interpretar el archivo con:
"   :so %
"
" Posteriormente, se puede iniciar el juego tantas veces se quiera con:
"   :JugarSnake

scriptencoding utf-8
command! JugarSnake :call s:jugarSnake()

let s:serpiente = []
let s:direccion = ''

let s:movimiento = {
                 \ 'izquierda': { 'dx': -1, 'dy':  0},
                 \ 'derecha':   { 'dx': +1, 'dy':  0},
                 \ 'arriba':    { 'dx':  0, 'dy': -1},
                 \ 'abajo':     { 'dx':  0, 'dy': +1},
                 \ }

let s:pantalla = []

function! s:jugarSnake()
    let l:semilla = localtime()

    " Crear un buffer especial para el juego
    silent edit '~~~~ VIVORITA ~~~~'

    " Re-Establecer todo el nuevo buffer a la configuración por defecto
    setlocal all&
    setlocal colorcolumn& " Por alguna extraña razón del infierno la opción
                          " "all" no incluye a colorcolumn

    let s:serpiente = [{'x': 4, 'y': 2}, {'x': 3, 'y': 2}, {'x': 2, 'y': 2}]
    let s:direccion = 'derecha'

    " Revisar las dimensiones de la pantalla de juego
    let l:ancho = winwidth(0) / 2
    let l:alto  = winheight(0)

    " Configurar los colores para los diferentes elementos
    call s:crearPantalla(l:ancho, l:alto)
    let l:coor_comida = s:crearComida(l:ancho, l:alto)

    let l:has_perdido = 0

    call s:dibujarPantalla()
    call s:dibujarCaracter(3, 2, '*')
    call s:dibujarCaracter(4, 2, '*')

    while !l:has_perdido
        let l:tecla_presionada = nr2char(getchar(0))

        call s:actualizarDireccion(l:tecla_presionada)
        let l:pudo_comer = s:actualizarSerpiente(l:coor_comida)
        if l:pudo_comer == 1
            let l:coor_comida = s:crearComida(l:ancho, l:alto)
        endif

        let l:has_perdido = s:comprobarColision(s:serpiente)

        if l:tecla_presionada ==# 'c' || l:has_perdido == 1
            break
        endif

        call s:moverSerpiente(l:coor_comida)

        if l:tecla_presionada ==# 'q'
            break
        endif

        sleep 100ms
        redraw
    endwhile

    let l:mensaje_final = 'Presione una tecla para continuar . . .'
    let l:mensaje_final = repeat(' ', l:ancho - strlen(l:mensaje_final) / 2)
                      \ . l:mensaje_final
    call setline(l:alto / 2, l:mensaje_final) | redraw
    call getchar()
    bdelete!
endfunction

function! s:actualizarDireccion(tecla)
    if a:tecla ==# 'h'
        if s:direccion !=# 'derecha'
            let s:direccion = 'izquierda'
        endif
    elseif a:tecla ==# 'l'
        if s:direccion !=# 'izquierda'
            let s:direccion = 'derecha'
        endif
    elseif a:tecla ==# 'k'
        if s:direccion !=# 'abajo'
            let s:direccion = 'arriba'
        endif
    elseif a:tecla ==# 'j'
        if s:direccion !=# 'arriba'
            let s:direccion = 'abajo'
        endif
    endif
endfunction

function! s:actualizarSerpiente(comida)
    let l:cabeza = s:serpiente[0]
    let l:dx = s:movimiento[s:direccion].dx
    let l:dy = s:movimiento[s:direccion].dy
    let l:nueva_cabeza = {'x': l:cabeza.x + l:dx, 'y': l:cabeza.y + l:dy}

    let s:serpiente = [l:nueva_cabeza] + s:serpiente[0:-2]

    if l:nueva_cabeza.x == a:comida.x && l:nueva_cabeza.y == a:comida.y
        let s:serpiente = s:serpiente + [s:serpiente[-1]]
        return 1
    endif

    return 0
endfunction

function! s:moverSerpiente(comida)
    let l:cabeza = s:serpiente[0]
    let l:cola   = s:serpiente[-1]
    call s:dibujarCaracter(l:cabeza.x, l:cabeza.y, '*')
    call s:dibujarCaracter(l:cola.x, l:cola.y, ' ')
    call s:dibujarCaracter(a:comida.x, a:comida.y, 'o')
endfunction

function! s:comprobarColision(cuerpoSerp)
    let l:x_serp = a:cuerpoSerp[0].x
    let l:y_serp = a:cuerpoSerp[0].y

    let l:caracterBajoSerpiente = getline(l:y_serp)[l:x_serp * 2 - 1]
    if l:caracterBajoSerpiente ==# '+'
        return 1 " Chocó contra el muro
    endif

    if l:caracterBajoSerpiente ==# '*'
        return 1 " Chocó contra si misma
    endif

    return 0
endfunction

function! s:crearPantalla(ancho, alto)
    let l:ancho_interno = a:ancho - 2
    let l:alto_interno  = a:alto  - 2

    let s:pantalla = repeat([repeat('+', a:ancho * 2)], a:alto)

    for l:fila in range(1, l:alto_interno)
        let s:pantalla[l:fila] = '++'
                             \ . repeat(' ', l:ancho_interno * 2)
                             \ . '++'
    endfor
endfunction

function! s:dibujarPantalla()
    " Dibuja el contenido de la lista "s:pantalla" en la pantalla
    call setline(1, s:pantalla)
endfunction

function! s:crearComida(ancho, alto)
    let l:x = s:aleatorio(a:ancho - 2) + 2
    let l:y = s:aleatorio(a:alto - 2) + 2

    " Dibujar el carácter en pantalla
    call s:dibujarCaracter(l:x, l:y, 'o')
    return {'x': l:x, 'y': l:y}
endfunction

function! s:dibujarCaracter(x, y, char)
    execute 'normal!' . a:y . 'G' . (2 * a:x) . '|r' . a:char
endfunction

function! s:aleatorio(max)
    let l:num = system('echo $RANDOM')[0:2]
    return l:num % a:max
endfunction
