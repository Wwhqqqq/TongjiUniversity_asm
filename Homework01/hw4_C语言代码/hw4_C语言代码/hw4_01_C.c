#include <stdio.h>

void print_row(int n) {
    for (int i = 1; i <= n; i++) {
        printf("%dx%d=%-2d   ", n, i, n * i);
    }
    printf("\n");
}

int main() {
    printf("The 9mu19 table:\n");
    for (int i = 9; i >= 1; i--) {
        print_row(i);
    }
    return 0;
}