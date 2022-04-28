import UIKit

var greeting = "Hello, playground"

/*
 MAP: Elimizde elemanları şehirler olan bir dizi olsun. Dizideki tüm elemanların
 tüm harflerini büyüten bir fonksiyon yazınız
 */
let cities = ["izmir", "ankara", "leeds", "istanbul"]
var newCities = [String]()

//for city in cities {
//    newCities.append(city.uppercased())
//}

// Bunu MAP kullanarak yapsaydık nasıl olurdu?

//newCities = cities.map({ city in
//    city.uppercased()
//})

newCities = cities.map({$0.localizedUppercase})

// SORU: Bir dizi içinde farklı diziler varsa ve bunları tek dizide birleştirmeniz gerekiyorsa ne kullanılabilir?
let citiesArray = [
    ["izmir", nil],
    ["leeds", "eskişehir"],
    ["istanbul", "bursa"]
]

var newCitiesArray = [String]()

//for a in citiesArray {
//    for b in a {
//        newCitiesArray.append(b.uppercased())
//    }
//}
//
//for city in citiesArray {
//    newCitiesArray += city
//}

//newCitiesArray = citiesArray.flatMap({$0})

// Elinize veriler gelecek ancak bazı veriler nil. nil olanları almadan sadece tanımlı elemanları tutan bir dizi oluşturun


// REDUCE: Elimizde bulunan dizinin elemanlarını kullanarak tek bir değer döner

