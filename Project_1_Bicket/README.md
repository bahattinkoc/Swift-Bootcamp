Bicket - Old             | New
:-------------------------:|:-------------------------:
![](https://github.com/bahattinkoc/Homeworks/blob/main/Project_1_Bicket/bicketOld.gif)  |  ![](https://github.com/bahattinkoc/Homeworks/blob/main/Project_1_Bicket/bicket.gif)

# super.init() nedir? neden kullanırız?
init metotları yapıların veya sınıfların başlangıç fonksiyonlarıdır. İlk değer atamaları vs bu fonksiyon içinde yapılır.
Yapı veya sınıflar tanımlandıklarında ilk bu fonksiyon çalışır. Fakat başka bir sınıftan kalıtım alan çocuk sınıflarımız
kendi init fonksiyonlarını çağırdıkları zaman kalıtım aldıkları ana sınıfın init fonksiyonu geçersiz kılınıyormuş. Bizlerde
ana sınıfın değişken değerleri bozulmasın diye super.init() fonksiyonunu çağırıyoruz.
super, kalıtım alınılan sınıfta değişkenlere ve fonksiyonlara erişmeye yarıyor. (Javada da vardı)
