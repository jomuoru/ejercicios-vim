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
" A pesar del nombre, esta es una configuración de vim completa y
" funcional que puede usar directamente. En caso de que ya la este
" usando, también puede abrir y cerrar una sección presionando espacio en
" modo normal.
"
" Si tiene duda de cualquier cosa escrita en este archivo recuerde que
" el sistema de ayuda integrado es su mejor amigo. Simplemente escriba:
"   :help cosa_de_la_que_quieres_ayuda<return>
"                     (<return> significa presionar enter)

" ##### General ##### {{{
set encoding=utf-8     " Codificación para usarse en los archivos
scriptencoding utf-8   " utf-8 para para usar comandos con ñ
set mouse=a            " Usar el ratón para mover/seleccionar/etc...
set noerrorbells       " Sin beeps cuando hay error
set visualbell         " Los alarmas visuales en lugar de sonoras
set exrc               " Usar .vimrc y .exrc locales
set secure             " Suprimir comandos inseguros en .exrc locales

" Caracteres de apertura y cierra
set showmatch         " Resaltar los paréntesis/corchetes correspondientes
set matchpairs+=<:>   " Saltar también entre paréntesis angulares hermanos
" % - Alternar entre inicio y final de (){}[], etc..

let g:mapleader = ','  " La tecla líder es , porque está a la mano

" Si se quiere usar un manejador de plugins establecer la siguiente variable a 1
let s:usar_plugins = 0
if s:usar_plugins
    let s:path_manejador_plugins = expand('~/.vim/autoload/plug.vim')

    if !filereadable(s:path_manejador_plugins)
        echomsg 'Se instalará el manejador de plugins Vim-Plug...'
        echomsg 'Creadndo directorio para el plugin'
        call mkdir(expand('~/.vim/autoload/'), 'p')
        if !executable('curl')
            echoerr 'Se requiere instalar curl o instalar vim-plug manualmente'
            quit!
        endif

        echomsg 'Descargando el plugin'
        !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        " Como se acaba de descargar el manejador de plugins lo cargamos
        " manualmente con la siguiente línea (De otro modo se requeriría
        " reiniciar vim)
        let s:manejador_plugins_recien_instalado = 1
    endif
    execute 'source ' . fnameescape(s:path_manejador_plugins)
endif

" Activar detección del tipo de archivo
filetype plugin indent on

" Usar bash como shell predeterminada
set shell=/bin/bash
" ### }}}

" ##### Plugins y sus configuraciones (solo si se han habilitado) ##### {{{
if s:usar_plugins
    " Todos los plugins tienen que ir entre plug#begin() y plug#end()
    call plug#begin('~/.vim/plugged')

    " Manejo de versiones y cambios
    Plug 'tpope/vim-fugitive'     " Manejo de git dentro de vim
    Plug 'airblade/vim-gitgutter' " Mostrar diferencias del archivo al editar
    Plug 'mbbill/undotree'        " Arbol de cambios gráfico
    " :GitGutterToggle - Activar y desactivar gitgutter

    " Completado y revisión de código
    if has('nvim') || (v:version >= 800 && has('python3'))
        if has('nvim')
            if !has('python3')
                echomsg 'No hay proveedor de python 3. Intentando instalar...'
                !pip3 install --upgrade neovim
            endif

            " Completado de código
            Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
        else
            Plug 'Shougo/deoplete.nvim'
            Plug 'roxma/nvim-yarp'
            Plug 'roxma/vim-hug-neovim-rpc'
        endif
        let g:deoplete#enable_at_startup = 1
        Plug 'w0rp/ale'                   " Revisión de sintaxis
    else
        if has('lua')                     " Se requiere lúa para neocomplete
            Plug 'Shougo/neocomplete'     " Completado de código
            let g:neocomplete#enable_at_startup = 1
        endif
        Plug 'Syntastic'                  " Revisión de sintaxis
    endif

    Plug 'Shougo/neosnippet'              " Gestor de plantillas de código
    Plug 'Shougo/neosnippet-snippets'     " Plantillas predefinidas
    " Ctrl-e (e de expand) para expandir plantillas de código
    imap <C-e> <Plug>(neosnippet_expand_or_jump)
    smap <C-e> <Plug>(neosnippet_expand_or_jump)
    xmap <C-e> <Plug>(neosnippet_expand_target)

    Plug 'Shougo/neoinclude.vim'          " Completado de cabeceras
    Plug 'mattn/emmet-vim', { 'for': ['html', 'xml', 'css', 'sass'] }
      " Ctrl-y + , (coma) - Completar abreviación emmet
      " Ctrl-y + n - Saltar al siguiente punto de edición de emmet
    Plug 'Shougo/neco-vim', { 'for': 'vim' }

    Plug 'tkhren/vim-fake'          " Texto muestra:faketext, lorems, etc...
    let g:fake_bootstrap = 1        " Cargar definiciones extra de vim-fake

    " Omnifunciones para completado de código
    augroup OmnifuncionesCompletado
        autocmd!
        autocmd FileType sql,html,css,javascript,php setlocal omnifunc=syntaxcomplete#Complete
    augroup END

    " Navegación y edición de texto
    Plug 'scrooloose/nerdtree'            " Árbol de directorios
    nnoremap <Leader>tgnt :NERDTreeToggle<Return>
    nnoremap <F5>         :NERDTreeToggle<Return>

    Plug 'majutsushi/tagbar'              " Árbol de navegación (Requiere ctags)
    nnoremap <Leader>tgtb :TagbarToggle<Return>
    nnoremap <F6>         :TagbarToggle<Return>

    "Plug 'xolox/vim-misc'                 " Requerimiento para el siguiente
    "Plug 'xolox/vim-easytags'             " Generación y manejo de etiquetas
    Plug 'kshenoy/vim-signature'          " Marcas visuales
    Plug 'tpope/vim-repeat'               " Repetir plugins con .
    Plug 'godlygeek/Tabular'              " Funciones para alinear texto
    Plug 'PeterRincker/vim-argumentative' " Objeto de texto 'argumento'
    Plug 'jiangmiao/auto-pairs'           " Completar pares de símbolos
    Plug 'KabbAmine/vCoolor.vim'          " Inserción de valores RGB
    nnoremap <leader>vc :VCoolor<return>
    Plug 'sedm0784/vim-you-autocorrect'   " Corrección de errores sintácticos
    " :EnableAutoCorrect - Activar autocorrección ortográfica
    " :DisableAutoCorrect - Desactivar autocorrección ortográfica
    Plug 'scrooloose/nerdcommenter'       " Utilidades para comentar código

    " Objetos de texto y operadores
    Plug 'michaeljsmith/vim-indent-object' " Objeto de texto 'indentado'
    Plug 'kana/vim-textobj-user'          " Requerimiento de los próximos
    Plug 'kana/vim-textobj-function'      " Objeto de texto 'función'
    Plug 'glts/vim-textobj-comment'       " Objeto de texto 'comentario'
    Plug 'saulaxel/vim-next-object'       " Objeto de texto 'siguiente elemento'
    Plug 'tpope/vim-surround'             " Encerrar/liberar secciones
    Plug 'tpope/vim-commentary'           " Operador comentar/des-comentar
    Plug 'vim-scripts/ReplaceWithRegister' " Operador para manejo de registros

    " Estilo visual y reconocimiento de sintaxis
    Plug 'rafi/awesome-vim-colorschemes'  " Paquete de temas de color
    Plug 'vim-airline/vim-airline'        " Línea de estado ligera
    Plug 'vim-airline/vim-airline-themes' " Temas de color para el plugin anterior
    Plug 'gregsexton/MatchTag'            " Iluminar etiqueta hermana (html/xml)
    Plug 'ap/vim-css-color'               " Colorear valores RGB
    Plug 'sheerun/vim-polyglot'           " Paquete de archivos de sintaxis

    call plug#end()

    if exists('s:manejador_plugins_recien_instalado')
        PlugInstall
    endif
