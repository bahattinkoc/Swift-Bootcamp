// Project Euler Odevleri

import Foundation


// 4 - Largest palindrome product
/*
 A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

 Find the largest palindrome made from the product of two 3-digit numbers.
 */

// Soruyu çözen fonksiyon
func findMaxPalindrom(){
    var i: Int = 100
    var j: Int = 100
    
    var firstTemp: Int = i
    var secondTemp: Int = j
    
    while i <= 999{
        while j <= 999{
            let palindrome = isPalindrome(x: i * j)
            if palindrome{
                if i * j > firstTemp * secondTemp{
                    firstTemp = i
                    secondTemp = j
                }
            }
            print("Numbers: \(i) * \(j)")
            j += 1
        }
        j = 100
        i += 1
    }
    
    print("Max palindrome is \(firstTemp) * \(secondTemp): \(firstTemp * secondTemp)")
}

// Sayının kaç basamak olduğunu buluyoruz
func findDigit(x: Int) -> Int{
    // kaç basaklı olduğunu bul
    var digit: Int = -1
    var bolen: Int = 1
    var result: Int = 2
    while result >= 1 {
        result = x / bolen
        digit += 1
        bolen *= 10
    }
    return digit
}

// Sayıları rakamlarından oluşan bir diziye dönüştürüyor
func returnNumberToArray(x: Int) -> Array<Int>{
    var digits: Array<Int> = Array()
    var digit: Int = findDigit(x: x)
    var _x = x
    while digit >= 1{
        digits.append(_x % 10)
        _x /= 10
        digit -= 1
    }
    return digits
}

// Palindrome olup olmadığını buluyoruz
func isPalindrome(x: Int) -> Bool{
    let digits: Array<Int> = returnNumberToArray(x: x)
    let digit: Int = findDigit(x: x)
    var palindrome: Bool = true
    var left: Int = (digit / 2) - 1
    var right: Int = (left + 1)
    
    if digit % 2 != 0{ // Sayı tek ise sağ taraftaki indisi 1 artır
        right += 1
    }
    
    while left >= 0 && palindrome{
        // print("Left: \(digits[left]) - right: \(digits[right])")
        if digits[left] != digits[right]{
            palindrome = false
        }
        right += 1
        left -= 1
    }
    if palindrome{
        print("Is \(x) palindrome?: \(palindrome)")
    }
    return palindrome
}

// print(isPalindrome(x: 10200))
// findMaxPalindrom()






































// 5 - Smallest multiple
/*
 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

 What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
 */

// Sayıları çarpanlarına ayırıyoruz
func findPrimeFactor(x: Int) -> Array<Int>{
    var primes: Array<Int> = Array()
    var _x = x
    var i = 2
    while _x > 1{
        if _x % i == 0{ // tam bölünebiliyor ise ekle
            primes.append(i)
            _x /= i
            i = 2
        } else{
            i += 1
        }
    }
    return primes
}

// Dizide verilen elemanın adetini bul
func countElement(array: Array<Int>, element: Int) -> Int{
    var count: Int = 0
    for item in array{
        if item == element{
            count += 1
        }
    }
    return count
}

func findMinValueFromGivenNumber(x: Int){
    var primes: Array<Int> = Array()
    var i: Int = 1
    while i <= x{
        let tempArray: Array<Int> = findPrimeFactor(x: i)
        for item in tempArray{
            var dif: Int = countElement(array: tempArray, element: item) - countElement(array: primes, element: item)
            if dif > 0{
                while dif != 0{
                    primes.append(item)
                    dif -= 1
                }
            }
        }
        i += 1
    }
    
    var result: Int = 1
    for item in primes{
        result *= item
    }
    print("The min value is: \(result)")
}
// findMinValueFromGivenNumber(x: 20)







































// 6 - Sum square difference
/*
 Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
 */

func findSumSquareDif(limit: Int){
    var firstSquareThenSum: Int = 0
    var firstSumThenSquare: Int = 0
    var _limit: Int = limit
    
    while _limit != 0{
        firstSumThenSquare += _limit
        firstSquareThenSum += _limit * _limit
        
        _limit -= 1
    }
    
    firstSumThenSquare *= firstSumThenSquare
    
    print("Sum of the Square: \(firstSumThenSquare)\nSquare of the sum: \(firstSquareThenSum)\nDifference: \(firstSumThenSquare - firstSquareThenSum)")
}

findSumSquareDif(limit: 100)
