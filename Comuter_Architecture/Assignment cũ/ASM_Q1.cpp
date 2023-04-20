
#include <iostream>
#include <math.h>
#include <fstream>
using namespace std;

void getMatrix(const char* filename, float* &mat, int &row, int &col){
    ifstream ifs;
    ifs.open(filename);
    if (!ifs.good()) {
        string str = filename;
        str = "Opening file " + str + " is failed!\n";
        throw str.c_str();
    }
    else {
        int total_element = row * col;
        mat = new float[total_element];
        for (int i = 0; i < total_element; i++) {
            ifs >> mat[i];
        }
    }
    ifs.close();   
}

int main()
{
    //---------------- GET MATRIX A ----------------//
    int rowA = 0, colA = 0;
    int rowB = 0, colB = 0;
    cout << "Please input the dimension of matrix A: \n";
    cout << "\tRow: ";
    cin >> rowA;
    cout << "\tColumn: ";
    cin >> colA;
    cout << "Please input the dimension of matrix B: \n";
    cout << "\tRow: ";
    cin >> rowB;
    cout << "\tColumn: ";
    cin >> colB;
    int rowRes = rowA, colRes = colB;


    float* matrix_A = nullptr;
    try {
        getMatrix("A.txt", matrix_A, rowA, colA);
    }
    catch (const char* msg) {
        cout << msg;
        return EXIT_FAILURE;
    }
    //---------------------------------------------//
    
    //---------------- GET MATRIX B ---------------//
    
    float* matrix_B = nullptr;
    try {
        getMatrix("B.txt", matrix_B, rowB, colB);
    }
    catch (const char* msg) {
        cout << msg;
        return EXIT_FAILURE;
    }
    //---------------------------------------------//

    //---------------- GET MATRIX RESULT ------------------//
    
    float* matrix_result = nullptr;

    try {
        getMatrix("result.txt", matrix_result, rowRes, colRes);
    }
    catch (const char* msg) {
        cout << msg;
        return EXIT_FAILURE;
    }
    //------------------------------------------------//

    // COMPUTE THE PRODUCT OF MATRIX A AND MATRIX B (A x B)
    // THEN SAVE TO THE GOLDEN_RESULT
    int total_element_result = rowA * colB;
    float* matrix_golden_result = new float[total_element_result];
    for (int i = 0; i < total_element_result; i++) {
        matrix_golden_result[i] = 0;
        for (int j = 0; j < colA; j++) {
            matrix_golden_result[i] += matrix_A[i / colB * colA + j] * matrix_B[j * colB + i % colB];
        }
    }
    //------------------------------------------------//


    //COMPARE THE VALUE OF MATRIX RESULT AND GOLDEN RESULT TO COMPUTE THE RATE OF DIFFERENCE

    int nDiff = 0;
    for (int i = 0; i < total_element_result; i++) {
        if (matrix_result[i] != matrix_golden_result[i])
            nDiff++;
    }
    cout << "The percentage of the difference between two matrix is " << roundf((float)nDiff * 1000000 / total_element_result) / 10000 << "%\n";
    
}