endif
" ### }}}

" ##### Titulo de ventana e información varia ##### {{{
" Título e información de la posición y el comando actual
set title             " El título de la consola no será el argumento a vim

set showcmd           " Mostrar comandos incompletos
set showmode          " Mostrar el modo actual
set laststatus=2      " Siempre mostrar la barra de estado
" Línea de estado (cuando los plugins estan desactivados)
set statusline=%f\                          " Nombre de archivo
set statusline+=[%Y]\                       " Tipo de archivo
set statusline+=\ %{getcwd()}               " Directorio actual
set statusline+=%=columna:%2c\ linea:%2l    " Línea y columna

" Menú de modo comando
"set path+=**         " Búsqueda recursiva de archivos
set wildmode=longest,list,full
set wildmenu          " Completado visual de opciones en el comandos :*
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

" Mostrar números de línea (posición actual en absoluto + el resto en relativo)
set number            " Mostrar número de línea global
set relativenumber    " Mostrar numeración relativa
" Activar y desactivar relativenumber (toggle relativenumber number)
nnoremap <Leader>trn :setlocal relativenumber!<Return>
nnoremap <F3>        :setlocal relativenumber!<Return>
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
" ### }}}

" ##### Sintaxis, indentación y caracteres invisibles ##### {{{
" +++ General +++ {{{
syntax on         " Activar sintaxis
set synmaxcol=200 " Solo resaltar primeros 200 caracteres

" Tema de color
set background=dark
" Usar 256 colores cuando sea posible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
endif
" Para ver los temas de color presionar :colorscheme + <Tab>
if s:usar_plugins
    colorscheme tender
endif

" Cuando y como mostrar caracteres invisibles
set list " Mostrar caracteres invisibles según las reglas de 'listchars'
if has('multi_byte') && &encoding ==# 'utf-8'
    set listchars=tab:»·,trail:·,extends:❯,precedes:❮
else
    set listchars=tab:>·,trail:·,extends:>,precedes:<
endif
if has('conceal')
    set conceallevel=2   " El texto con conceal está oculto o sustituido
    set concealcursor=   " Siempre desactivar conceal en la línea actual
endif
"   +++ }}}

" +++ Resaltado de elementos +++ {{{
" Resaltar la línea y la columna actual
set cursorline
set cursorcolumn

" Crear una clasificación de color llamada EspaciosEnBlancoExtra
highlight EspaciosEnBlancoExtra ctermbg=172 guifg=#D78700
" Resaltar todos los espacios (seleccionados mediante la expresión regular
" "\s\+$") sobrantes con el color de la línea anterior
match EspaciosEnBlancoExtra /\s\+$/

" Resaltar señales de conflicto en un merge de git (mismo método que la línea
" anterior)
highlight Conflicto ctermbg=1 guifg=#FF2233
2match Conflicto /\v^(\<|\=|\>){7}([^=].+)?$/
"   +++ }}}

" +++ Tabulado y sangría +++ {{{
" Cantidad de espacios para sangría
set tabstop=4     " Longitud de cada tabulación
set shiftwidth=4  " Tamaño de sangría
set softtabstop=4 " Simula la longitud de tab

function! CambiarIndentacion(espacios)
    " Cambia tres opciones por el precio de una llamada a función
    " Ejemplo de uso:
    "    :call Cambi<tab>
    "    (La tecla <tab> completa el nombre de la función)
    "    :call CambiarIndentacion(8)<Return>
    " Ahora todo el código tendrá una sangría de ocho espacios
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
set smarttab      " Usar tabs de acuerdo a 'shiftwidth'
"   +++ }}}
" ### }}}

" ##### Ventanas, buffers y navegación ##### {{{
" +++ General +++ {{{
set scrolloff=2         " Mínimas líneas por encima/debajo del cursor
set sidescrolloff=5     " Mínimas columas por la izquierda/derecha"
"set scrolljump=3        " Líneas que recorrer al salir de la pantalla
set virtualedit=onemore " Poder alcanzar la última posición de la pantalla
nnoremap <Leader>tve :call AlternarEdicionVirtual()<Return>
function! AlternarEdicionVirtual()
    if &virtualedit ==# 'onemore'
        let &virtualedit = 'all'
    else
        let &virtualedit = 'onemore'
    endif
endfunction

