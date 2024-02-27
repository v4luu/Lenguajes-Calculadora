%{
#include <stdio.h>
#include <string.h>
#include <time.h>

int chars = 0;
int words = 0;
int lines = 0;

extern FILE *yyin; // Declarar el archivo de entrada externamente para poder cambiarlo desde C
%}

%%
[a-zA-Z]+ {
    words++;
    chars += strlen(yytext);
}

\n {
    chars++;
    lines++;
}

. {
    chars++;
}

%%

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <txt>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    yyin = file; // Establecer el archivo de entrada de Flex como el archivo proporcionado

    clock_t start_time = clock();
    yylex(); // Llamar al analizador léxico
    clock_t end_time = clock();
    double execution_time = ((double) (end_time - start_time)) / CLOCKS_PER_SEC;

    fclose(file);

    printf("Lines   Words   Chars\n");
    printf("%6d%8d%8d\n", lines, words, chars);
    printf("Execution time: %.6f seconds\n", execution_time);

    return 0;
}

