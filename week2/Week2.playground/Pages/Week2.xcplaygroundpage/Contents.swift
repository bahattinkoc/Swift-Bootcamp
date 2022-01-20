// stride araştır??

import UIKit
import Foundation
import Security

// Array - Dizi
// Aynı veri türünde olan değerleri tutar, dilenirse farklı türlerde de veri tutabilir (Any ile)
var cars = ["Mercedes", 3] as [Any]
var varsString = ["Mercedes", "BMW"]

// boş string arrayler
var cities: [String] = []
var anotherCities: Array<String> = Array()
var anotherCities2 = Array<String>()
var anotherCities3 = [String]()

//Array e eleman ekleme ve indis kavramı
cities.append("Samsun")
cities.append("Bursa")
cities.append("Antalya")
cities.append("Adana")

cities.first
cities[0]
cities.endIndex
cities.last
cities[cities.endIndex - 1]
cities[cities.count - 1]
cities[3]

var stringArray = Array(repeating: "Balık", count: 3)

// Array in Array ?? (matrisler any oluyor)
let matrix = [
    ["A", "B", 4],
    [1, 2, 3]
]

matrix[0][2]
matrix.first?.last

// Numeric diziler
var numberArray = [1, 2, 3]
numberArray.max()
numberArray.min()

// Tuple örneği -Tuples in switch
let switchTuple = (firstCase: true, second: false)
switch switchTuple {
case (true, true):
    print("İkiside doğru")
case (true, false):
    print("İlki doğru ikincisi yanlış")
case (false, true):
    print("İlki yanlış ikincisi doğru")
case(false, false):
    print("ikiside yanlış")
}

// SET (Unordered) (Kümeler) -> Swift (yaklaşık)5.4 ile Ordered Set kavramı geldi
// Mülakat sorusu
// Array ile Set arasındaki fark nedir?
// Sette mükerrer(tekrar) eleman bulunmaz. Set Hashable protokolü?

var colors = Set<String>() // elemanları string olan boş bir küme
var myColors: Set<String> = ["Siyah", "Beyaz", "Yeşil", "Lacivert", "Sarı", "Kırmızı", "Bordo", "Mavi"]
myColors.count

var animals: Set<String> = ["Ateş", "Pars", "Osman", "Rahmetli Çiko", "Pala", "Sopa", "Kartal", "Doğan"]
var myCars: Set<String> = ["Kartal", "Doğan", "Audi", "Cadillac", "BMW"]
var anotherCars: Set<String> = ["Anadol", "Kartal"]

// Kesişim (Intersection)
let intersection1 = animals.intersection(myCars)
let intersection2 = myCars.intersection(anotherCars)

//Birleşim (union)
let union1 = myCars.union(anotherCars)
let mySet: Set<String> = ["Ali", "Ali", "Ahmet"]

// Ödev
// Bir sınıfta en az bir yazılım dili bilenlerin sayısı 24, sadece Swift bilenler 12, sadece Kotlin bilenler 8 olduğuna göre her iki dili bilen kaç kişi vardır? (sınıf: 24)
let sınıf: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
let switf: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
let kotlin: Set<Int> = [13, 14, 15, 16, 17, 18, 19, 20]


// Fark ? symmetricDifference
// Alk küme ? subtracking

// Dictionary - unordered, ordered(swift 5.4? ile geldi) yapı
// Bir anahtar sözcük ve onun değerini tutan bir yapı
var hayvanlar3: Dictionary<String, String> = Dictionary<String, String>() // Boş dictionary
var hayvanlar1 = [String:String]() // Boş dictionary
var hayvanlar2: [String:String] = [:] // Boş dictionary

var hayvanlar: [String:String] = ["Ateş":"Kedi", "Pars":"Köpek", "Rahmetli Çiko":"Kuş"]
hayvanlar["Ateş"]
hayvanlar["Ateş"] = "Balık"

for hayvan in hayvanlar.keys{
    print(hayvan)
}

for hayvan in hayvanlar.values{
    print(hayvan)
}