" Configuración de las líneas largas
" Si quiere que las líneas largas se envuelvan en la pantalla deje la
" siguiente variable con el valor 1. En caso contrario dele el valor 0
let s:envolver_lineas_largas = 1
if s:envolver_lineas_largas
    set wrap              " Envolver líneas largas
    set linebreak         " Rompe la línea cuando se llega a la longitud máxima
    set showbreak=...\    " En lineas largas, se muestran ... de continuación
    set breakindent       " Aplica sangría en los tres puntos de continuación
    set display+=lastline " No mostrar símbolos @ cuando la línea no cabe
else
    set nowrap            " No envolver líneas largas

    " Facilitar la navegación horizontal
    noremap zl zL
    noremap zh zH
endif

" Las flechas y el backspace dan la vuelta a través de las líneas
set whichwrap=b,s,h,l,<,>,[,]
"   +++ }}}

" +++ Ventanas +++ {{{
" Dirección para abrir nuevas ventanas (splits)
set splitright  " Las separaciones verticales se abren a la derecha
set splitbelow  " Las separaciones horizontales se abren hacia abajo
set diffopt+=vertical " Diffsplit prefiere orientación vertical
" :wincmd - Realizar un comando de ventanas

" Comandos para abrir y cerrar nuevas ventanas (splits)
nnoremap <Leader>wo :<C-u>only<Return>
nnoremap <Leader>wh :<C-u>hide<Return>
nnoremap \|   :<C-u>vsplit<Space>
nnoremap \|\| :<C-u>vsplit<Return>
nnoremap _    :<C-u>split<Space>
nnoremap __   :<C-u>split<Return>
" :ball - Convertir todos los buffers en ventanas
" :new - Crear nueva ventana vertical vacía
" :vnew - Crear nueva ventana horizontal vacía

" Comandos para movimiento entre ventanas
" <C-h> - Moverse a la ventana de la izquierda
" <C-l> - Moverse a la ventana de la derecha
" <C-k> - Moverse a la ventana de la arriba
" <C-j> - Moverse a la ventana de la abajo
" <C-w>t - Ir a la primera ventana
" <C-w>b - Ir a la última ventana
" <C-w>w - Ir a la siguiente ventana
" <C-w>W - Ir a la ventana anterior

" Comandos para cambiar la disposición (layout) de las ventanas
nnoremap <Leader><C-h> <C-w>H
nnoremap <Leader><C-l> <C-w>L
nnoremap <Leader><C-k> <C-w>K
nnoremap <Leader><C-j> <C-w>J
" <C-w>r - Rotar las ventanas en sentido normal
" <C-w>R - Rotar las ventanas en sentido inverso
" <C-w>x - Intercambiar ventana actual con la siguiente

" Redimensionar las ventanas
nnoremap <C-w>- :<C-u>call RepetirRedimensionadoVentana('-', v:count)<Return>
nnoremap <C-w>+ :<C-u>call RepetirRedimensionadoVentana('+', v:count)<Return>
nnoremap <C-w>< :<C-u>call RepetirRedimensionadoVentana('<', v:count)<Return>
nnoremap <C-w>> :<C-u>call RepetirRedimensionadoVentana('>', v:count)<Return>
" <C-w>= - Igualar el tamaño de todas las ventanas
" <C-w>_ - Establecer el tamaño de la ventana (por defecto el máximo)

function! RepetirRedimensionadoVentana(inicial, cuenta)
    let l:tecla = a:inicial
    let l:cuenta = a:cuenta ? a:cuenta : 0
    while stridx('+-><', l:tecla) != -1 || l:tecla =~# '\d'
        if l:tecla =~# '\d'
            let l:cuenta = l:cuenta * 10 + l:tecla
        else
            execute 'normal! ' . (l:cuenta ? l:cuenta : 1) . "\<C-w>" . l:tecla
            let l:cuenta = 0
            redraw
        endif
        let l:tecla = nr2char(getchar())
    endwhile
endfunction

" Hacer diff de las ventanas abiertas
nnoremap <Leader>tdm :call AlternarModoDiff()<Return>
nnoremap <F4> :call AlternarModoDiff()<Return>
let s:modoDiffActivado = 0
function! AlternarModoDiff()
    if s:modoDiffActivado
        windo diffoff
        let s:modoDiffActivado = 0
    else
        windo diffthis
        let s:modoDiffActivado = 1
    endif
endfunction

" Hacer diff entre de cambios no guardados
nnoremap <Leader>do :DiffOrigen<Return>
command! DiffOrigen vert new | set buftype=nofile | read ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

" vim -d <archivo1> <archivo2> - Abrir archivos en modo diff

" Mantener igualdad de tamaño en ventanas cuando el marco se redimensiona
augroup TamanioVentana
    autocmd!
    autocmd VimResized * :wincmd =
augroup end
"   +++ }}}

" +++ Tabulaciones +++ {{{
set tabpagemax=15    " Solo mostrar 15 tabs
" :tabs - Listar las tabulaciones y sus contenidos
" :tabdo - Ejecutar comando en todas las tabs existentes

" Comandos para abrir y cerrar tabulaciones
nnoremap <Leader>tn :tabnew<Space>
nnoremap <Leader>to :tabonly<Return>
" :tab all - Convertir buffers en tabs
" :tabfind - Intentar abrir archivo en 'path'
" <C-w>gf  - Abrir tab y editar archivo bajo el cursor
" Convertir ventana actual en tabulación
nnoremap <Leader>tw <C-w>T

" Moverse entre tabulaciones
nnoremap <Leader>th :tabfirst<Return>
nnoremap <Leader>tl :tablast<Return>
nnoremap <Leader>tj :tabprevious<Return>
nnoremap <Leader>tk :tabnext<Return>
" gt - Ir a la tabulación N

" Mover la tabulación actual
nnoremap <Leader>t- :tabmove -<Return>
nnoremap <Leader>t+ :tabmove +<Return>
nnoremap <Leader>t< :tabmove 0<Return>
nnoremap <Leader>t> :tabmove $<Return>

" Un "modo" especial que abrevia las operaciones con tabulaciones
nnoremap <silent> <Leader>tm :<C-u>call ModoAccionTabulacion()<Return>

