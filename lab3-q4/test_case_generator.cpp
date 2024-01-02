#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

void generateRandomMatrix(vector<vector<int>>& matrix, int n) {
    srand(time(NULL));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = rand() % 10 + 1;
        }
    }
}

void printMatrix(const vector<vector<int>>& matrix) {
    int n = matrix.size();

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }
}

int main() {
    int n = 1000;

    srand(time(NULL));
    vector<vector<int>> a(n, vector<int>(n, 0));
    vector<vector<int>> b(n, vector<int>(n, 0));
    vector<vector<int>> c(n, vector<int>(n, 0));
    vector<vector<int>> d(n, vector<int>(n, 0));

    generateRandomMatrix(a, n);
    generateRandomMatrix(b, n);
    generateRandomMatrix(c, n);
    generateRandomMatrix(d, n);

    int w = rand() % 10 + 1;
    int x = rand() % 10 + 1;
    int y = rand() % 10 + 1;
    int z = rand() % 10 + 1;

    cout<<n<<endl<<w<<" "<<x<<" "<<y<<" "<<z<<endl;

    printMatrix(a);

    printMatrix(b);

    printMatrix(c);

    printMatrix(d);

    return 0;
}
