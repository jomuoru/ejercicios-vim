#include <bits/stdc++.h> // Esto incluye todo lo que necesitas y más
using namespace std;

int main()
{
    ostream_iterator iterador_salida(cout, ", ");
    vector<int> numeros { 5, -2, 6, 1, 2, 99, 12, -54, -2 };

    cout << "----- Antes de ordenar el vector -----" << endl;
    cout << "El contenido del vector es: ";
    copy(numeros.begin(), numeros.end(), iterador_salida);
    endl(cout);

    // Ordenando
    sort(numeros.begin(), numeros.end());

// *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
// Haga nuevamente la impresión del vector auxiliándose del
// completado de líneas.
    cout << "----- Después de ordenar el vector -----" << endl;

// Respuesta sugerida {{{
//     Escriba 'cout << "E' y luego presione
//     <C-x><C-L> tres veces.
//     Funciona gracias a que el completado de líneas también
//     es sensible al contexto.
// }}}
// *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*
}
// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker tw=75