function! ModoAccionTabulacion()
    if tabpagenr('$') == 1
        echomsg 'Modo tab requere más de una tabulación'
        return
    endif

    echomsg 'Modo tab. hljk+->< para controlar tabs, cualquier otra cosa para salir'
    let l:tecla = nr2char(getchar())
    let l:aciones = {
                \'h': 'tabfirst',    'l': 'tablast',
                \'j': 'tabprevious', 'k': 'tabnext',
                \'<': 'tabmove 0',   '>': 'tabmove $'
                \}

    while stridx('hljk+-><', l:tecla) != -1
        if stridx('hljk><', l:tecla) != -1
            execute l:aciones[l:tecla]
        else
            if (l:tecla ==# '+' && tabpagenr() != tabpagenr('$'))
                        \ || (l:tecla ==# '-' && tabpagenr() != 1)
                execute 'tabmove ' . l:tecla
            endif
        endif
        redraw
        let l:tecla = nr2char(getchar())
    endwhile
endfunction
"   +++ }}}

" +++ Buffers +++ {{{
set hidden          " Permitir buffers ocultos
" bufdo - Ejecutar un comando a través de todos los buffers

" Abrir y moverse entre buffers
nnoremap <Leader>bn :edit<Space>
" gf - Editar el archivo bajo el cursor en un nuevo buffer
nnoremap <Leader>bg :ls<Return>:buffer<Space>
nnoremap <Leader>bh :bfirst<Return>
nnoremap <Leader>bk :bnext<Return>
nnoremap <Leader>bj :bprevious<Return>
nnoremap <Leader>bl :last<Return>

" Cerrar ventana, buffer o tabulaciones
nnoremap <Leader>bd  :bdelete!<Return>

" Cambiar el directorio de trabajo al directorio del buffer actual
nnoremap <Leader>cd :cd %:p:h<Return>:pwd<Return>
"   +++ }}}

" +++ Movimiento en modo normal +++ {{{
" Moverse por líneas visuales en lugar de lineas lógicas
nnoremap <silent> <expr> j 'gj'
nnoremap <silent> <expr> k 'gk'
nnoremap <silent> <expr> gj 'j'
nnoremap <silent> <expr> gk 'k'

" Moverse entre inicio/medio/final de la pantalla
nnoremap <C-l> :call AlternarInicioMedioFinalComoEnEmacs()<return>
function! AlternarInicioMedioFinalComoEnEmacs()
    let l:lineas_ventana = (line('$') <= winheight('%') ? line('$') : winheight('%'))
    let l:linea_inicial = winline()

    normal! zb
    let l:linea_ultima = winline()

    if l:linea_inicial == l:linea_ultima
        normal! zt
    elseif l:linea_inicial != l:lineas_ventana / 2
         \ && l:linea_inicial != l:lineas_ventana / 2 + 1
        normal! z.
    endif

endfunction

" Cero (o en su defecto <Home>) alterna entre primer carácter visible y primer
" columna de línea y $ (o <End>) alterna entre ultimo carácter visible y
" última columna
nnoremap <silent> 0 :call VisibleOAbsoluto('inicio')<Return>
nnoremap <silent> $ :call VisibleOAbsoluto('final')<Return>
nmap <silent> <Home> 0
nmap <silent> <End>  $

function! VisibleOAbsoluto(direccion)
    let l:col_inicial = col('.')

    if a:direccion ==# 'inicio'
        normal! ^
    else
        normal! g_
    endif
    let l:col_tras_moverse = col('.')

    if l:col_inicial == l:col_tras_moverse
        if a:direccion ==# 'inicio'
            normal! 0
        else
            normal! $
        endif
    endif
endfunction
"   +++ }}}

" +++ Movimiento en modo comando +++ {{{
cnoremap <C-a> <Home>
" <C-e> - Ir al final de la línea en modo comando
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>
cnoremap <C-d> <Del>
cnoremap <A-d> <S-Right><C-w>
cnoremap <A-D> <C-e><C-u>
"   +++ }}}

" +++ Dobleces (folds) +++ {{{
set foldenable    " Habilitar dobleces
set foldcolumn=1  " Una columna para mostrar la extensión de un dobles
"set foldmethod=indent   " Crear dobleces según el nivel de sangría
" Crear y eliminar dobleces
" :fold o zf -  sirven para crear dobleces
" zd - elimina el doblez más cercano
" zD - elimina dobleces recursivamente
" zE - elimina todos los dobleces de la ventana

" Abrir y cerrar dobleces
nnoremap <Space>   za
nnoremap <Leader>tf za
" zO - Abrir dobleces sobre la posición actual recursivamente
" zC - Cerrar dobleces sobre la posición actual recursivamente
" zR - Abrir todos los dobleces del archivo
" zM - Cerrar todos los dobleces del archivo
nnoremap <Leader>fo zR
nnoremap <Leader>fc zM

" Función para doblar funciones automáticamente
nmap <Leader>ff zfaf
nnoremap <Leader>faf :call DoblarFunciones()<Return>
function! DoblarFunciones()
    set foldmethod=syntax
    set foldnestmax=1
endfunction
"   +++ }}}
" ### }}}

" ##### Ayudas en la edición ##### {{{
" +++ General +++ {{{
set backspace=2       " La tecla de borrar funciona como en otros programas
set undolevels=10000  " Poder deshacer cambios hasta el infinito y más allá
set undofile          " Guardar historial de cambios tras salir
set undoreload=10000  " Cantidad de cambios que se preservan
set history=1000      " Un historial de comandos bastante largo
set nrformats-=octal  " Fuck you octal, nadie te quiere en este siglo
" Alternar formato alfanumérico (toggle alpha format)
nnoremap <Leader>taf :call AlternarFormatoAlfanumerico()<Return>
function! AlternarFormatoAlfanumerico()
    if stridx(&nrformats, 'alpha') == -1
        set nrformats+=alpha  " Bienvenidos sea el conte de letras
    else
        set nrformats-=alpha  " Bye bye conteo de letras
    endif
endfunction

set nojoinspaces      " No insertar dos espacios tras signo de puntuación
set lazyredraw        " No redibujar la interfaz a menos que sea necesario
set updatetime=500    " Tiempo para que vim se actualice
set ttimeout          " ttimeout y ttimeoutlen controlan el retraso de la
set ttimeoutlen=1     " interfaz para que <Esc> no se tarde

" Rotar entre los diferentes modos visuales con v
xnoremap <expr>v
               \ (mode() ==# 'v' ? 'V' : mode() ==# 'V' ?
               \ "\<C-v>" : 'v')
"   +++ }}}

" +++ Copiando, pegando y moviendo texto +++ {{{
set nopaste           " 'paste' estará desactivada por defecto
set pastetoggle=<F2>  " Botón para activar/desactivar 'paste'
nnoremap <Leader>tps :setlocal paste!<Return>

" Copiar y pegar por medio de la papelera del sistema si se puede
let s:usar_portapapeles_del_sistema = 0
if s:usar_portapapeles_del_sistema && has('clipboard')
    if has('unnamedplus') " Cuando se pueda usar el registro + para copiar-pegar
        set clipboard=unnamed,unnamedplus
    else " En mac y windows se usa el registro * para copiar-pegar
        set clipboard=unnamed
    endif
endif

" Pegando texto respetando la indentación (put under y put over)
nnoremap <Leader>pu ]p
nnoremap <Leader>po [p

" Manejo de registros por medio de la letra ñ
nnoremap ñ "
xnoremap ñ "

" Hacer que Y actúe como C y D
noremap Y y$

" Hacer que Ctrl-c copie cosas al porta-papeles del sistema
xnoremap <C-c> "+y
nnoremap <C-c> "+yy

" Copiar texto por arriba y por debajo
nnoremap <A-y> yyP
vnoremap <A-y> y`>pgv
nnoremap <A-Y> yyp
vnoremap <A-Y> y`<Pgv

" Mover lineas visuales hacia arriba y hacia abajo
nnoremap <A-j> :move +<Return>==
nnoremap <A-k> :move -2<Return>==
vnoremap <A-j> :move '>+1<Return>gv=gv
vnoremap <A-k> :move '<-2<Return>gv=gv

" Mover bloques visuales a la izquierda y a la derecha
nnoremap <A-l> xp
nnoremap <A-h> xhP
vnoremap <A-l> xp`[<C-V>`]
vnoremap <A-h> xhP`[<C-V>`]

