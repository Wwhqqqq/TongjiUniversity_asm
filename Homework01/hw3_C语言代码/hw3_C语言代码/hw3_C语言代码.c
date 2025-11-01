#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main() {
    // 1：直接计算
    int sum = 0;
    for (int i = 1; i <= 100; i++) {
        sum += i;
    }
    printf("1+2+...+100 = %d\n", sum);

    // 2：用户输入版本
    int n;
    printf("Please enter a number (1-100): ");
    scanf("%d", &n);

    sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    printf("1+2+...+%d = %d\n", n, sum);

    return 0;
}