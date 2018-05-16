#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Mover la función 'unafuncion' abajo del main y poner un
// prototipo de la misma en su lugar original.
//                                                  Selección por líneas => V
//                                                  Operador copiar => y
//                                                  Comando pegar antes => P
//                                                  Comando pegar después => p
//                                                  Insertar al final => A
// Respuesta sugerida {{{
//     Estando sobre la palabra "static" presione 'y]]' para copiar de forma
//     no inclusiva hasta la llave de inicio de la función y luego presione
//     'P' para pegar el texto copiado antes de la línea actual. Para
//     convertir el texto copiado en una cabecera añada punto y coma al
//     final con 'A;<Esc>'.
//     Para copiar el resto de la función regrese a la palabra "static" de
//     su cabecera y presione: 'V][y'. Baje y peque donde guste.
// }}}
static inline long double
unafuncion(int a, float b)
{
    if (a == 42)
    {
        return b * b * 3.141592;
    }

    return 1 / sqrt(b);
}

int
main(void)
{
    unafuncion(rand() % 100, 10);
}

// ¿Quieres ir de vuelta? => 1.3_MovimientoElemetoTexto.txt:130 (Usar 'gF')

// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker
