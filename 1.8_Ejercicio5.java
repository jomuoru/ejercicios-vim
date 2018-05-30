// *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
// Importe la interfaz List y la clase ArrayList del paquete
// java.util
//
// Respuesta sugerida {{{
//     El completado de palabras locales tiene la propiedad especial
//     de ser "dependientes del contexto. Posicionate en la línea
//     siguente al primer import y presiona:
//
//         im<Ctrl-X><Ctrl-P><Ctrl-X><Ctrl-P><Ctrl-X><Ctrl-P>
//
//     Eso debería completar el texto hasta "import java.util", suficiente
//     para que manualmente completemos el resto de la línea.
//     Hay que notar que cada repetición de <Ctrl-X><Ctrl-P> completó una
//     del mismo contexto en que se encontraba la palabra anterior.
// }}}
import java.util.Scanner;

// *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*
class Ejercicio5 {
    public static void main(String args[]) {
        List<Integer> lista = new ArrayList<Integer>() {{
            add(1); add(2); add(3); add(4); add(5);
        }};

        lista.forEach(System.out::println);
    }
}

// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker
