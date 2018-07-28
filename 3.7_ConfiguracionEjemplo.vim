"                         _____    ___     _____ __  __
"                       | ____|  | \ \   / /_ _|  \/  |
"                       |  _| _  | |\ \ / / | || |\/| |
"                       | |__| |_| | \ V /  | || |  | |
"                       |_____\___/   \_/  |___|_|  |_|
"                       _______________________________
"                          Configuración de ejemplo
"
" Esta configuración está dividida en secciones que estarán por defecto
" ocultas en caso de que esté visualizando esto dentro de vim.
" Para abrir o cerrar una sección se debe presionar 'za' en modo normal.
"
" A pesar del nombre, esta es una configuración de vim completa y funcional
" que puede usar directamente. En caso de que ya la este usando, también
" puede abrir y cerrar una sección presionando espacio en modo normal.
"
" Si tiene duda de cualquier cosa escrita en este archivo recuerde que
" el sistema de ayuda integrado es su mejor amig@. Simplemente escriba:
"   :help cosa_de_la_que_quieres_ayuda<return>
"                     (<return> significa presionar enter)

" General {{{
set encoding=utf-8     " Codificación para usarse en los archivos
scriptencoding utf-8   " Codificación de ESTE script (para usar comandos con ñ)
set mouse=a            " El ratón podrá usarse para cambiar la posición del cursor
set noerrorbells       " Sin beeps cuando hay error

let g:mapleader = ','  " La tecla líder es , porque está a la mano

" Si se quiere usar un manejador de plugins establecer la siguiente línea
" a un valor verdadero
let g:usar_manejador_plugins = 0
if g:usar_manejador_plugins
    let l:path_manejador_plugins = expand('~/.vim/autoload/plug.vim')

    if !filereadable(l:path_manejador_plugins)
        echo "Se instalará el manejador de plugins Vim-Plug..."
        echo ""
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        " Como se acaba de descargar el manejador de plugins lo cargamos
        " manualmente con la siguiente línea (De otro modo se requeriría
        " reiniciar vim)
        execute 'source ' . fnameescape(l:path_manejador_plugins)
    endif

    " Entre las llamadas a plug#begin() y plug#end() se colocan los
    " plugins que quiera el usuario con la siguiente sintaxis:
    "    Plug 'ruta/del/plugin'
    "
    " La ruta del plugin puede ser un proyecto de github con la siguiente
    " sintaxis:
    "   usuario/nombre_del_proyecto
    "
    " También puede ser una url de git válida:
    "   https//url/de/algun/repositorio.git
    call plug#begin('~/.vim/plugged')
    " A continuación algunos plugins recomendados (Descomentalos si los
    " quieres usar):
    "Plug 'sheerun/vim-polyglot'    " Syntaxis de múltiples lenguajes
    call plug#end()
endif

" Activar detección del tipo de archivo
filetype plugin indent on

" Usar bash como shell predeterminada
set shell=/bin/bash
" }}}

" Titulo de ventana e información varia {{{
" Título e info de la posición y el comando actual
set title             " El título de la consola no será el argumento a vim

set showcmd           " Mostrar comandos incompletos
set laststatus=2      " Siempre mostrar la barra de estado
" Línea de estado
set statusline=%f\                          " Nombre de archivo
set statusline+=[%Y]\                       " Tipo de archivo
set statusline+=\ %{getcwd()}               " Directorio actual
set statusline+=%=columna:%2c\ linea:%2l    " Línea y colúmna

" Menú de modo comando
"set path+=**         " Búsqueda recursiva de archivos
set wildmode=longest,list,full
set wildmenu          " Completado visual de opciones en el comandos :*
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

" Mostrar números de línea (posición actual en absoluto + el resto en relativo)
set number            " Mostrar número de línea global
set relativenumber    " Mostrar numeración relativa
set numberwidth=4     " Longitud de la sección de números

" Mostrar la posición del cursor en la línea de estado
set ruler

" Formato y longitud del texto
set textwidth=80      " La longitud del texto es 80 columnas
set colorcolumn=+1    " Resaltar la columna después de &textwidth (81)
augroup LongitudesArchivosEspeciales
    autocmd!
    " Los mensajes de un commit de git solo deben medir 72 caracteres
    autocmd FileType gitcommit setlocal spell textwidth=72
augroup END
" }}}

" Sintaxis, indentación y caracteres invisibles {{{
syntax on " Activar sintaxis

" Tema de color
set t_Co=256
set background=dark

