#!/bin/bash

# *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
# Sustituye cada aparición de 1:-Usuario por NOMBRE

NOMBRE=${1:-Usuario}

echo "Bienvenido seas ${1:-Usuario}, este programa te guiará en ..."

# ...

echo
echo "... bien hecho ${1:-Usuario}, ahora solamente te falta ..."
echo

# ...

echo "Adiós ${1:-Usuario}, vuelve pronto"
# Respuesta sugerida {{{
#     Dentro de las llaves de alguna aparición de "${1:-Usuario}" presiona
#     ci{NOMBRE<Esc>
#     Luego muévete a las siguientes y presione .
# }}}
# *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v

# vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker tw=75
