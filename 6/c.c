#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define FILENAME "txt.txt" // Nombre del archivo

int chars = 0;
int words = 0;
int lines = 0;

void count_chars_words_lines(FILE *file) {
    int c;
    int in_word = 0;

    while ((c = fgetc(file)) != EOF) {
        chars++;
        if (c == '\n') {
            lines++;
        }
        if (c == ' ' || c == '\t' || c == '\n' || c == '\r') {
            in_word = 0;
        } else if (!in_word) {
            in_word = 1;
            words++;
        }
    }
    // Si el archivo no termina con una nueva línea, incrementa el contador de líneas
    if (chars > 0 && fseek(file, -1, SEEK_END) == 0 && fgetc(file) != '\n') {
        lines++;
    }
}

int main() {
    FILE *file = fopen(FILENAME, "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    clock_t start_time = clock();
    count_chars_words_lines(file);
    clock_t end_time = clock();
    double execution_time = ((double) (end_time - start_time)) / CLOCKS_PER_SEC;

    fclose(file);

    printf("Lines   Words   Chars\n");
    printf("%6d%8d%8d\n", lines, words, chars);
    printf("Execution time: %.6f seconds\n", execution_time);

    return 0;
}