" Resaltar la línea y la columna actual
" (Esto a veces se ve mal o distrae, comentar la línea con " si es el caso)
set cursorline
set cursorcolumn

" Resaltar espacios sobrantes de cada línea con un color naranja
" La primera línea crea una clasificación de color
" La segunda línea asocia dicho color a una expresión regular
highlight EspaciosEnBlancoExtra ctermbg=172 guifg=#D78700
match EspaciosEnBlancoExtra /\s\+$/

" Resaltar señales de conflicto en un merge de git
highlight Conflicto ctermbg=1 guifg=#FF2233
2match Conflicto /\v^(\<|\=|\>){7}([^=].+)?$/

" Cuando y como mostrar caracteres invisibles
set list " Mostrar caracteres invisibles según las reglas de 'listchars'
set listchars=tab:»·,trail:·,extends:❯,precedes:❮
set concealcursor=   " Siempre desactivar conceal en la línea activa

" Cantidad de espacios para sangría
set tabstop=4     " Longitud de cada tabulación
set shiftwidth=4  " Tamaño de sangría
set softtabstop=4 " Simula la longitud de tab

function! CambiarIndentacion(espacios)
    " Cambia tres opciones por el precio de una llamada a función
    " Ejemplo de uso:
    "    :call Cambi<tab>
    "    (La tecla <tab> completa el nombre de la función)
    "    :call CambiarIndentacion(8)<return>
    " Ahora todo el código tendra una sangría de ocho espacios
    let &tabstop     = a:espacios
    let &shiftwidth  = a:espacios
    let &softtabstop = a:espacios

    " Reindenta el código existente
    execute "normal! gg=G\<C-o>\<C-o>"
endfunction

" Otras configuraciones con respecto a la sangría
set expandtab     " Se sangra el código con espacios
set autoindent    " Añade la sangría de la línea anterior automáticamente
set smartindent   " Aplicar sangría cuando sea necesario
set shiftround    " Redondear el nivel de sangría
" }}}

" Ventanas, buffers y navegación {{{
" General
set virtualedit=onemore
set scrolloff=2       " Minimas líneas para mantener encima/debajo del cursor
"set scrolljump=3      " Lines que recorrer cuando el cursor sale de la pantalla

" Configuración de las líneas largas
" Si quiere que las líneas largas se envuelvan en la pantalla deje la siguiente
" variable con un valor verdadero. En caso contrario dele un valor falso
let g:envolver_lineas_largas = 1

if g:envolver_lineas_largas
    set wrap              " Envolver líneas largas
    set linebreak         " Rompe la línea cuando se llega a la longitud máxima
    set showbreak=...\    " En lineas largas, se muestran ... de continuación
    set breakindent       " Aplica sangría en los tres puntos de continuación
else
    set nowrap

    " Facilitar la navegación horizontal
    noremap zl zL
    noremap zh zH
endif

" Hacer el movimiento más intuitivo cuando hay líneas largas
set whichwrap=b,s,h,l,<,>,[,]    " Las teclas de dirección y borrar dan vuelva
nnoremap <silent> <expr> j 'gj'
nnoremap <silent> <expr> k 'gk'
nnoremap <silent> <expr> gj 'j'
nnoremap <silent> <expr> gk 'k'

" Separaciones de pantalla
set splitright  " Las separaciones verticales se abren a la derecha
set splitbelow  " Las separaciones horizontales se abren hacia abajo

" Abrir y cerrar separaciones fácilmente
nnoremap <leader>wo :only<return>
nnoremap <leader>wh :hide<return>
nnoremap \|   :vsplit<space>
nnoremap \|\| :vsplit<return>
nnoremap _    :split<space>
nnoremap __   :split<return>

" Moverse entre ventanas fácilmente
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j

" Mantener igualdad de tamaño en ventanas cuando el marco se redimensiona
augroup TamanioVentana
    autocmd!
    autocmd VimResized * :wincmd =
augroup end

" Abrir tabulaciones fácilmente
set tabpagemax=15    " Solo mostrar 15 tabs
nnoremap <leader>tn :tabnew<space>
nnoremap <leader>to :tabonly<return>

" Moverse entre tabulaciones
nnoremap <leader>th :tabfirst<return>
nnoremap <leader>tl :tablast<return>
nnoremap <leader>tj :tabprev<return>
nnoremap <leader>tk :tabnext<return>

