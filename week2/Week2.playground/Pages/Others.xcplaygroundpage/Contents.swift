//Diğer Ödevler

import Foundation

/*
 Soru1: Verilen bir kelimenin veya sayının terstende aynı okunup okunmadığını kontrol eden bir swift programı yazınız. Palindrome
 Örnek : Ey Edip adanada pide ye, 9009
 */

func isPalindrome(script: String){
    let _script = Array(script.lowercased())
    var palindrome: Bool = true
    var left: Int = (script.count / 2) - 1
    var right: Int = left + 1
    
    if script.count % 2 != 0{
        right += 1
    }
    
    while left >= 0 && palindrome{
        // print("Left: \(_script[left]) - right: \(_script[right])")
        if _script[left] != _script[right]{
            palindrome = false
        }
        right += 1
        left -= 1
    }
    if palindrome{
        print("Is \(script) palindrome?: \(palindrome)")
    }
}

func isPalindrome(number: Int){
    // Bu kodun aynısı Project Euler 3. sorusu ile birlikte çözüldü.
}

// isPalindrome(script: "Ey Edip adanada pide ye")






































//Bir sayının asal sayı olup olmadığını anlamak için nasıl bir kod yazarsınız? (Karekök kullanın)
func isPrime(x: Int){
    var prime: Bool = true
    var i: Int = 2
    let squareRoot = SquareRoot(x: x) // Bunun yerine x.squareRoot() ta kullanılabilir
    while i < squareRoot && prime{
        var j: Int = i
        while j >= 2{
            if x % j == 0{
                prime = false
            }
            j -= 1
        }
        i += 1
    }
    
    print("Is \(x) is prime: \(prime)")
}

// Sayıya en yakın karekök değerini buluyor.
func SquareRoot(x: Int) -> Int{
    var i: Int = 1
    while i*i <= x{
        i += 1
    }
    return i
}

// isPrime(x: 317)







































//Bir sınıfta en az bir yazılım dili bilenlerin sayısı 24, sadece swift bilenler 12, sadece kotlin bilenler 8 olduğuna göre her iki dili bilen kaç kişi vardır. (Sınıfta 24 kişi var, sadece swift ve kotlin bilinmekte.)

var _class: Set<Int> = Set()
while _class.count < 25{
    _class.insert(_class.count + 1)
}
print(_class)

var swift: Set<Int> = Set()
while swift.count < 13{
    swift.insert(swift.count + 1)
}
print(swift)

var i: Int = 13
var kotlin: Set<Int> = Set()
while i < 22{
    kotlin.insert(i)
    i += 1
}
print(kotlin)

print(_class.symmetricDifference(swift.union(kotlin)).count)
































// Değer döndürmeyip print ile çıktı veren fonksiyon ile return ile değer döndüren fonksiyon kullanım tercihinizi neye göre belirlersiniz.
/*
 Eğer fonksiyon sonucuna göre bir şeyleri gerçekleştirecek isem return kullanmam gerekir.
 Eğer fonksiyon sonucu bizim için önemli değil fonksiyon işini yapsın bizede sadece mesaj versin diyorsak print kullanarak bastırmamız yeterli olur.
 */





































// HW: if let ve gurad let arasındaki farkı bir kaç cümle ile açıklayınız.
/*
 If let koşul nil olmadığı sürece çalışıyor. Fakat guard let koşulun tanımlı / nil olup olmadığını kontrol ediyor ve olumsuz olan her durumda return kullanılarak fonksiyondan çıkış sağlanıyor. Bu sayede ekstra bir koruma kalkanı oluşturmuş oluyor aslında.
 */

var _name: String?
func guardLet() {
    guard let name = _name else { // nil ise giriyor ve fonksiyondan çıkıyor. bir nevi continue gibi
        print("exit")
        return
    }

    print(name)
}

func ifLet() {
    if let name = _name { // nil ise girmiyor
        print(name)
    }
}

// guardLet()
// ifLet()





































/*
 Fonksiyona parametre olarak verilen sayıya göre + - karakterlerini ekrana yazdıran bir fonksiyon yaınız.
 Örneğin 1 için sadece +, 2 için +-, 5 için +-+-+ şeklinde olmalıdır
 */
func plusMinus(x: Int){
    var _x: Int = 1
    var _text: String = ""
    while _x <= x{
        if _x % 2 == 1{
            _text.append("+")
        } else {
            _text.append("-")
        }
        _x += 1
    }
    print(_text)
}

// plusMinus(x: 5)






































/*
 Fonksiyona parametre olarak verilen sayıyı en büyük yapacak şekilde 5 sayısını yanına koyunuz.
 Örneğin parametre 0 için çıktı 50 olmalıdır. Parametre 28 için 285, parametre 920 için 9520 olmalıdır
 */

// Sayının kaç basamak olduğunu buluyoruz
func findDigit(x: Int) -> Int{
    // kaç basaklı olduğunu bul
    var digit: Int = -1 // Basamak sayısını tutuyor
    var bolen: Int = 1 // Böleni tutuyor
    var result: Int = 2 // bölünen / bölen 'i tutuyor. Koşula girmesi 1den büyük bir şey verdik.
    while result >= 1{
        result = x / bolen
        digit += 1
        bolen *= 10
    }
    return digit
}

// Sayıları rakamlarından oluşan bir diziye dönüştürüyor
func returnNumberToArray(x: Int) -> Array<Int>{
    var digits: Array<Int> = Array()
    var digit: Int = (x == 0) ? 1 : findDigit(x: x)
    var _x = x
    while digit >= 1{
        digits.append(_x % 10)
        _x /= 10
        digit -= 1
    }
    return digits.reversed()
}

func doMax(x: Int){
    var digits: Array<Int> = returnNumberToArray(x: x)
    var i: Int = 0
    while i < digits.count{
        if 5 >= digits[i]{
            digits.insert(5, at: i)
            break
        }
        i += 1
    }
    
    print(digits)
    
    var retValue: Int = 0
    var carpan: Int = 1
    i = digits.count - 1
    while i >= 0{
        retValue += carpan * digits[i]
        i -= 1
        carpan *= 10
    }
    
    print(retValue)
}

// doMax(x: 28)
