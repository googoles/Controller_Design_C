#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N 60
// Iterative Learning Control Practice Code
// 미완성
int main()
{

    int t[N];
    int i;
    double pi = 3.1415;

    for (i = 0; i < N; i++) {
        t[i] = i;
        // printf("%d\n", t[i]);
    }

    int Ts = 1;
    int x0 = 0;
    int n0 = 0;
    int r = 1;
    int num = sizeof(t);
    // printf("%d\n", num/sizeof(int));

    int A[3][3] = {
        {0, 1, 0},
        {3, 0, 1},
        {0, 1, 0}
    };

    int B[3][1] = {
        {1},
        {1},
        {3}
    };

    int C[3][1] = {
        {1},
        {1},
        {1}
    };

    // Input Vector U
    int input_vector[60] = {0,0,0,0,0,0,0,0,0,0,0,0,-5,-5,-5,-5,-5,-5,-5,-5,-5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3};
    // Reference Vector Rj
    // printf("%d\n", sizeof(input_vector));
    int R[N][1]; // Array must be type int

    // printf("%d\n", t[4]);
    for (int j = 0; j < N; j++) {
        R[j][0] = 10*sin(t[j]);
        // printf("%d\n", R[j]);
    }

    int Gvec[N][1];
    for (int k = 0; k < N; k++) {
        Gvec[k][0] = 0;
        printf("%d\n", Gvec[k][0]);
    }

    

    return 0;
}

