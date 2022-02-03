import UIKit

/*
 //MARK: Resim dışında diğer ekrana bir veri göndererek ilk ekrandaki label a yazdırın
 //MARK: Gönderilecek data kullanıcıdan alınmalıdır
 
 //MARK: Bir tableview/collectionview kullanarak listeye eleman ekleyebileceğiniz bir uygulama yapınız, Sağ üste konacak bir + butonu ile açılacak alertview içindeki textfield ile alınan veriyi tableview/collectionview a ekleyiniz.
 
 //Yapıldı. MARK: frame vs bound farkı nedir, açıklayınız?
 //Yapıldı. MARK: static keyword neden kullanırız. Örnek bir kullanım yaparak açıklayınız
 //Yapıldı. MARK: Euler project 8,9,10,11 ödev

 */




//MARK: frame vs bound farkı nedir, açıklayınız?
/*
 Frame: Nesnenin kendi parent'ına göre konumunu, genişlik ve yüksekliğini verir. Genellikle bir nesne bir yere yerleştirilirken kullanılır.
 
 Bounds: Bir nesnenin kendi koordinat sistemine göre konum, genişlik ve yüksekliği verir. Bir nesneyi kendimize ekleyeceğimiz zaman o nesnenin kendi içerimizdeki konumunu belirlemek/öğrenmek istediğimiz zaman kullanırız.
 */












//MARK: static keyword neden kullanırız. Örnek bir kullanım yaparak açıklayınız
// static keywordü diğer dillerdende öğrendiğim kadarı ile tanımlandığı değişkeni hafızanın belirli sabit bir alanın yer ayırarak orada tutuyor ve adresi asla değişmiyor. Bu sayede birden fazla değişken tanımlamak yerine sadece bir değişken tanımlayıp programı her yerinden o adrese ulaşarak değişkenimizi kullanabiliyoruz. Araştırmalarıma göre Swift dilinde de static benzer özelliklere sahip. Örneğin bir class içinde tanımlandığında o classı init etmedende değişkene ulaşabiliyoruz. Buradan da anlaşılacağı üzere genellikle private static olmaz static tanımlanan değişkenler bilinmelidir ki çoğu zaman public olur.

class Shop{
    static let owner: String = "Michael Carleon"
    static var address: String = "Italia"
    static var phone: String = "+9034324234234"
    var productTypeCount: Int
    
    func buyProduct(){
        productTypeCount -= 1
    }
    
    init(productTypeCount: Int){
        self.productTypeCount = productTypeCount
    }
}

print("Static Address: \(Shop.address)")
var shop = Shop(productTypeCount: 45)
print("Product Count: \(shop.productTypeCount)")
shop.buyProduct()
print("Product Count: \(shop.productTypeCount)")















// Euler - 8 | Largest product in a series

func largestProductInSeries(number: String){
    // İç içe iki döngü olsun i, j
    // i baştan sona gitsin, j ise i den başlayarak 13 hane gitsin
    // çarpmadan önde j kontrol edilsin eğer sayı sıfır ise i = j + 1 olsun ve iç döngüden çıksın
    
    let numberArray = Array(number)
    var i = 0
    var j = 0
    var max = 1
    
    while i < number.count{
        var currentMax: Int = 1
        j = i
        while j < i + 13{
            if numberArray[j] == "0"{
                i = j + 1 // eğer sayı sıfır ise oraya kadar atla
                break
            }
            currentMax *= Int(numberArray[j].description) ?? 1
            j += 1
        }
        if currentMax > max{
            max = currentMax
        }
        i += 1
    }
    
    print("Max: \(max)")
}

// largestProductInSeries(number: "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")
// Max: 23514624000
















// Euler - 9 | Special Pythagorean triplet

func findTriplePythagorean(){
    var a = 1
    var b = 1
    var c = 998
    var found = false
    
    while a < 998 / 2 && !found{
        while b < 998 / 2 && !found{
            if (a*a) + (b*b) == (c*c){
                found = true
                print("\(a) + \(b) + \(c) = 1000\n\(a*b*c)")
            }
            b += 1
            c -= 1
            // print("A: \(a) -- B: \(b) -- C: \(c)")
        }
        a += 1
        b = 1
        c = 1000 - a - b
    }
}

