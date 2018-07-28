" Para cargar las configuraciones de este archivo escribe:
"
"   :so[urce] 1.2_Script_DesactivarFlechas.vim
"   (el texto entre corchetes es opcional)
"
" El nombre del script se puede sustituir con el símbolo especial "%"
" que al usarlo en modo comando se reemplaza por el nombre del archivo
" actual:
"    :so[urce] %
"

scriptencoding utf-8

" Hacer que las flechas no hagan nada en modo inserción
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Hacer que las flechas no hagan nada en el resto de modos
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

" <nop> significa "no operation"

" Para regresar a la lección presiona gF sobre el nombre
" de archivo escrito a continuación:
"       1.2_ComenzandoAMoverse.txt:20
