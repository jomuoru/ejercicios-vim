#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[])
{
    if (10 == argc) {
        printf("hola que hace\n");

        if (argv[argc] == NULL) {
            puts("Lo normal");
        }
    }

    return EXIT_SUCCESS;
}
