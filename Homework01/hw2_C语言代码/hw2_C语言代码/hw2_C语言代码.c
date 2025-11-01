#include <stdio.h>

int main() {
    char ch = 'a';
    int i, j;
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 13; j++) {
            printf("%c ", ch);
            ch++; 
        }
        printf("\n");  
    }

    return 0;
}