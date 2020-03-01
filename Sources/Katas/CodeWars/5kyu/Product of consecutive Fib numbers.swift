//
//  File.swift
//  
//
//  Created by Wanaldino Antimonio on 01/03/2020.
//
//URL: https://www.codewars.com/kata/5541f58a944b85ce6d00006a/train/swift

//Kata:
//The Fibonacci numbers are the numbers in the following integer sequence (Fn):
//
//0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, ...
//
//such as
//
//F(n) = F(n-1) + F(n-2) with F(0) = 0 and F(1) = 1.
//
//Given a number, say prod (for product), we search two Fibonacci numbers F(n) and F(n+1) verifying
//
//F(n) * F(n+1) = prod.
//
//Your function productFib takes an integer (prod) and returns an array:
//
//[F(n), F(n+1), true] or {F(n), F(n+1), 1} or (F(n), F(n+1), True)
//depending on the language if F(n) * F(n+1) = prod.
//
//If you don't find two consecutive F(m) verifying F(m) * F(m+1) = prodyou will return
//
//[F(m), F(m+1), false] or {F(n), F(n+1), 0} or (F(n), F(n+1), False)
//F(m) being the smallest one such as F(m) * F(m+1) > prod.

import Foundation

var numberSet: [UInt64: UInt64] = [0: 0, 1: 1]

func fib(for number: UInt64) -> UInt64 {
    if number == 0 { return 0 }
    if number == 1 { return 1 }
    
    let previousNumber = numberSet[number - 1] ?? fib(for: number - 1)
    let previousNumber2 = numberSet[number - 2] ?? fib(for: number - 2)
    let sum = previousNumber + previousNumber2
    
    numberSet[number] = sum
    
    return sum
}

func productFib(_ prod : UInt64) -> (UInt64,UInt64,Bool) {
    var value: UInt64 = 0
    var firstFIB = fib(for: value)
    var secondFIB = fib(for: value + 1)
    var mult = firstFIB * secondFIB
    
    while mult < prod {
        value = value + 1
        firstFIB = secondFIB
        secondFIB = fib(for: value + 1)
        mult = firstFIB * secondFIB
    }
    
    if mult == prod {
        return (firstFIB, secondFIB, true)
    } else if mult > prod {
        return (firstFIB, secondFIB, false)
    } else {
        fatalError()
    }
}
