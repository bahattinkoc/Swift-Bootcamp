import UIKit

/*
 EXTENSIONS
 -> Class (Int, Color, String) Struct gibi yapılara standartta tanımlı olmayan yeni bir özellik tanımlamaya yarar
 */

var a = 2.0
var b = 685.0

var c = a / b// 0.003 e yuvarlanırdı    floor, ceil, rounded

// Virgülden sonra 2 basamak için 100 ile çarp (10^2)
// 0.1253 => 12.53
// Sayıyı yuvarla
// 12.53 => 13
// Çarptığınız sayıya bölün
// 0.13

// Yukarıdaki c sayısını virgülden sonra 3 basamak yuvarlama (10^3)
var d = (c * 1000)
d = d.rounded()
d /= 1000

// extensionu her zaman yazıyoruz yanınada neye extension yazacak isek onu yazıyoruz
extension Double {
    func sayiyiYuvarla(basamak: Int) -> Double{
        let carpan = pow(10.0, Double(basamak))
        return (self * carpan).rounded() / carpan
    }
}

var e = 0.002919702342345
e.sayiyiYuvarla(basamak: 3)

// Int sayının küpünü alan extensions
extension Int{
    func kupAl() -> Int{
        self*self*self
    }
    
    mutating func kareAl() { // değişken üzerinde yapmak zorundasın
        self = self * self
    }
    
    func kareAlmak() -> Int{
        return self * self
    }
    
    ///Sayının çift olup olmadığını kontrol eder (Açıklayıcı metin. Intellisense te gözükür.)
    func ciftMi() -> Bool{
        return self % 2 == 0 // tek satırlı cevaplarda return demesekte çalışır
    }
}

var f = 7
f.kupAl()


var aaa = 3
aaa.ciftMi()











/*
 GENERICS
 Tipten bağımsız şekilde kullanıma izin veren yapılar
 */

let cities = ["Alanya", "Konya", "Denizli"]
let numbers = [1, 2, 3]
let doubles = [3.14, 5.2, 6.3]

func myCities(cities: [String]){
    for city in cities {
        print(city)
    }
}

myCities(cities: cities)

//Generic fonksiyon
func anyArray<T>(array: [T]){ // T sembolik değiştirebilirsin
    array.map {
        print($0)
    }
}
anyArray(array: numbers)


// Genericleri kullanarak iki sayının toplamını yapan bir fonk yapınız
func sumNumber<T: Numeric>(x: T, y: T) -> T{ // Tip vermediğimiz için Numeric protolünü ekledik + yı kullandığımız için
    return x + y
}

var x = sumNumber(x: 34, y: 23)

// in gerekli değil sadece okunurluk katmak için ekledik
// bulumayacağı ihtimali için Int? dedik (nil döndürmek)
// Equatable: Eşit olup olmadığını karşılaştıran protokol
func find<T: Equatable>(element: T, in items: [T]) -> Int? {
    for (index, item) in items.enumerated(){
        if item == element{
            return index
        }
    }
    return nil
}

if let result = find(element: "Alanya", in: cities){ // nil ise if let e girmez
    print(result)
}













/*
 CLASS & Struct -> Mülakatlarda sorulmama olasılığı %3
 Class -> Reference Type (bir değişkeni bir değişkene aktarıp ilk değişkeni değiştirirsen ikinciside değişir) -> Inheritence Var -> (Daha yavaş: Heapte tutulur)
 Struct -> Value Type (referance değil) (bir babanın iki çocuğuna bıraktığı miraz. çocukların ne yaptığı birbirini etkilemiyor) -> Protocol var -> Hızlıdır (Sebep: Stackte tutulur)
 */

class Arac{
    //Stored propertyler
    var tekerlekSayisi: Int = 0
    var renk: String
    
    // Constructer
    init(tekerlekSayisi: Int, renk: String){
        self.tekerlekSayisi = tekerlekSayisi
        self.renk = renk
    }
}

let mercedes: Arac = Arac(tekerlekSayisi: 4, renk: "Beyaz")
print(mercedes.renk)

let mercedes2 = mercedes
mercedes.renk = "Siyah"
mercedes.renk
mercedes2.renk // Reference Type




struct Araba{
    var model: Int
    var yakitTipi: String
}

var araba = Araba(model: 2022, yakitTipi: "Hibrit")
var araba2 = araba

araba.model = 2023
araba2.model // Reference Type DEĞİL!!!!






class Engine {
    var engineVolume: Int = 1600
}

class Vehicle {
    var model: Int = 2021
    var engine: Engine
    
    init(){
        engine = Engine()
    }
}

class Arabam: Vehicle{
    var tekerlekSayisi: Int
    var renk: String
    
    init(tekerlekSayisi: Int, renk: String){
        self.tekerlekSayisi = tekerlekSayisi
        self.renk = renk
    }
}

let arabam = Arabam(tekerlekSayisi: 4, renk: "Kırmızı")



/* Struct kalıtım alamaz protokol alır
struct Shape {
    var name: String
}

struct Square: Shape{
    var edge: Int
}
*/


/*
 PROTOCOLS
 Interface
 OOP -> POP (Protocol Oriented Programming)
 Sözleşme gibidirler. Uyulması zorunludur (beklenir).
 Method, property taslak olarak tanımlanır
 */

protocol Player{
    var playerName: String {get}
    var alive: Bool {get set}
    var health: Int {get set}
    
    func shot()
}

enum Genre{
    case war
    case race
}

class Game: Player{
    var playerName: String

    var alive: Bool = true

    var health: Int = 3

    func shot() {
        if health > 0{
            health -= 1
            if health == 0{
                alive = false
            }
        } else {
            alive = false
        }
        
        let healtStatus = alive ? String(repeating: "❤️", count: health) : "☠️"
        print("\(playerName), healt status: \(healtStatus)")
    }
    
    var name: String
    var platform: String
    var genre: Genre
    
    init(playerName: String, name: String, platform: String, genre: Genre){
        self.playerName = playerName
        self.name = name
        self.platform = platform
        self.genre = genre
    }
}

var gta = Game(playerName: "Tony", name: "GTA", platform: "Mobile", genre: .war)
gta.shot()
gta.health
gta.alive

gta.shot()
gta.health
gta.alive

gta.shot()
gta.health
gta.alive





protocol LessThan {
    static func < (lhs: Self, rhs: Self) -> Bool
}

// İlk sayının ikinci sayıdan küçük olup olmadığını dönen bir fonksiyon

func compare<T: LessThan> (x: T, y: T) -> Bool {
    if x < y {
        print("İlk sayı ikinciden küçüktür")
        return x < y
    } else {
        print("İlk sayı ikinciden büyüktür")
        return y < x
    }
}

extension Int: LessThan {} // Sayılar int olduğu için Int 'e extension yazdık
extension Double: LessThan {}

compare(x: 2, y: 5)
compare(x: 3, y: 3.14)























// ODEVLER

// (Yapıldı) HW: Girilen sayının asal olup olmadığını bulan bir extension yazınız
// HW: İki parametreli ve FARKLI tipli bir generic örneği yapınız (T, U)
// HW: Şişe vurma oyununu kodlayınız (Detaylar PDF dosyasında verilecektir)
// Şişe, oyuncu ve oyun class-struct
// (Yapıldı) Euler 7