" Mantener el modo visual después de > y <
xnoremap < <gv
xnoremap > >gv
"   +++ }}}

" +++ Operaciones comunes de modificación de texto +++ {{{
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " Eliminar caracter de comentario al unir líneas
endif

" Regresar rápido a modo normal
inoremap kj <Esc>
inoremap jk <Esc>

" Seleccionando texto significativo
" Texto previamente insertado
nnoremap gV `[v`]
" Texto previamente pegado
nnoremap <expr>gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" gv - Reseleccionar texto previamente seleccionado

" Eliminar texto hacia enfrente con comandos basados en la D
inoremap <C-d> <Del>
inoremap <expr><A-d> '<Esc>' . (col('.') == 1 ? "" : "l") . 'dwi'
inoremap <expr><A-D> '<Esc>' . (col('.') == 1 ? "" : "l") . 'C'

" Regresar a modo normal eliminando la línea actual
inoremap <A-k><A-j> <Esc>ddk
inoremap <A-j><A-k> <Esc>ddj

" Añadir línea vacía por arriba y por debajo
nnoremap <A-o> :call append(line('.'), '')<Return>
nnoremap <A-O> :call append(line('.')-1, '')<Return>

" Emular un par de comandos para rodear texto (de vim surround)
if !s:usar_plugins
    nnoremap ysiw   :call RodearPalabra()<Return>
    xnoremap S <Esc>:call RodearSeleccion()<Return>

    function! RodearPalabra()
        let l:leido = nr2char(getchar())
        let [l:car_apertura, l:car_cierre] = CaracteresHermanos(l:leido)

        execute "normal! viw\<Esc>a"
                    \ . l:car_cierre
                    \ . "\<Esc>"
                    \ . "hviwo\<Esc>i"
                    \ . l:car_apertura
                    \ . "\<Esc>lel"
    endfunction

    function! RodearSeleccion()
        let l:leido = nr2char(getchar())
        let [l:car_apertura, l:car_cierre] = CaracteresHermanos(l:leido)

        execute 'normal! `>a'
                    \ . l:car_cierre
                    \ . "\<Esc>"
                    \ . '`<i'
                    \ . l:car_apertura
                    \ . "\<Esc>"
    endfunction
endif

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

" Alinear el texto con respecto a un carácter/cadena
command! -nargs=1 -range Alinear '<,'>call Alinear(<f-args>)

xnoremap <Leader>al :Alinear<Space>
nnoremap <Leader>al vip:Alinear<Space>

function! Alinear(cadena) range
    let l:columna_inicial = min([virtcol("'<"), virtcol("'>")])
    let l:guardar_pos_cursor = getpos('.')
    let l:columna_maxima = s:columnaMaxima(a:cadena, a:firstline, a:lastline, l:columna_inicial)

    for l:linea in range(a:lastline - a:firstline + 1)
        call cursor(a:firstline + l:linea, l:columna_inicial)
        if search(a:cadena, 'c', line('.')) != 0
            let l:delta_col = (l:columna_maxima - col('.'))
            if l:delta_col > 0
                execute 'normal! ' . l:delta_col . 'i '
            endif
        endif
    endfor

    call setpos('.', l:guardar_pos_cursor)
endfunction

function! s:columnaMaxima(cadena, linea_ini, linea_fin, columna)
    let l:columna_maxima = 0

    for l:linea in range(a:linea_fin - a:linea_ini + 1)
        call cursor(a:linea_ini + l:linea, a:columna)
        call search(a:cadena, 'c', line('.'))

        let l:columna_actual = col('.')
        if l:columna_actual > l:columna_maxima
            let l:columna_maxima = l:columna_actual
        endif
    endfor

    return l:columna_maxima
endfunction