hayvanlar.updateValue("Jaguar", forKey: "Ateş")
hayvanlar

var plate: [Int:String] = [34:"İstanbul", 16:"Bursa", 06:"Ankara", 42:"Konya", 49:"Muş", 48:"Muğla"]
var otherdictionary = [String:Any]()


// Fonksiyonlar
func sayHi(){
    print("Hi")
}
sayHi()

// NUM1
func sayHi2(name: String) {
    print("Merhaba \(name)")
}
sayHi2(name: "Bahattin")

// NUM2
func greeting(name: String) -> String{
    return "Merhaba " + name
}
var msg = greeting(name: "Bahattin")

// Homework: NUM1 vs NUM2 tarafını seç neden?

func greeting(name: String, age: Int) -> String{
    return "Merhaba ben \(name) ve \(age) yasindayim"
}
greeting(name: "Bahattin", age: 23)

// Thing about it: Bir fonksiyonun kaç geri dönüş tipi olabilir? -> Cevap 1 değil
func anything() -> (a: Int, b: Int, c: Int){
    return (1, 2, 3) // Tuple döndürdük
}

// Variadic function - parametre olarak sonsuz değer alınması gerekiyorsa
func sumVariadicFunction(numbers: Int ..., y:String){
    print("\(y): \(numbers)")
}
sumVariadicFunction(numbers: 1,2,3,4,5, y: "Sayılar")

func value(x: inout Int) { // inout dersek x artık let olmayacak. Artık x'i değiştirebileceğiz
    x = 5
    x = x + 1
    print(x)
}
var aa = 3
value(x: &aa)


//*******************
// CLOSURES - Block, Lambda, Arrow function
// İsmi olmayan, parametre alıp geriye değer döndürebilen bir değişkene atanabilen, bir fonksiyona parametre olarak verilebilen kod bloğuna denir.
//*******************

// () -> ()     () -> Void
let selamVer: () -> () = {
    print("Merhaba")
}
selamVer()

// İsim parametresi alan bir closure
let selamVer2: (String) -> () = { name in
    print("Merhaba \(name)")
}
selamVer2("Bahattin")

//Birden fazla parametre alan ve dönüş tipi olan bir closure
let compare: (Int, Int) -> (Bool) = { (say1, say2) in
    return say1 < say2
}
compare(30, 5)
compare(5, 7)

//Int, Int tipinde parametre alıp geriye (Int) dönen bir closure yazınız
let sum: (Int, Int) -> (Int) = { (x, y) in
    return x + y
}
sum(3, 5)

let names = ["Mert", "Bahattin", "Zeyneb", "Hümeyra", "Berke", "Ali Can"]
// Benim yaptığım
let sirala: (Array<String>) -> (Array<String>) = {dizi in
    return dizi.sorted()
}
// Hocanınki
let sortedNames = names.sorted{(x: String, y: String) -> Bool in
    return x > y
}
sortedNames

let sortedNames2 = names.sorted{ (x, y) -> Bool in
    return x < y
}
sortedNames2

let sortedNames3 = names.sorted{ (x, y) in
    return x < y
}
sortedNames3

let sortedNames4 = names.sorted{
    $0 < $1 // iki parametre al ve karşılaştır
}
sortedNames4

let sortedNames5 = names.sorted(by: <) // Hocanın tercih ettiği bu
sortedNames5

// Bir fonksiyona parametre olarak verilmesi
func myFunction(myClosure: () -> Void){
    print("My function started...")
    myClosure()
    print("My function end...")
}
let exampleClosure = {
    print("My closure running..")
}
myFunction(myClosure: exampleClosure)

// Return tipinde closure kullanımı
func buy() -> (String) -> Void {
    return {
        print("\($0) satın aldım")
    }
}
func sell(price: Int) -> (Int) -> Void {
    return {
        print("\($0 - price) fiyata sattım")
    }
}
let result = buy()
result("Zeytin")
let sellResult = sell(price: 30) // (3) ünde çalışıyor olması lazım
sellResult(3)

