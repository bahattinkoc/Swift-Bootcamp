import UIKit

var greeting = "Hello, playground" // sonradan değişebiliyor
let merhaba = "Merhaba, Turkcell eğitimine hoşgeldiniz!" // constant
greeting = "Merhaba, Playground"
// merhaba = "Hello" // let olduğundan hata veriyor
let çağlar = "deneme" // swift türkçe karakter desteği veriyor
var 🤟🏼 = "El" // emoji ile değişken tanımlama
let π = 3.14 // pi
let kalp = "/u{2764}" //unicode

var x = 2 // var veya let kullanırsan sadece değişken türünü otomatik atar
var y : Double = 3
print(y)

let a : Int = Int(3.14)
let version = 4

print("Swift \(version) kullanıyorum")

let b : Character = "y"

// Tek satır yorum
/*
 Çok satır yorum
 */

var name: String?
name = nil // nil = boş/null
print(name ?? "Girilmedi")
name = "Bahattin"
name?.count

for item in name! { // Değişken kesin var demek istiyor ! ile
    print(item)
    print(type(of: item))
}

var version2 = 15
let myVersion = 5

if version2 > 13{
    print("SwfitUI yazılabilir")
}else if version2 == 12 {
    print("1 sürüm artırmalısınız")
} else{
    print("Iphone mı kullanıyorsun?")
}

// Ternary IF
version2 > 13 ? print("Yazabilirsin") : print("Yazamazsın")
// version2 > 13 ? TRUE : FALSE

//tubles = birbirinden farklı değişken türlerini bir arada tutan şey
let tuples = (404, "Not Found")
print(tuples.0)
print(tuples.1)
let tuplesList = (tuples)

// isimli tuples
var namesTuples = (first:1, middle: 2, last: 3)
namesTuples.first
namesTuples.middle

// sonradan değer belirleme
var numberTuples : (optionalFirst:Int?, middle:String, last:Int)?
numberTuples = (nil, "Bahattin", last: 3)
numberTuples?.last

// Soru: Merkezi (0,0) olan yarıçapı 1 olan bir çember tanımlayınız
// let center = (x:0, y:0)
typealias Circle = (center: (x: CGFloat, y:CGFloat), radius: CGFloat) // struct gibi bir şey
let unitCircle: Circle = ((0.0, 0.0), 1)

var a1 = 3
var a2 = 4

(a1, a2) = (a2, a1) // Yerdeğiştirme
print(a1)
print(a2)

// Ödevler
/*
 1- Elimizde sadece harferden oluşan (nktalama işareti ve sayılar yok) uzun stringler olsun. Bu stringler içerisinde bazı ifadelerin tekrar ettiğini düşünün. Mesela 'a' harfi 20 farklı yerde geçiyor. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfleri siliniz. Sonra geriye kalan stringi ekrana yazdırınız.
 Sayı kullanıcıdan alınacak.
 
 Örnek string: "aaba kouq bux"
 Tekrar sayısı: 2 verildiğinde: a,b,u silinmeli ve ekrana "koq x" yazılmalı
 
 Tekrar sayısı 3 verildiğinde: a silinmeli ve ekrana "b kouq bux"
 Tekrar sayısı 4 verildiğinde: hiçbir şey silinmeyecek
 */

/*
 2- Elimizde yine uzun bir cümle olsun. Bazı kelimeler tekrar ettiği bir cümle düşünün. İstediğimiz ise hangi kelimeden kaç tane kullanıldığını bulmak.
 
 String: "Merhaba nasılsınız. İyiyim siz nasılsınız bende iyiyim"
 Merhaba 1
 nasılsınız 2
 iyiyim 2
 siz 1
 bende 1
 */

/*
 3- Cuma akşamı anlatılan script örneğinin, isimlerin hepsini büyük harfle yazdırıp. İsimleri tersten sıralayacak ve isimlerin hepsini büyük yazdıracak. Z-A ya sıralanacak. masaüstünde resmi var
 */

/*
 4- EulerProject ilk 3 soruyu çöz. projecteuler.net/archives
 
 */
