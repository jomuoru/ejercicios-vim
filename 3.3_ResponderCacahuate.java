import java.util.Scanner;

class ResponderCacahuate {
    public static void main(String args[]) {
        Scanner escaner = new Scanner(System.in);

        while (escaner.hasNext()) {
            String texto = escaner.next();

            if (Character.isUpperCase(texto.charAt(0))) {
                System.out.print("Cacahuate ");
            } else if (texto.contains(".")) {
                System.out.println("cacahuate.");
            } else if (texto.contains(",")) {
                System.out.println("cacahuate,");
            } else {
                System.out.print("cacahuate ");
            }
        }
    }
}