" Comentar (remplazo sencillo de vim-comentary)
if !s:usar_plugins
    let b:inicio_comentario = '//'
    augroup DetectarInicioComentario
        autocmd FileType py,sh   let b:inicio_comentario = '#'
        autocmd FileType fortran let b:inicio_comentario = '!'
        autocmd FileType vim     let b:inicio_comentario = '"'
    augroup END

    nnoremap gc :set operatorfunc=OperadorComentarLineas<Return>g@
    xnoremap gc :<C-u>call OperadorComentarLineas(visualmode(), 1)<Return>

    function! OperadorComentarLineas(tipo, ...)
        let l:marca_inicio = (a:0 ? "'<" : "'[")
        let l:marca_final  = (a:0 ? "'>" : "']")

        let l:primera_liena = getline(line(l:marca_inicio))
        let l:rango = l:marca_inicio . ',' . l:marca_final
        if l:primera_liena =~# '^\s*' . b:inicio_comentario
            execute l:rango . 's/\v(^\s*)' . escape(b:inicio_comentario, '\/') . '\v\s*/\1/e'
        else
            execute l:rango . 's/^\s*/&' . escape(b:inicio_comentario, '\/') . ' /e'
        endif
        execute 'normal! ' . l:marca_inicio
    endfunction
endif

" Extraer variable (variable extract)
nnoremap <Leader>ve viw:call ExtraerVariable()<Return>
xnoremap <Leader>ve :call ExtraerVariable()<Return>
function! ExtraerVariable()
    let l:tipo = input('Tipo variable: ')
    let l:name = input('Nombre variable: ')

    if (visualmode() ==# '')
        normal! viw
    else
        normal! gv
    endif

    exec 'normal! c' . l:name
    let l:selection = @"
    exec 'normal! O' l:tipo . ' ' . l:name . ' = '
    exec 'normal! pa;'
    call feedkeys(':.+1,$s/\V\C' . escape(l:selection, '/\') . '/' . escape(l:name, '/\') . "/gec\<cr>")
endfunction

" Insertar una llave o paréntesis de cierre incluso cuando el plugin
" autopairs esté activo
inoremap <Leader>} <Space><Esc>r}==
nnoremap <Leader>} A<Space><Esc>r}==
imap     <Leader>B <Leader>}
nmap     <Leader>B <Leader>}
inoremap <Leader>) <Space><Esc>r)a
nnoremap <Leader>) i<Space><Esc>r)
imap     <Leader>b <Leader>)
nmap     <Leader>b <Leader>)

" Borrar todo de la línea de comandos excepto el propio comando
cnoremap <A-w> <C-\>esplit(getcmdline(), " ")[0]<return><space>
cmap <A-BS> <A-BS>

" Aumentar la granularidad del undo
inoremap <C-u> <C-g>u<C-u>
"inoremap <Return> <C-g>u<Return>
"   +++ }}}

" +++ Objetos de texto +++ {{{
" Objeto de texto "línea"
xnoremap il g_o^
onoremap il :<C-u>normal vil<Return>
xnoremap al $o0
onoremap al :<C-u>normal val<Return>

" Objecto de texto "buffer completo"
xnoremap i% GoggV
onoremap i% :<C-u>normal vi%<Return>
xnoremap a% GoggV
onoremap a% :<C-u>normal vi%<Return>

" Objeto de texto "comentario de bloque"
if !s:usar_plugins
    xnoremap ic ?<C-r>=escape(split(&commentstring, "%s")[0], '/*')<Return><Return>+0o
                \ /<C-r>=escape(split(&commentstring, "%s")[1], '/*')<Return><Return>-$
    onoremap ic :<C-u>normal vic<Return>
    xnoremap ac ?<C-r>=escape(split(&commentstring, "%s")[0], '/*')<Return><Return>o
                \ /<C-r>=escape(split(&commentstring, "%s")[1], '/*')<Return><Return>l
    onoremap ac :<C-u>normal vac<Return>
endif
"   +++ }}}
" ### }}}

" ##### Búsqueda y reemplazo ##### {{{
" +++ General +++ {{{
set wrapscan           " Las búsquedas dan la vuelta al archivo
set incsearch          " Hacer las búsquedas incrementales
set inccommand=nosplit " Hacer los remplazos incrementales
set ignorecase         " No diferenciar mayúsculas/minúsculas
set smartcase          " Ignorecase si la palabra empieza por minúscula
set hlsearch           " Al buscar texto se resaltan las coincidencias
set magic              " Se usa el modo 'mágico' de búsqueda/reemplazo

" Desactivar el resaltado de búsqueda
nnoremap // :nohlsearch<Return>
nnoremap <Leader>hsc :nohlsearch<bar>let @/ = ''<Return>
"   +++ }}}

" +++ Hacks para la búsqueda y remplazo +++ {{{
" Hacer que el comando . (repetir edición) funcione en modo visual
xnoremap . :normal .<Return>

" Hacer que el comando & (repetir remplazo) funcione en modo visual
xnoremap & :s<Return>

" No moverse cuando se busca con * y #
nnoremap * *N
nnoremap # #N

" Usar * y # en modo visual busca texto seleccionado y no la palabra actual
xnoremap * :<C-u>call SeleccionVisual()<Return>/<C-R>=@/<Return><Return>N
xnoremap # :<C-u>call SeleccionVisual()<Return>?<C-R>=@/<Return><Return>N

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
"   +++ }}}