" Abrir y moverse entre buffers
set hidden          " Permitir buffers ocultos
nnoremap <leader>bn :edit<space>
nnoremap <leader>bg :ls<return>:buffer<space>
nnoremap <leader>bh :bfirst<return>
nnoremap <leader>bk :bnext<return>
nnoremap <leader>bj :bprevious<return>
nnoremap <leader>bl :last<return>

" Cerrar ventana, buffer o tabulaciones
nnoremap <leader>bd  :bdelete!<return>

" Cambiar el directorio de trabajo al directorio del buffer actual
nnoremap <leader>cd :cd %:p:h<return>:pwd<return>

" Moverse entre inicio/medio/final de la pantalla
nnoremap <C-l> :call AlternarInicioMedioFinalComoEnEmacs()<return>
function! AlternarInicioMedioFinalComoEnEmacs()
    let l:lineas_ventana = (line('$') <= winheight('%') ? line('$') : winheight('%'))
    let l:linea_inicial = winline()

    normal! zb
    let l:linea_ultima = winline()

    if l:linea_inicial ==# l:linea_ultima
        normal! zt
    elseif l:linea_inicial !=# l:lineas_ventana / 2
        normal! z.
    endif

endfunction

" Movimiento estilo emacs en el modo comando
cnoremap <C-a> <home>
" <C-e> ya funciona como en emacs, la siguiente línea sería redundante
" cnoremap <C-e> <end>
cnoremap <C-b> <left>
cnoremap <C-f> <right>
cnoremap <M-b> <S-left>
cnoremap <M-f> <S-right>

" Dobleces
set foldenable    " Habilitar dobleces
set foldcolumn=1  " Una columna para mostrar la extensión de un dobles
"set foldmethod=indent   " Descomentar si quieren que se creen dobleces
" por cada nivel de sangría
" Abrir y cerrar dobleces con espacio
nnoremap <space>   za
" }}}

" Ayudas en la edición {{{
" Algunas opciones cuerdas que nadie sabe por que no vienen por defecto
set backspace=2       " La tecla de borrar funciona normal
set undolevels=10000  " Poder deshacer cambios hasta el infinito y más allá
set undoreload=10000  " El historial para deshacer cambios se guarda completo
set history=1000      " Un historial de comandos bastante largo
set lazyredraw        " No redibujar la interfaz a menos que sea necesario
set nrformats-=octal  " Fuck you octal, nadie te quiere en este siglo
set nojoinspaces      " No insertar dos espacios trás signo de puntuación

" Caracteres emparejados
set showmatch         " Resaltar los paréntesis/corchetes correspondientes
set matchpairs+=<:>   " Saltar también entre paréntesis angulares hermanos con %

" Copiando y pegando
set nopaste           " 'paste' estará desactivada por defecto
set pastetoggle=<F2>  " Botón para activar/desactivar 'paste'
" Copiar y pegar por medio de la papelera del sistema si se puede
if has('clipboard')
    if has('unnamedplus') " Cuando se pueda usar el registro + para copiar-pegar
        set clipboard=unnamed,unnamedplus
    else " En mac y windows se usa el registro * para copiar-pegar
        set clipboard=unnamed
    endif
endif

" Manejo de registros por medio de la letra ñ
nnoremap " ñ
vnoremap " ñ

" Hacer que Y actúe como C y D
noremap Y y$

" Copiar linea actual por arriba y por debajo
nnoremap <M-y> yyP
nnoremap <M-Y> yyp

" Añadir línea vacía por arriba y por debajo
nnoremap <M-o> :call append(line('.'), '')<return>
nnoremap <M-O> :call append(line('.')-1, '')<return>

" Mover lineas visuales hacia arriba y hacia abajo
nnoremap <M-j> :move +<return>==
nnoremap <M-k> :move -2<return>==
vnoremap <M-j> :move '>+1<return>gv=gv
vnoremap <M-k> :move '<-2<return>gv=gv

" Mover bloques visuales a la izquierda y a la derecha
nnoremap <M-l> xp
nnoremap <M-h> xhP
vnoremap <M-l> xp`[<C-V>`]
vnoremap <M-h> xhP`[<C-V>`]

" Mantener el modo visual después de > y <
vnoremap < <gv
vnoremap > >gv

" Cero alterna entre primer carácter visible y primer columna de línea
" y $ alterna entre ultimo carácter visible y última columna
nnoremap <silent> 0 :call VisibleOAbsoluto('inicio')<return>
nnoremap <silent> $ :call VisibleOAbsoluto('final')<return>

