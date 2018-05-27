scriptencoding utf-8

" Para usar en modo visual por líneas
vnoremap <C-k> xkP`[V`]
vnoremap <C-j> xjP`[V`]

" Para usar en modo visual de bloque
vnoremap <C-l> xp`[<C-V>`]
vnoremap <C-h> xhP`[<C-V>`]

" Para moverse seleccionando celdas
vnoremap J 2j
vnoremap K 2k
vnoremap L lt+
vnoremap H F+h