//Completion Handler (Closure türü)
/*
 Muhtemelen en fazla kullanacağımız closure türü.
 HTTP isteği gibi uzun bir işlem yapmak istediğimizi varsayalım
 İsteğin tamamlanmasından hemen sonra bir şeyler yapmak isteyelim
 Ancak sürecin devam edip etmediğini birden çok kez kontrol etmek sizin için maliyetli olacaktır
 Bu durumda completion handler işinizi görecektir
 Completion handler uzun işlem tamamlanır tamamlanmaz geri çağrılan bir closure dır.
 */
// kesinlikle bu değiken var demek için değişkenin yanına ! koyarız. data!
let handler: (Data?, URLResponse?, Error?) -> () = { (data, res, err) in
    print(String(data: data!, encoding: .utf8)!)
}
let url = "https://gelecegiyazanlar.turkcell.com.tr"
let myURL = URL(string: url)
/*let task = URLSession.shared.dataTask(with: myURL!) { (data, res, err) in
    print(String(data: data!, encoding: .utf8)!)
}.resume()
*/

let task = URLSession.shared.dataTask(with: myURL!, completionHandler: handler)
//task.resume()

// non -escaping vs @escaping
/*
 - non-escaping: closure sadece kendi bloğunda çalışabilir, blok dışında çalışmaz
 non-escaping kullanıyorsanız compiler bu closureın kod bloğu dışında çalıştırılmak istemediğini bilir
 
 - escaping: non-escaping in tersi şeklindedir. Başka yerde çağırmak istediğimiz zaman @escaping kullanırız. Swift te siz non-escaping yazmasanızda defult olarak tanımlıdır. ancak başka yerde sonucunu kullanmak istiyorsanız @escaping yazmalısınız.
 */

//******************************************

// ENUMs
/*
 Enums
 ->
 */
enum Direction {
    case right
    case left
    case top
    case bottom
}

// Tek case altında toplama
enum Direction2 {
    case right, left, top, bottom
}

//Kullanım örneği
let leftSide = Direction.left
let downSide: Direction = .bottom // nokta notasyonu ile ulaşma

enum Numbers: Int {
    case first = 1, second, third, fourth, fifth
}
let besinci = Numbers.fifth
print(besinci.rawValue) // firste 1 dediğimiz için kalanlara otomatik 1 artırıp ekliyor

enum Hata: Error {
    case senucuHatasi(sebep: String)
    case kullaniciHatasi(sebep: String)
}
let hata = Hata.kullaniciHatasi(sebep: "Parolayi unuttu!")
print(hata)

enum Cities: String {
    case İzmir = "Boyoz"
    case Hatay = "Künefe"
    case Zonguldak = "Kestane Balı"
    case Bursa = "İskender"
    case Maraş = "Dondurma"
    case Adana = "Bici Bici"
    case Samsun = "Pide"
}
let city = Cities.Adana
print(city) // adana
print(city.rawValue) // bici bici

// bir fonksiyona parametre olarak enum verme
func move(direction: Direction){
    print("Oyuncu \(direction) yönüne hareket etti.")
}
move(direction: .right)

let direct: Direction = .right
switch direct{
    case .right:
        print("rigth")
    case .left:
        print("left")
    case .top:
        print("top")
    case .bottom:
        print("bottom")
}

// Nested -> İç içe enum kullanımı
enum Orchestra{
    enum Strings{
        case guitar
        case baglama
    }
    enum Percussion{
        case drums
        case bell
    }
    enum Keyboards{
        case piano
        case org
    }
}
let instrument = Orchestra.Keyboards.org
let instrument2 = Orchestra.Percussion.drums
let instrument3 = Orchestra.Strings.guitar

// Optionals
// BACKEND e ASLA GÜVENME (veri her zaman gelmeyebilir)
// Veri tanımlarken mutlaka ? kullan
var number: Int?
number = 3
print(number ?? 0)

