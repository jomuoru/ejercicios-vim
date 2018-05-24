" Este es un archivo de configuración de vim que puede
" desactivar las flechas del teclado SOLO DENTRO DE LA
" SESIÓN ACTUAL DE VIM.
"
" Por defecto, solo el archivo de configuración llamado
" .vimrc se carga al inicio de vim.
" Si quieres que vim lea las configuraciones de este archivo
" escribe:
"
"   :source 1.2_Script_DesactivarFlechas.vim
"
" También puedes abreviar el nombre de este archivo por medio del
" caracter especial "%" que al usarlo en modo comando se
" reemplaza por el nombre del archivo:

"    :source %
"
scriptencoding utf-8

" Al hacer mapeos de teclas, los caracteres especiales se escriben
" entre corchetes angulares "<>"

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

" Por si te lo preguntabas, <nop> significa "no operation"

" Para regresar a la lección presiona 'gF' sobre el nombre
" de archivo escrito a continuación:
"       1.2_ComenzandoAMoverse.txt:10