function! VisibleOAbsoluto(direccion)
    let l:col_inicial = col('.')

    " Nos movemos al primer carácter visible y revisamos la nueva columna
    if a:direccion ==# 'inicio'
        normal! ^
    else
        normal! g_
    endif
    let l:col_caracter_visible = col('.')

    " Si no nos hemos movido es que ya estábamos en la primera/ultima
    " columna con un carácter visible. Entonces vamos al principio/final
    " absoluto de la línea
    if l:col_inicial == l:col_caracter_visible
        if a:direccion ==# 'inicio'
            normal! 0
        else
            normal! $
        endif
    endif
endfunction

" Rodear texto entre un carácter específico
nnoremap <leader>s :call RodearPalabra()<return>
vnoremap <leader>s <esc>:call RodearSeleccion()<return>

function! RodearPalabra()
    let l:leido = nr2char(getchar())
    let [l:car_apertura, l:car_cierre] = CaracteresHermanos(l:leido)

    execute "normal! viw\<esc>a"
                \ . l:car_cierre
                \ . "\<esc>"
                \ . "hviwo\<esc>i"
                \ . l:car_apertura
                \ . "\<esc>lel"
endfunction

function! RodearSeleccion()
    let l:leido = nr2char(getchar())
    let [l:car_apertura, l:car_cierre] = CaracteresHermanos(l:leido)

    execute 'normal! `>a'
                \ . l:car_cierre
                \ . "\<esc>"
                \ . '`<i'
                \ . l:car_apertura
                \ . "\<esc>"
endfunction

function! CaracteresHermanos(caracter)
    if a:caracter ==# '(' || a:caracter ==# ')'
        let [l:car_inicial, l:car_final] = ['(', ')']
    elseif a:caracter ==# '{' || a:caracter ==# '}'
        let [l:car_inicial, l:car_final] = ['{', '}']
    elseif a:caracter ==# '<' || a:caracter ==# '>'
        let [l:car_inicial, l:car_final] = ['<', '>']
    else
        let [l:car_final, l:car_inicial] = [a:caracter, a:caracter]
    endif

    return [l:car_inicial, l:car_final]
endfunction

" Objeto de texto "línea" para operar con los operadores comunes
xnoremap il g_o^
onoremap il :<C-u>normal vil<return>

xnoremap al $o0
onoremap al :<C-u>normal val<return>

" Objecto de texto "buffer"
xnoremap i% GoggV
onoremap i% :<C-u>normal vi%<return>
xnoremap a% GoggV
onoremap a% :<C-u>normal vi%<return>

" Objeto de texto "comentario de bloque"
vnoremap ic ?<C-r>=escape(split(&commentstring, "%s")[0], '/*')<return><return>+0o
          \ /<C-r>=escape(split(&commentstring, "%s")[1], '/*')<return><return>-$
onoremap ic :<C-u>normal vic<return>

vnoremap ac ?<C-r>=escape(split(&commentstring, "%s")[0], '/*')<return><return>o
          \ /<C-r>=escape(split(&commentstring, "%s")[1], '/*')<return><return>l
onoremap ac :<C-u>normal vac<return>

" Hacer que ctrl-c funcione como en otros programas
vnoremap <C-c> "+y
nnoremap <C-C> "+yy

" Regresar rápido a modo normal (la opción que prefieras)
inoremap kj <Esc>
inoremap jk <Esc>

" Elimina el retraso cuando se presiona escape en modo inserción
set ttimeout
set ttimeoutlen=1
" }}}

" Búsqueda y reemplazo {{{
" Configuraciones generales
set incsearch         " Hacer las búsquedas incrementales
set ignorecase        " No diferenciar mayúsculas/minúsculas
set smartcase         " Ignorecase si la palabra empieza por minúscula
set hlsearch          " Al buscar texto se resaltan las coincidencias
set magic             " Se usa el modo 'mágico' de búsqueda/reemplazo

" Usar el operador punto en una selección visual
vnoremap . :normal .<return>

" Reemplazar palabra bajo el cursor globalmente
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<left><left>

" No moverse cuando se busca con * y #
nnoremap * *N
nnoremap # #N

" Usar * y # en modo visual busca texto seleccionado y no la palabra actual
vnoremap * :<C-u>call SeleccionVisual()<return>/<C-R>=@/<return><return>N
vnoremap # :<C-u>call SeleccionVisual()<return>?<C-R>=@/<return><return>N

