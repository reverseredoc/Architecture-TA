#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <unordered_set>

using namespace std;

void printNumbers(const vector<int>& numbers) {
    for (int number : numbers) {
        cout << number << endl;
    }
}

int main(int argc, char *argv[]) {
    srand(time(0));  // Seed the random number generator with current time

    int n;
    // cin >> n;
    n = stoi(argv[1]);

    vector<int> numbers(n + 1);

    numbers[0] = n;  // Store the value of n at the beginning of the vector

    unordered_set<int> distinctNumbers;
    while (distinctNumbers.size() < n) {
        int randomNum = rand() % (2 * n);  // Generate random number between 0 and 2*n-1
        distinctNumbers.insert(randomNum);
    }

    int i = 1;
    for (int number : distinctNumbers) {
        numbers[i++] = number;
    }

    printNumbers(numbers);

    int q;
    // cin >> q;
    q = stoi(argv[2]);


    cout << q<< endl;
    for (int i = 1; i <= q / 2; i++) {
        cout << numbers[i] << endl;
    }

    int remaining = q - q / 2;
    while (remaining > 0) {
        int randomNum = rand() % (2 * n);  // Generate random number between 0 and 2*n-1

        cout << randomNum << endl;
        remaining--;

    }

    return 0;
}