// findTriplePythagorean()
// 200 + 375 + 425 = 1000
// 31875000














// Euler - 10 | Summation of primes

func isPrime(number: Int) -> Bool{
    var prime = true
    var _number = 2
    
    while _number <= number / 2 && prime{
        if number % _number == 0{
            prime = false
        }
        _number += 1
    }
    
    return prime
}

func sumPrimes(limit: Int){
    var sum = 0
    var i = 2
    while i <= limit{
        if isPrime(number: i){
            sum += i
        }
        i  += 1
    }
    
    print("Sum of all the primes below limit: \(sum)")
}

// sumPrimes(limit: 2000000)













// Euler - 11 | Largest product in a grid

func largestFour(text: String){
    let list = text.components(separatedBy: " ")
    var i = 3
    var max = 0
    
    while i <= list.count - 4{
        // Up
        if i >= 60{
            let up = (Int(list[i].description) ?? 1) * (Int(list[i - 20].description) ?? 1) * (Int(list[i - 2*20].description) ?? 1) * (Int(list[i - 3*20].description) ?? 1)
            max = (max < up) ? up : max
        }
        
        // Down
        if i <= list.count - 61{
            let down = (Int(list[i].description) ?? 1) * (Int(list[i + 20].description) ?? 1) * (Int(list[i + 2*20].description) ?? 1) * (Int(list[i + 3*20].description) ?? 1)
            max = (max < down) ? down : max
        }
        
        // Left - sol dörtlüleri almıyoruz
        if i % 20 >= 3{
            let left = (Int(list[i].description) ?? 1) * (Int(list[i - 1].description) ?? 1) * (Int(list[i - 2].description) ?? 1) * (Int(list[i - 3].description) ?? 1)
            max = (max < left) ? left : max
        }
        
        // Right
        if i % 20 <= 16{
            let right = (Int(list[i].description) ?? 1) * (Int(list[i + 1].description) ?? 1) * (Int(list[i + 2].description) ?? 1) * (Int(list[i + 3].description) ?? 1)
            max = (max < right) ? right : max
        }
        
        // Diagonally
        // Sol üste doğru
        if i % 20 >= 3 && i >= 60{
            let leftUp = (Int(list[i].description) ?? 1) * (Int(list[i - 21].description) ?? 1) * (Int(list[i - 2*20 - 2].description) ?? 1) * (Int(list[i - 3*20 - 3].description) ?? 1)
            max = (max < leftUp) ? leftUp : max
        }
        
        // Sağ üste doğru
        if i % 20 <= 16 && i >= 60{
            let rightUp = (Int(list[i].description) ?? 1) * (Int(list[i - 19].description) ?? 1) * (Int(list[i - 2*20 + 2].description) ?? 1) * (Int(list[i - 3*20 + 3].description) ?? 1)
            max = (max < rightUp) ? rightUp : max
        }
        
        // Sol aşşağa doğru
        if i <= list.count - 61 && i % 20 >= 3{
            let leftDown = (Int(list[i].description) ?? 1) * (Int(list[i + 19].description) ?? 1) * (Int(list[i + 2*20 - 2].description) ?? 1) * (Int(list[i + 3*20 - 3].description) ?? 1)
            max = (max < leftDown) ? leftDown : max
        }
        
        // Sağ aşşağa doğru
        if i <= list.count - 61 && i % 20 <= 16{
            let rightDown = (Int(list[i].description) ?? 1) * (Int(list[i + 21].description) ?? 1) * (Int(list[i + 2*20 + 2].description) ?? 1) * (Int(list[i + 3*20 + 3].description) ?? 1)
            max = (max < rightDown) ? rightDown : max
        }
        
        i += 1
    }
    
    print("Max: \(max)")
}

// largestFour(text: "08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48")
// 70600674
