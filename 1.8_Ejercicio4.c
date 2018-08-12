#include <stdio.h>

FILE * fcreate(void)
{
    FILE * rv = fopen(tmpnam(NULL), "w");

    if (rv == NULL)
    {
        fprintf(stderr, "Something went wrong\n");
        exit(EXIT_FAILURE);
    }

    return rv;
}

int main(void)
{
// *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
// Pruebe la diferencia entre completado normal y completado
// local al archivo mientras trata de llamar la función "fcreate":

    FILE * fp = f

// Respuesta sugerida {{{
//     Recordando: <C-n> o <C-p> completan sin discriminar y <C-x><C-n>
//     o <C-x><C-p> completan solo palabras del archivo actual
//     Posicionándose enfrente de la f y presionando <C-x><C-n>
//     se obtiene una lista reducida en donde será fácil encontrar
//     fcreate. Luego solo faltaría añadir paréntesis y punto y coma
// }}}
// *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*
}
// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker tw=75
