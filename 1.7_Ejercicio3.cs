using System;

// *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
namespace Ejercicio3
    {

    class Principal
    {
    public static void main(String[] args)
        {
    Clase1.metodo(10);
Clase2.metodo(5.5f);
            Console.WriteLine("Que feo D:, arreglame");
        }
}

    class Clase1
{
public static void metodo(Int32 x)
        {
        Console.WriteLine($"El valor es: {x}");
}
                        }

class Clase2
{
public static void metodo(Single y)
{
    Console.WriteLine("Raíz o al cuadrado?");
            Console.WriteLine(" 1 - Raíz");
Console.WriteLine(" 2 - Cuadrado");

                    String resp = Console.ReadLine();
Int32 opcion;
    if (!Int32.TryParse(resp, out opcion))
            {
        return;
    }

    // Arregle la sangría del código
    //                                  Ir al principio de archivo => gg
    //                                  Ir al final de archivo => G
    // Respuesta sugerida  {{{
    //     Teclea gg=G o G=gg
    // }}}

if (opcion == 1)
{
            Console.WriteLine($"El valor al cuadrado es: {Math.Sqrt(y)}");
}
else
{
Console.WriteLine($"El valor al cuadrado es: {Math.Pow(y, 2)}");
}
}
}


}
// *v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v*v

// vim: sts=4 ts=4 sw=4 ai sta nu fdm=marker
