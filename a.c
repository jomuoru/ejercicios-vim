#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    printf("Hola que hace\n");

    int x;
    scanf("%d", &x);
    if (x == 18) {
        printf("Tu edad es 18\n");
    } else if (x > 18) {
        printf("Tu edad es mayor a 18\n");
    } else if (x < 18 && x > 0) {
        printf("Tu edad es menor a 18\n");
    } else {
        printf("Tecnicamente, tu no existes\n");
    }
    return EXIT_SUCCESS;
}
