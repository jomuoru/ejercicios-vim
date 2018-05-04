#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Mover la función 'unafuncion' abajo del main y poner un
// prototipo de la misma en su lugar original.
//                                                  Selección por líneas => V
//                                                  Operador copiar => y
//                                                  Comando pegar => p
//                                                  Insertar al final => A

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

// ¿Quieres ir de vuelta? => 1.3_MovimientoElemetoTexto.txt

// vim: sts=4 ts=4 sw=4 ai sta
