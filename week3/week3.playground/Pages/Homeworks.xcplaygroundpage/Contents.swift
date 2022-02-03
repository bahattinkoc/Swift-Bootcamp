//: [Previous](@previous)

import Foundation

// HW: Girilen sayının asal olup olmadığını bulan bir extension yazınız

extension Int {
    func isPrime() -> Bool{
        var prime = true
        var number = sqrt(Double(self))
        while number >= 2 && prime{
            if self % Int(number) == 0{
                prime = false
            }
            number -= 1
        }
        return prime
    }
}

//14.isPrime()
//13.isPrime()
//2.isPrime()
//1.isPrime()















// HW: İki parametreli ve FARKLI tipli bir generic örneği yapınız (T, U)
// Başlangıç ve adet miktarı girildiğinde belirtilen başlangıç sayısından itibaren belirtilen kadar asal sayi yazdırıyor

protocol Numerics {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func %(lhs: Self, rhs: Self) -> Self
}

// haber verdik
extension Int: Numerics {}

func findXPrime<A: Numeric & Numerics, T: Comparable & Numeric>(start: A, count: T){
    var i = start
    var _count = count
    // var result: Array<T> = Array()
    while _count != 0{
        var j = i / 2
        var prime = true
        while j != 2 && prime{
            if i % j == 0{
                prime = false
            } else {
                j -= 1
            }
        }
        if prime{
            // result.append(i)
            print("This number is prime: \(i)")
            _count -= 1
        }
        i += 1
    }
}

// findXPrime(start: 99, count: 25)




















// Project Euler 7 - 10001st prime
/*
 By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

 What is the 10 001st prime number?
 */

func find10001sPrime() -> Int{
    var i = 2
    var counter = 0
    while counter != 10001{
        if isPrime(x: i){
            counter += 1
            print("\(counter). prime number is: \(i)")
        }
        i += 1
    }
    return i
}

func isPrime(x: Int) -> Bool{
    var prime = true
    var _x = sqrt(Double(x))
    while _x >= 2 && prime{
        if x % Int(_x) == 0{
            prime = false
        }
        _x -= 1
    }
    
    return prime
}

var i = find10001sPrime()
// print("The answer is: \(i)")


































// HW: Şişe vurma oyununu kodlayınız (Detaylar PDF dosyasında verilecektir)

///Location = 0.0
///Angle (0-90)
///Speed (0-100)
struct Mortar {
    var location: Double = 0.0
    var angle: Double = 0.0 // teta 0-90
    var speed: Double = 0.0 // V 0-100 m/s
    
    func range() -> Double{
        return self.speed * self.speed * sin(2 * self.angle) / 10
    }
    
//    init(angle: Double, speed: Double){
//        if angle < 0{
//            self.angle = 0
//        } else if angle > 90{
//            self.angle = 90
//        } else{
//            self.angle = angle
//        }
//
//        if speed < 0{
//            self.speed = 0
//        } else if speed > 100{
//            self.speed = 100
//        } else {
//            self.speed = speed
//        }
//    }
}

struct Bottle {
    var location: Double = 0.0 // d. Sıfıra olan uzaklığı. 0-1500
    var delta: Double = 0.1 // Şişenin kapladığı alan. Genişliği. 0.1-1
    var isFall: Bool = false
    
//    init(location: Double, delta: Double){
//        if location < 0{
//            self.location = 0
//        } else if location > 1500{
//            self.location = 1500
//        } else {
//            self.location = location
//        }
//
//        if delta < 0.1{
//            self.delta = 0.1
//        } else if delta > 1{
//            self.delta = 1
//        } else {
//            self.delta = delta
//        }
//    }
}

struct Player {
    var nickname: String = ""
    var score: Int = 0
    
//    init(nickname: String, score: Int){
//        self.nickname = nickname
//        self.score = score
//    }
}

struct Game {
    var player: Player
    var mortar: Mortar
    var bottle: Bottle
    
    mutating func setPlayer(nickname: String){
        player.nickname = nickname
    }
    
    mutating func setBottle(location: Double, delta: Double){
        if location < 0{
            bottle.location = 0
        } else if location > 1500{
            bottle.location = 1500
        } else {
            bottle.location = location
        }
        
        if delta < 0.1{
            bottle.delta = 0.1
        } else if delta > 1{
            bottle.delta = 1
        } else {
            bottle.delta = delta
        }
    }
    
    mutating func setMortar(angle: Double, speed: Double){
        if angle < 0{
            mortar.angle = 0
        } else if angle > 90{
            mortar.angle = 90
        } else{
            mortar.angle = angle
        }
        
        if speed < 0{
            mortar.speed = 0
        } else if speed > 100{
            mortar.speed = 100
        } else {
            mortar.speed = speed
        }
    }
    
    mutating func shot(){
        if bottle.isFall{
            print("The bottle is already overturned")
        } else {
            let R = mortar.range()
            // print("\(bottle.location - bottle.delta) <= \(R) <= \(bottle.location + bottle.delta)")
            if R >= (bottle.location - bottle.delta) && R <= (bottle.location + bottle.delta){
                bottle.isFall = true
                player.score += 1
                // print("Bottle overturned")
            } else {
                bottle.isFall = false
                // print("Bottle didn't overturn")
            }
        }
    }
}

var leaderboard: [Game] = []

func createNewGame(nickname: String, bottleLocation: Double, bottleDelta: Double, mortarAngle: Double, mortarSpeed: Double){
    
    var game = Game(player: Player(), mortar: Mortar(), bottle: Bottle())
    game.setPlayer(nickname: nickname)
    game.setBottle(location: bottleLocation, delta: bottleDelta)
    game.setMortar(angle: mortarAngle, speed: mortarSpeed)
    game.shot()
    
    var isExist = false
    for (index,item) in leaderboard.enumerated(){
        if item.player.nickname == nickname{
            leaderboard[index].player.score += game.player.score
            isExist = true
        }
    }
    
    if !isExist{
        leaderboard.append(game)
    }
}

createNewGame(nickname: "Sündük Sabri", bottleLocation: 40.0, bottleDelta: 0.6, mortarAngle: 45.4, mortarSpeed: 33.3)
createNewGame(nickname: "Rümeysa", bottleLocation: 15.3, bottleDelta: 0.3, mortarAngle: 60.0, mortarSpeed: 90.0)
createNewGame(nickname: "Mithat", bottleLocation: 40.0, bottleDelta: 0.6, mortarAngle: 45.4, mortarSpeed: 33.3)
createNewGame(nickname: "Eşkiya Faruk", bottleLocation: 33.0, bottleDelta: 0.6, mortarAngle: 45.4, mortarSpeed: 33.3)
createNewGame(nickname: "Eşkiya Faruk", bottleLocation: 33.0, bottleDelta: 0.6, mortarAngle: 45.4, mortarSpeed: 33.3)

print("Leaderboard\n")
for item in leaderboard{
    print("Name: \(item.player.nickname)\nScore: \(item.player.score)\n")
}
