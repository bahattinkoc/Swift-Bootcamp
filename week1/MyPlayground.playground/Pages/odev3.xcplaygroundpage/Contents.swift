// Diziyi terten sırala ve harfleri büyük yap

import Foundation

let names = ["Mert", "Eren", "Yusuf", "Ali", "Zeynep"]
var namesArray: Array<String> = Array()

for name in names{
    namesArray.append(name)
}

var i = 0
while i < namesArray.count{
    namesArray[i] = namesArray[i].uppercased()
    i += 1
}

namesArray = namesArray.sorted(by: { $1 < $0 }) // bu yardımcı kodu googlelayarak buldum

for name in namesArray{
    print(name)
}