function! SeleccionVisual() range
    let l:registro_guardado = @"
    execute 'normal! vgvy'

    let l:patron = escape(@", "\\/.*'$^~[]")
    let l:patron = substitute(l:patron, "\n$", '', '')

    let @/ = l:patron
    let @" = l:registro_guardado
endfunction

" Ver la línea de la palabra buscada en el centro
nnoremap n nzzzv
nnoremap N Nzzzv

" Saltar entre conflictos merge
nnoremap <silent> <leader>ml /\v^(\<\|\=\|\>){7}([^=].+)?$<return>
nnoremap <silent> <leader>mh ?\v^(\<\|\=\|\>){7}([^=].+)\?$<return>

" Desactivar el resaltado de búsqueda
nnoremap // :nohlsearch<return>
" }}}

" Guardando, saliendo y regresando a vim {{{
" Formato para los saltos de línea
set fileformats=unix,dos,mac

" Guardado y lectura automática
set autowrite         " Guardado automático al cambiar de archivo
set autoread          " Recargar el archivo si hay cambios

" Generalmente alcanza con Git para versionar. En caso de querer un manejo de
" respaldos mas "local" definir la siguiente variable con un valor verdadero
let g:usar_respaldo_local = 0
if g:usar_respaldo_local
    " Directorio para guardar los archivos swap
    set directory=$HOME/.vim/swap//

    if !isdirectory(&directory)
        call mkdir(&directory, 'p') " Crea el directorio de swap si no existe
    endif

    set backupdir=$HOME/.vim/backup//

    if !isdirectory(&backupdir)
        call mkdir(&backupdir, 'p')
    endif

    set backupcopy=yes
    set backup            " Hacer el respaldo
    set swapfile          " Archivo swap para el buffer
else
    set nobackup          " Sin respaldo
    set nowritebackup     " No guardar respaldo (no tiene sentido)
    set noswapfile        " Sin archivo swap para el buffer actual
endif

" Para que shift en modo comando no moleste
command! -bang -nargs=* -complete=file E  e<bang> <args>
command! -bang -nargs=* -complete=file W  w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wqa wqa<bang>
command! -bang WQa wqa<bang>
command! -bang WQA wqa<bang>

" Crear sesión (con un nombre específico o con el nombre por defecto)
nnoremap <leader>ms  :mksession!<space>
nnoremap <leader>mds :mksession! ~/.vim/session/default<return>
if !isdirectory('~/.vim/session/')
    call mkdir('~/.vim/session/', 'p')
endif

augroup ComandosAutomaticosGuardarLeer
    autocmd!
    " Eliminar espacios sobrantes cada que se guarde el archivo
    " (Si no quieres que esto pase, comenta esta línea con un ")
    autocmd BufWritePre * :%s/\s\+$//e

    " Abrir vim en la última posición editada del archivo
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                \ |           execute "normal! g`\""
                \ |       endif
augroup END

" Guardar con sudo (cuando entraste a vim sin sudo, se pedirá contraseña)
cnoremap w!! !sudo tee % > /dev/null
"}}}

" Compilación y revisión de errores {{{
augroup makecomnads " Definiendo :make según el tipo de archivo
    autocmd!
    autocmd Filetype c          setlocal makeprg=gcc\ %\ -std=gnu11\ -o\ %:t:r\ -lm\ -pthread\ -lX11\ -Wall\ -Wextra
    autocmd Filetype cpp        setlocal makeprg=g++\ %\ -std=c++14\ -o\ %:t:r\ -Wall\ -Wextra\ -lm
    autocmd Filetype fortran    setlocal makeprg=gfortran\ %\ -o\ %:t:r\ -Wall\ -Wextra
    autocmd Filetype java       setlocal makeprg=javac\ %
    autocmd Filetype html       setlocal makeprg=xdg-open\ %
    autocmd Filetype python     setlocal makeprg=flake8\ %
    autocmd Filetype cs         setlocal makeprg=mcs\ %
    autocmd Filetype sh         setlocal makeprg=bash\ -n\ %
    autocmd Filetype haskell    setlocal makeprg=ghc\ %\ -dynamic
augroup END

" F9 para compilar y ejecutar
nnoremap <F9> :make<bar>call EjecutarSiNoHayErrores()<return>

