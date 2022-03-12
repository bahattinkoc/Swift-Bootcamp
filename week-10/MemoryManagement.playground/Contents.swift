import UIKit

// Memory Leak??
// Struct ve Class

class Araba {
    var bmw: BMW?
    
    deinit{
        print("Deallocating ARABA")
    }
}

class BMW{
    weak var araba: Araba?
    
    deinit{
        print("Deallocationg BMW")
    }
}

var arac: Araba? = Araba()
var m4: BMW? = BMW()

arac?.bmw = m4
m4?.araba = arac

arac = nil
m4 = nil
