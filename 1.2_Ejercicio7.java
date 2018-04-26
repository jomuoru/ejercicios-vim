import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.IdentityHashMap;
import java.util.Calendar;
import java.util.Date;

class Ejercicio {
    public static void main(String[] args) throws FileNotFoundException {
        // Ejercicio: 
        // Elimine la inicialización a las siguientes declaraciones.
        //                                              Operador eliminar => d

        Integer i = new Integer("1234");
        FileInputStream fis = new FileInputStream("nombres.txt");
        IdentityHashMap odhm = new IdentityHashMap(1 << 8);
        Date fch = Calendar.getInstance().getTime();

    }

}
// ¿Quieres ir de vuelta? => 1.2_ComenzandoAMoverse.txt