function! EjecutarSiNoHayErrores()
    if len(getqflist()) ==# 0        " Run the program
        " Si no hay errores se intenta ejecutar el programa
        " Esto no funcionara en neovim (usar la terminal integrada
        " en su lugar)
        if ( &filetype ==# 'c' ||
                    \ &filetype ==# 'cpp' ||
                    \ &filetype ==# 'haskell' ||
                    \ &filetype ==# 'fortran')

            !./%:t:r
        elseif (&filetype ==# 'java')
            !java %:t:r
        elseif (&filetype ==# 'python')
            !python3 %
        elseif (&filetype ==# 'sh')
            !bash %
        endif
    else
        " Si hay errores se abren en una lista interna
        copen
        setlocal nospell
    endif
endfunction
"}}}

" Edición y evaluación de la configuración de vim. Evaluación de comandos {{{
" Modificar y evaluar el archivo de configuración principal y el de plugins
nnoremap <leader>av :tabnew $MYVIMRC<return>
nnoremap <leader>sv :source $MYVIMRC<return>
nnoremap <leader>al :tabnew ~/.vimrc.plugins<return>
nnoremap <leader>sl :source ~/.vimrc.plugins<return>

" Evaluar por medio de la consola externa por medio de Q
nnoremap Q !!$SHELL<return>
vnoremap Q !$SHELL<return>

" Evaluación de un comando de modo normal por medio de <leader>evn
nnoremap <leader>evn ^vg_y@"
vnoremap <leader>evn y@"

" Evaluación de un comando de VimL (modo comando) por medio de <leader>evv
nnoremap <leader>evv :execute getline(".")<return>
vnoremap <leader>evv :<C-u>
                   \       for linea in getline("'<", "'>")
                   \ <bar>     execute linea
                   \ <bar> endfor
                   \ <return>
" }}}

" Configuración para archivos grandes {{{
let g:DiesMegas = 10 * 1024 * 1024
augroup ArchivoGrande
    autocmd!
    autocmd BufReadPre * let t=getfsize(expand("<afile>"))
                     \ | if t > g:DiesMegas || t == -2
                     \ |     call ArchivoGrande()
                     \ | endif
augroup END

function! ArchivoGrande()
    " Esta función es llamada cuando el archivo supera 10M de longitud
    set eventignore+=FileType  " Sin resaltado y demás cosas dependientes del tipo
    setlocal bufhidden=unload  " Guardar memoria cuando otro archivo es usado
    setlocal undolevels=-1     " Sin historial de cambios
endfunction
" }}}

" Completado, etiquetas, diccionarios y revisión ortográfica {{{
set complete+=i        " Completar palabras de archivos incluidos

" Generar etiquetas de definiciones y comando "go to definition"
set tags=./tags;/,~/.vimtags
nnoremap <leader>ut !ctags -R .&<return> nnoremap <leader>gd <C-]>

" Algunas abreviaciones para lenguajes como c, c++ y java
" El problema de estas abreviaciones es que se pueden usar en cualquier
" tipo de archivo aunque algunas no sirvan mas que en algunos.
" Una solución mejor es usar plugins de manejo de snippets.
iabbrev for  for (int i = 0; i <; i++) {<return>}<esc>kf<a
iabbrev forr for (int i =; i >= 0; --i) {<return>}<esc>kf;i
iabbrev pf   printf("");<esc>2hi
iabbrev cl   cout << << endl;<esc>8hi
iabbrev pl   System.out.println();<esc>hi

" Revisión ortográfica
" Si se quiere revisión ortográfica establecer la siguiente variable a un valor
" verdadero
let g:activar_revision_ortorgrafica = 0

if g:activar_revision_ortorgrafica
    " Si se quire revisión ortográfica en español establecer la siguiente
    " variable a un valor verdadero
    let g:revision_otrografica_en_espaniol = 0
    set spell             " Activa la revisión ortográfica
    if g:revision_otrografica_en_espaniol
        set spelllang=es      " El idioma de revisión es español
        " Generalmente los sistemas operativos no cuentan con un diccionario
        " en español. La primera vez que se inicie vim (usando estas opciones)
        " se pedirá permiso para descargar el diccionario necesario. Basta con
        " aceptar para que vim haga el trabajo automaticamente
    else
        set spelllang=en
        set dictionary=/usr/share/dict/words " Usa el diccionario del sistema
    endif

    " Recorrer las palabras mal escritas y corregirlas
    nnoremap <leader>sl ]s
    nnoremap <leader>sh [s

    " Añadir una palabra a la lista blanca
    nnoremap <leader>sa zg

    " Mostar opcioens de corrección para una palabra mal escrita
    nnoremap <leader>sc z=
endif
"}}}

" vim: fdm=marker
