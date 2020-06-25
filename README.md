# Non-Recursive-Factorial-in-MIPS-Assembly
This program finds the factorial of a user input of n (1 - 10), and then outputs it to the console. 

It was translated from this c++ code into MIPS Assembly language:

#include<iostream>
using namespace std;
int factorial(int);
int main() {
 int counter, n, result;
 cout << "Enter a number between 1 and 10:";
 cin>>n;
 result = factorial(n);
 cout << n << " Factorial Value Is " << result;
 return 0; }
int factorial(int n) {
 int counter;
 int fact = 1;
 for (int counter = 1; counter <= n; counter++)
  fact = fact * counter;
 return fact; }
