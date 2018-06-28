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
// local al archivo mientras trata de llamar la funcion "fcreate":
//

    FILE * fp = f

// Respuesta sugerida {{{
//     Recordando: <Ctrl-N> o <Ctrl-P> completan sin discriminar y
//     <Ctrl-X><Ctrl-N> o <Ctrl-X><Ctrl-P> completan solo palabras
//     del archivo actual.
// }}}
// *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*
}
// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker
