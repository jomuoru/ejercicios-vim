" Una vez vim lea este script, las teclas de movimiento serán las
" siguientes:
"                            s
"                            ↑
"                       a  ←   →  f
"                            ↓
"                            d
"
" Para leer este archivo usa:
"   :so %
"
" Use este script solo si prefiere moverse con las teclas de la mano
" izquierda en lugar de la derecha.

scriptencoding utf-8

"       a <--> h
nnoremap a h
nnoremap h a
vnoremap a h
vnoremap h a
noremap A H
noremap H A

"       s <--> j
noremap s j
noremap S J
noremap j s
noremap J S

"       d <--> k
noremap d k
noremap D K
noremap k d
noremap K D

"       f <--> l
noremap f l
noremap F L
noremap l f
noremap L F

" Se puede hacer (casi) lo mismo con una sola línea
" set langmap=ah,AH,sj,SH,dk,DK,fl,FL
