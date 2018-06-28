scriptencoding utf-8

" Para hacer que vim interprete el archivo actual:
"     :so[urce] %

" Comandos <C-K> y <C-J> para mover la selección visual arriba y abajo.
" Estos comandos se deben usar en modo visual de líneas.
vnoremap <C-K> xkP`[V`]
vnoremap <C-J> xjP`[V`]

" Comandos <C-L> y <C-H> para mover un bloque visual a la izquierda y
" a la derecha. Estos comandos se deben usar en modo visual de bloque.
vnoremap <C-L> xp`[<C-V>`]
vnoremap <C-H> xhP`[<C-V>`]

" Comandos J, K, L y H para moverse entre celdas
" Sirve para seleccionar celdas más fácilmente
vnoremap J 2j
vnoremap K 2k
vnoremap L lt+
vnoremap H F+h
