#include <iostream>

int main()
{
    constexpr int TAMANIO{10};

    // *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    // Cambie el 10 que se usa como tamaño de los tres arreglos por la
    // constante "TAMANIO"
    //

    int arreglo1[10] {9, 8, 7, 6, 5, 4, 3, 2, 1};
    int arreglo2[10] {1, 2, 3, 4, 5, 6, 7, 8, 9};

    int suma[10];
    // Respuesta sugerida {{{
    //     Entre los límites de los corchetes de un arreglo teclea
    //     ci[TAMANIO<Esc>
    //     Repitelo sobre el resto de arreglos
    // }}}
    // *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v

    for (size_t i = 0; i < sizeof(suma)/sizeof(suma[0]); ++i)
    {
        suma[i] = arreglo1[i] + arreglo2[i];

        std::cout << "El elemento " << i << " es : " << suma[i] << std::endl;
    }
}
// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker tw=75
