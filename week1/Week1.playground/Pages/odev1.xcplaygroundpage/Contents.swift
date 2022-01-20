import Foundation
// Homework 1
/*
 1- Elimizde sadece harferden oluşan (noktalama işareti ve sayılar yok) uzun stringler olsun. Bu stringler içerisinde bazı ifadelerin tekrar ettiğini düşünün. Mesela 'a' harfi 20 farklı yerde geçiyor. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfleri siliniz. Sonra geriye kalan stringi ekrana yazdırınız.
 Sayı kullanıcıdan alınacak.
 
 Örnek string: "aaba kouq bux"
 Tekrar sayısı: 2 verildiğinde: a,b,u silinmeli ve ekrana "koq x" yazılmalı
 
 Tekrar sayısı 3 verildiğinde: a silinmeli ve ekrana "b kouq bux"
 Tekrar sayısı 4 verildiğinde: hiçbir şey silinmeyecek
 */

func findRepeats(script: String, repeatCount: Int) -> String{
    let arrayScript = Array(script)
    var value = script
    var i: Int = 0
    while i < arrayScript.count{
        var j = 0
        var counter = 1
        while j < arrayScript.count{
            if arrayScript[i] == arrayScript[j] && i != j && arrayScript[i] != " " { // boşlukları ve kendini önemseme
                counter += 1
                if counter >= repeatCount{
                    value = replaceChar(script: value, replaceChar: arrayScript[i])
                    break
                }
            }
            j += 1
        }
        
        i += 1
    }

    return String(value)
}

func replaceChar(script: String, replaceChar: Character) -> String{
    var newString: Array<Character> = Array()
    for item in script{
        if item != replaceChar{
            newString.append(item)
        }
    }
    // charArray[index] = replaceChar
    return String(newString)
}


var present = findRepeats(script: "aaba kouq bux", repeatCount: 2)
print(present) // koqx
present = findRepeats(script: "aaba kouq bux", repeatCount: 3)
print(present) // b kouq bux