//if -let kullanımı
if let sayi = number{
    // nil değil ise
    print("number: \(sayi)")
} else {
    // nil ise
    print("number was not assigned a value")
}

var sehir: String?
sehir = "Ankara"
print(sehir ?? "Undefined city")
print(sehir!) // Ünlem - Force lamak zararlı olabilir
print(sehir as Any)

if let il = sehir {
    print("sehir: \(il)")
} else {
    print("Undefined city")
}

struct Member{
    var name: String?
    var email: String?
    var passwd: String?
}

var member = Member(name: "Kerim", email: "kerim.caglarr@gmail.com", passwd: "123456")
func getMember(member: Member){
    if let name = member.name, let email = member.email, let passwd = member.passwd {
        print(name)
        print(email)
        print(passwd)
    } else {
        print("Verileriniz okunamadı")
    }
}
getMember(member: member)

// guard let .... else{}
func uyeGetir(uye: Member){
    guard let name = uye.name, let email = uye.email, let passwd = uye.passwd else {
        print("Veriler okunamadı")
        return
    }
    print(name)
    print(email)
    print(passwd)
}

let uye = Member(name: "Esin", email: "esin@gmail.com", passwd: nil)
uyeGetir(uye: uye)


// HOMEWORK: if let ve guard let arasındaki farkı bir kaç cümle ile açıklayınız. txt ile yaz ekle.

//**************************
// ERROR HANDLING
//**************************

// try, try?, try!

enum NameError: Error {
    case tooLong
    case tooShort
}

func nameValidation(name: String) throws -> String {
    if name.count > 8{
        throw NameError.tooLong
    } else if name.count < 2 {
        throw NameError.tooShort
    } else {
        return name
    }
}

// try: Hata varsa ben onu yakalarım. Do - try - catch yapısını severim

do {
    _ = try nameValidation(name: "Bahattins")
} catch NameError.tooLong {
    print("Your name is too long")
} catch NameError.tooShort {
    print("Your name is too short")
}


// try?: Hatayı herkes yapabilir. Do catch kullanılmasına ihtiyacım yok
if let isim = try? nameValidation(name: "Hilal") {
    print("Name is valid: \(isim)")
} else {
    print("Name is non valid")
}

// try!: Ben hatalar hiç sevmem hata yakalarsam bozuluurm :)
// do or die yaklaşımıyla hata yakaları
let result2 = try! nameValidation(name: "Hfgk")

// Hesap Makinası Similasyonu
var screen = "0.0"
enum CalculateError: Error {
    case nanError // 0 / 0 hatası
    case InfError // 0'a bölme hatası
    case baseCase // bölünen 0 ise
}

func division(bolunen: Double, bolen: Double) throws -> Double{
    guard bolunen != 0 || bolen != 0 else {
        print("NaN Error")
        throw CalculateError.nanError
    }
    
    guard bolunen != 0 else {
        print("Base case durumu")
        throw CalculateError.baseCase
    }
    
    guard bolen != 0 else {
        print("Infinite case durumu")
        throw CalculateError.InfError
    }
    
    return bolunen / bolen
}

do{
    try division(bolunen: 0, bolen: 1)
} catch CalculateError.baseCase{
    screen = "0.0"
} catch CalculateError.InfError{
    screen = "Inf"
} catch CalculateError.nanError{
    screen = "NaN"
}

// swiftbysundell.com/basics/loops
// exercism deki 30 kolay soruyu ve 10 medium soruyu çözünüz
// project euler den 4,5,6 sorular swift kullanılarak çözülecek

// Soru1: Verilen bir kelimenin veya sayının terstende aynı okunup okunmadığını kontrol eden bir swift programı yazınız. Palindrome
//Örnek: Ey edip adanada pide ye, 9009

// Bir sayının asal sayı olup olmadığını anlamak için nasıl bir kod yazarsınız

//Ödev-> Değer döndürmeyip print ile çıktı veren fonksiyon ile return ile değer döndüren fonksiyon kullanım tercihinizi belirtiniz? nedenleri?
