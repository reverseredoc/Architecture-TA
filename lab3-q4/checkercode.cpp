#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

vector<vector<int>> scalarMultiply(const vector<vector<int>>& matrix, int scalar) {
    int n = matrix.size();
    vector<vector<int>> result(n, vector<int>(n, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = matrix[i][j] * scalar;
        }
    }

    return result;
}

vector<vector<int>> matrixAdd(const vector<vector<int>>& matrix1, const vector<vector<int>>& matrix2) {
    int n = matrix1.size();
    vector<vector<int>> result(n, vector<int>(n, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = matrix1[i][j] + matrix2[i][j];
        }
    }

    return result;
}

vector<vector<int>> hadamardProduct(const vector<vector<int>>& matrix1, const vector<vector<int>>& matrix2) {
    int n = matrix1.size();
    vector<vector<int>> result(n, vector<int>(n, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = matrix1[i][j] * matrix2[i][j];
        }
    }

    return result;
}

int main() {
    int n, w, x, y, z;
    cin >> n;

    cin >> w >> x >> y >> z;

    vector<vector<int>> a(n, vector<int>(n, 0));
    vector<vector<int>> b(n, vector<int>(n, 0));
    vector<vector<int>> c(n, vector<int>(n, 0));
    vector<vector<int>> d(n, vector<int>(n, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> a[i][j];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> b[i][j];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> c[i][j];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> d[i][j];
        }
    }

    vector<vector<int>> product1 = scalarMultiply(a, w);
    vector<vector<int>> product2 = scalarMultiply(b, x);
    vector<vector<int>> sum1 = matrixAdd(product1, product2);

    vector<vector<int>> product3 = scalarMultiply(c, y);
    vector<vector<int>> product4 = scalarMultiply(d, z);
    vector<vector<int>> sum2 = matrixAdd(product3, product4);

    vector<vector<int>> result = hadamardProduct(sum1, sum2);

    int sum = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            sum += pow(-1, i + j) * result[i][j];
        }
    }

    cout << sum << endl;

    return 0;
}