" +++ Comandos nuevos (mapeos) +++ {{{
" Buscar una palabra y guardar resultados en una locallist
nnoremap <Leader>gg  :lvimgrep<Space>
nnoremap <Leader>gcw :lvimgrep<Space><C-r><C-w><Space>
nnoremap <Leader>gcd :lvimgrep<Space><Space>./*<Left><Left><Left><Left>
nnoremap <Leader>gwd :lvimgrep<Space><C-r><C-w><Space>./*<Return>

" Buscar en todos los buffers abiertos
command! -nargs=1 BuscarBuffers call BuscarBuffers(<q-args>)
nnoremap <Leader>gob :BuscarBuffers<Space>

function! BuscarBuffers(patron)
    let l:archivos = map(filter(range(1, bufnr('$')), 'buflisted(v:val)'),
                \ 'fnameescape(bufname(v:val))')
    try
        silent noautocmd execute 'lvimgrep /' . a:patron . '/gj ' . join(l:archivos)
    catch /^Vim\%((\a\+)\)\=:E480/
        echomsg 'No hubo coincidencias'
    endtry
    lwindow
endfunction

" Ver resultado del comando grep (see result)
nnoremap <Leader>gsr :lopen<Return>

" Reemplazar texto (replace [local | global | current-global])
nnoremap <Leader>rl :s//g<Left><Left>
nnoremap <Leader>rg :%s//g<Left><Left>
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>\C//g<Left><Left>
nnoremap <Leader>rW :%s/\<<C-r>=expand("<cWORD>")<Return>\>\C//g<Left><Left>
xnoremap <Leader>rl :s//g<Left><Left>
xmap     <Leader>rg <Esc><Leader>rg
xnoremap <Leader>rs :<C-u>call SeleccionVisual()<Return>:%s/<C-r>=@/<Return>//g<Left><Left>

" Saltar entre conflictos merge
nnoremap <silent> <Leader>ml /\v^(\<\|\=\|\>){7}([^=].+)?$<Return>
nnoremap <silent> <Leader>mh ?\v^(\<\|\=\|\>){7}([^=].+)\?$<Return>
"   +++ }}}
" ### }}}

" ##### Guardando, saliendo y regresando a vim ##### {{{
set fileformats=unix,dos,mac " Formato para los saltos de línea
set autowrite         " Guardado automático al cambiar de archivo
set autoread          " Recargar el archivo si hay cambios

" +++ Respaldos y recuperación en caso de fallos +++ {{{
" Si se quiere respaldos, definir la siguiente variable a 1
let s:usar_respaldo_local = 0
if s:usar_respaldo_local
    set backupcopy=yes
    set backup            " Hacer el respaldo
    set swapfile          " Archivo swap para el buffer
else
    set nobackup          " Sin respaldo
    set nowritebackup     " No guardar respaldo (no tiene sentido)
    set noswapfile        " Sin archivo swap para el buffer actual
endif

" Crear sesión (con un nombre específico o con el nombre por defecto)
if &sessionoptions =~# '\<options\>'
    set sessionoptions-=options
    set sessionoptions+=localoptions
endif
nnoremap <Leader>ms  :mksession! ~/.vim/session/
nnoremap <Leader>mds :mksession! ~/.vim/session/default<Return>
nnoremap <Leader>cs  :source ~/.vim/session/
nnoremap <Leader>cfs :source ~/.vim/session/default<Return>
" vim -S <archivo_sesion> - Abrir vim con una sesión

if !isdirectory(expand('~/.vim/session/'))
    call mkdir(expand('~/.vim/session/'), 'p')
endif
"   +++ }}}

" +++ Comandos y acciones automáticas para abrir, guardar y salir +++ {{{
" Comandos para salir desde modo normal
nnoremap ZG :wqa<Return>
nnoremap ZA :qa<Return>
" ZQ - Eliminar la ventana actual sin guardar
" ZZ - Eliminar la ventana actual guardando

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
command! -bang Xa xa<bang>
command! -bang XA xa<bang>

" Usar Ctrl-s para guardar como en cualquier otro programa
nnoremap <C-s> :write<Return>
inoremap <C-s> <Esc>:write<Return>a
" Es preferible guardar desde modo normal. En modo inserción no se puede
" garantizar (al menos no sin usar instrucciones más complejas) que el
" cursor se quede en la posición inicial

" Guardar con sudo (cuando entraste a vim sin sudo, se pedirá contraseña)
cnoremap w!! !sudo tee % > /dev/null

augroup ComandosAutomaticosGuardarLeer
    autocmd!
    " Eliminar espacios sobrantes cada que se guarde el archivo
    " (Si no quieres que esto pase, comenta esta línea con un ")
    autocmd BufWritePre * :%s/\s\+$//e

    " Abrir vim en la última posición editada del archivo
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                \ |           execute "normal! g`\""
                \ |       endif

    " Cargar la configuración cuando se guarde
    autocmd BufWritePost $MYVIMRC source $MYVIMRC

    " Si se edita un archivo en un directorio inexistente se intenta
    " crear el mismo
    autocmd BufNewFile * call CrearDirectorioSiNoExiste()
augroup END

function! CrearDirectorioSiNoExiste() abort
    let l:dir_requerido = expand('%:h')
    if !isdirectory(l:dir_requerido)
        let l:respuesta = confirm('El directorio ' . l:dir_requerido
                    \ . ' no existe. ¿Quieres crearlo?',
                    \ "&Si\n&No", 1)

        if l:respuesta != 1
            return
        endif

        try
            call mkdir(l:dir_requerido, 'p')
        catch
            echoerr 'No se ha podido crear ' . l:dir_requerido
        endtry
    endif
endfunction
"   +++ }}}

" +++ Configuración para archivos grandes +++ {{{
augroup ArchivoGrande
    let s:DIES_MEGAS = 10 * 1024 * 1024
    autocmd!
    autocmd BufReadPre * let s:tamanio = getfsize(expand("<afile>"))
                \ | if s:tamanio > s:DIES_MEGAS || s:tamanio == -2
                \ |     call ArchivoGrande()
                \ | endif
augroup END

function! ArchivoGrande()
    " Esta función es llamada cuando el archivo supera 10M de longitud
    syntax off
    set eventignore+=FileType  " Sin resaltado y demás cosas dependientes del tipo
    setlocal bufhidden=unload  " Guardar memoria cuando otro archivo es usado
    setlocal undolevels=-1     " Sin historial de cambios
    setlocal nospell           " Sin revisión ortográfica"
endfunction
"   +++ }}}
" ### }}}

" ##### Compilación, revisión de errores y cosas específicas de un lenguaje ##### {{{
" +++ Comandos de compilación y ejecución +++ {{{
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
nnoremap <F9> :make<bar>call EjecutarSiNoHayErrores()<Return>

function! EjecutarSiNoHayErrores()
    if len(getqflist()) ==# 0
        " Si no hay errores se intenta ejecutar el programa
        if ( &filetype ==# 'c' ||
                    \ &filetype ==# 'cpp' ||
                    \ &filetype ==# 'haskell' ||
                    \ &filetype ==# 'fortran')

            execute '!./' . g:op_compilacion['nombre_ejecutable']
        elseif (&filetype ==# 'java')
            execute '!./' . g:op_compilacion['nombre_ejecutable']
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
"   +++ }}}

" +++ Detección de tipos de archivo, y configuraciones locales +++ {{{
augroup DeteccionLenguajes
    autocmd!
    autocmd BufEnter *.h   setlocal filetype=c
    autocmd BufEnter *.hpp setlocal filetype=cpp
augroup END

augroup ConfiguracionesEspecificasLenguaje
    autocmd!
    "Los guiones se toman como parte del identificador en css/html
    autocmd Filetype css,html setlocal iskeyword+=-
    " Los # no se toman como parte del identificador en vim
    autocmd FileType vim setlocal iskeyword-=#
augroup END
"   +++ }}}
" ### }}}

" ##### Edición y evaluación de la configuración y comandos ##### {{{
" Modificar y evaluar el archivo de configuración principal y el de plugins
nnoremap <Leader>av :tabnew $MYVIMRC<Return>
nnoremap <Leader>sv :source $MYVIMRC<Return>

" Evaluar por medio de la consola externa por medio de Q
nnoremap Q !!$SHELL<Return>
xnoremap Q !$SHELL<Return>

" Configuraciones para el emulador de terminal
if has('nvim')
    " Abrir emulador de terminal y (sin revisión ortográfica)
    nnoremap <Leader>ot :5sp<bar>te<CR>:setlocal nospell nonu<Return>A
    " Salir a modo normal en la terminal emulada
    tnoremap <Esc> <C-\><C-n>
elseif has('terminal')
    nnoremap <Leader>ot :terminal<Return>
    tnoremap <Esc> <C-\><C-n>
endif

" Evaluación de un comando de modo normal por medio de <Leader>evn
nnoremap <Leader>evn ^vg_y@"
xnoremap <Leader>evn y@"

" Evaluación de un comando de VimL (modo comando) por medio de <Leader>evv
nnoremap <silent> <Leader>evv :execute getline(".")<Return>
xnoremap <silent> <Leader>evv :<C-u>
            \       for linea in getline("'<", "'>")
            \ <bar>     execute linea
            \ <bar> endfor
            \ <Return>

" Pegar la salida de un comando de vim en un buffer nuevo
" Modo de uso: SalBuffer {comando-normal}
command! -nargs=* -complete=command SalBuffer call SalidaBuffer(<q-args>)
function! SalidaBuffer(comando)
    redir => l:salida
    silent exe a:comando
    redir END

    new
    setlocal nonumber
    call setline(1, split(l:salida, "\n"))
    setlocal nomodified
endfunction

" Listar todos los mapeos actualmente activos
function! VerComandosActivos()
    let l:opciones = "Comandos de modo &normal\n"
                 \ . "Comandos de modo &inserción\n"
                 \ . "Comandos se modo &visual\n"
                 \ . "&Todos los comandos\n"
    let l:respuesta = confirm('¿Qué tipo de comandos quiere listar',
                            \ l:opciones, 4)

    if l:respuesta == 0
        return
    elseif l:respuesta == 1
        nmap
    elseif l:respuesta == 2
        imap
    elseif l:respuesta == 3
        vmap
    else
        map
    endif
endfunction
" ### }}}

" ##### Completado, etiquetas, diccionarios y revisión ortográfica ##### {{{
set complete+=i        " Completar palabras de archivos incluidos

" Generar etiquetas de definiciones y comando "go to definition"
set tags=./tags;/,~/.vimtags
if !executable('ctags')
    echoerr 'Se requiere alguna implementación de ctags para generar etiquetas'
    echoerr 'del lenguaje para usar algunos comandos (y posiblemente plugins).'
    echoerr 'Se recomienda instalar universal-ctags'
endif
if s:usar_plugins
    nnoremap <Leader>ut :UpdateTags<Return>
else
    nnoremap <Leader>ut !ctags -R .&<Return>
endif
  " <C-]> - Ir a la definición del objeto (solo si ya se generaron las etiquetas)

" Algunas abreviaciones para lenguajes como c, c++ y java
if !s:usar_plugins
    " Estas abreviaciones solo son auxiliares para quien tenga desactivados los
    " plugins. En caso de activar plugins, estos son mejores para manejar
    " plantillas de código
    iabbrev for  for (int i = 0; i <; i++) {<return>}<esc>kf<a
    iabbrev forr for (int i =; i >= 0; --i) {<return>}<esc>kf;i
    iabbrev pf   printf("");<esc>2hi
    iabbrev cl   cout << << endl;<esc>8hi
    iabbrev pl   System.out.println();<esc>hi
endif

" Establecer la siguiente variable a 1 para activar revisión ortográfica
let s:activar_revision_ortorgrafica = 0
if s:activar_revision_ortorgrafica
    " Si se quiere revisión ortográfica en español establecer la siguiente
    " variable a 1
    let s:revision_otrografica_en_espaniol = 0
    set spell             " Activa la revisión ortográfica
    " Alternar entre revisión activa e inactiva con ,tsp
    nnoremap <Leader>tsp :setlocal spell!<Return>
    if s:revision_otrografica_en_espaniol
        set spelllang=es      " El idioma de revisión es español
        " Generalmente los sistemas operativos no cuentan con un diccionario
        " en español. La primera vez que se inicie vim se pedirá permiso
        " para descargar el diccionario necesario. Basta con aceptar
        " para que vim haga el trabajo automáticamente
    else
        set spelllang=en
        set dictionary=/usr/share/dict/words " Usa el diccionario del sistema
    endif

    " Recorrer las palabras mal escritas y corregirlas
    nnoremap <Leader>sl ]szzzv
    nnoremap <Leader>sh [szzzv

    " Modificar lista de palabras aceptadas
    nnoremap <Leader>sa zg
    " zw - Quitar palabra de la lista blanca (marcarla como incorrecta)

    " Mostrar opciones de corrección para una palabra mal escrita
    nnoremap <Leader>ss  z=
    nnoremap <Leader>scc 1z=
    nnoremap <Leader>scp [s1z=<C-o>
endif
" ### }}}

" vim: fdm=marker
