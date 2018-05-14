#include <iostream>

int main()
{
    constexpr int TAMANIO {10};

    // Ejercicio:
    // Cambie el 10 que se usa como tamaño de los tres arreglos por la constante
    // "TAMANIO"

    int arreglo1[10] {9, 8, 7, 6, 5, 4, 3, 2, 1};
    int arreglo2[10] {1, 2, 3, 4, 5, 6, 7, 8, 9};

    int suma[10];

    for (size_t i = 0; i < sizeof(suma)/sizeof(suma[0]); ++i)
    {
        suma[i] = arreglo1[i] + arreglo2[i];

        std::cout << "El elemento " << i << " es : " << suma[i] << std::endl;
    }

}

// Regresar al tutorial: 1.6_ObjetosDeTexto.txt

// vim: sts=4 ts=4 sw=4 ai sta nu
