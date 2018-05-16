#!/bin/bash

# Ejercicio:
# Sustituye cada aparición de 1:-Usuario por NOMBRE
# Respuesta sugerida {{{
#     Dentro de las llaves de alguna aparición de "${1:-Usuario}" presione
#     'ci{NOMBRE<Esc>'. Luego muévase a las siguientes y presione con '.'
# }}}

NOMBRE=${1:-Usuario}

echo "Bienvenido seas ${1:-Usuario}, este programa te guiará en ..."

# ...

echo
echo "... bien hecho ${1:-Usuario}, ahora solamente te falta ..."
echo

# ...

echo "Adiós ${1:-Usuario}, vuelve pronto"

# vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker
