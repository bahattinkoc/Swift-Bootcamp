import Foundation

/*
 2- Elimizde yine uzun bir cümle olsun. Bazı kelimeler tekrar ettiği bir cümle düşünün. İstediğimiz ise hangi kelimeden kaç tane kullanıldığını bulmak.
 
 String: "Merhaba nasılsınız. İyiyim siz nasılsınız bende iyiyim"
 Merhaba 1
 nasılsınız 2
 iyiyim 2
 siz 1
 bende 1
 */

func parseWords(text: String) -> Array<String>{
    var words: Array<String> = Array()
    let chars = Array(text)
    var temp: Array<Character> = Array()
    
    for item in chars{
        if item != " " && item != "." && item != "," && item != "!" && item != "?"{ // eğer bunlardan biri ile karşılaşılmadı ise toplamaya devam et
            temp.append(item)
        } else { // özel karakter ise bitir ve diziye ekle
            if temp.count != 0{
                words.append(String(temp))
                temp = Array()
            }
        }
    }
    
    // diziyi göster
    for item in words{
        print(item)
    }
    
    return words
}

/*
 2 tane boş dizi olacak. Birisi kelimeleri diğeri ise sayılarını. Index numaraları sıralarını belirtecek
 Kelime dizisi sırası ile dönecek.
 Sıradaki kelime kelime dizisinde var ise o indisteki sayı dizisindeki sayıyı bir artıracak
 Kelime, kelime dizisinde yok ise eklenip sıra dizisine de eklenip 1 yazılacak
 */
func enumarateWords(words: Array<String>) {
    var tempWords: Array<String> = Array()
    var tempEnumarate: Array<Int> = Array()
    var i = 0

    // kelime dizisini bir dön
    while i < words.count{
        if tempWords.count == 0{ // ilk eleman ise ilk kelimeyi direkt ekle
            tempWords.append(words[i])
            tempEnumarate.append(1)
        } else { // dizi boş değil ise kelimeyi arat
            var isExist: Bool = false
            var j = 0
            while j < tempWords.count{
                if tempWords[j] == words[i]{
                    isExist = true
                    break
                }
                j += 1
            }
            if isExist{ // varsa bir artır
                tempEnumarate[j] += 1
            } else { // yoksa ekle
                tempWords.append(words[i])
                tempEnumarate.append(1)
            }
        }
        i += 1
    }
    
    // diziyi göster
    i = 0
    while i < tempWords.count{
        print("--> \(tempWords[i]) : \(tempEnumarate[i])")
        i += 1
    }
}

var words: Array<String> = parseWords(text: "merhaba ben bahattin. bahattin ben ve 23 yaşındayım. ben çok mutluyum bahattin olarak")
enumarateWords(words: words)
