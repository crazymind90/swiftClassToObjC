//
//  main.m
//  swiftClassToObjC
//
//  Created by CrazyMind90 on 25/01/2025.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDigits(size_t n) {
    if (n == 0) return 1;
    int count = 0;
    while (n != 0) {
        n /= 10;
        count++;
    }
    return count;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s ExecutableName.ClassName\n", argv[0]);
        return 1;
    }

    char *input = argv[1];
    size_t input_len = strlen(input);
    
    char *copy = malloc(input_len + 1);
    if (!copy) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }
    strcpy(copy, input);


    char *dot = strchr(copy, '.');
    if (!dot || dot == copy || *(dot + 1) == '\0') {
        fprintf(stderr, "Invalid format. Use: ExecutableName.ClassName\n");
        free(copy);
        return 1;
    }

    *dot = '\0';
    char *executableName = copy;
    char *className = dot + 1;

    size_t exe_len = strlen(executableName);
    size_t class_len = strlen(className);

    
    int exe_digits = countDigits(exe_len);
    int class_digits = countDigits(class_len);
    size_t buf_size = 4 + exe_digits + exe_len + class_digits + class_len + 1;
    
    char *result = malloc(buf_size);
    if (!result) {
        fprintf(stderr, "Memory allocation failed\n");
        free(copy);
        return 1;
    }

    
    snprintf(result, buf_size, "_TtC%zu%s%zu%s", exe_len, executableName, class_len, className);
    printf("%s\n", result);

    free(copy);
    free(result);
    return 0;
}
