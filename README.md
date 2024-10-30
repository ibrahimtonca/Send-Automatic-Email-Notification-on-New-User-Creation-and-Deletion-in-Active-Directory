Merhabalar bu makalede, Active Directory ortamında kullanıcı hesapları oluşturulduğunda veya silindiğinde otomatik olarak e-posta bildirimi gönderen bir PowerShell komut dosyasının nasıl oluşturulacağını inceleyeceğiz. Paylaşılan bu PowerShell kodları, konsolda çalıştırıldığında her 5 saniyede bir AD üzerindeki kullanıcı değişikliklerini dinler. Yeni bir kullanıcı oluşturulduğunda veya mevcut bir kullanıcı silindiğinde, belirlenen alıcı adresine bu değişikliklerle ilgili bir rapor gönderir. Otomatik e-posta bildirimlerinin kesintisiz çalışabilmesi için PowerShell konsolunun açık bırakılması gerektiğini unutmayın. SMTP, alıcı ve gönderici bilgilerini kendinize göre özelleştirerek bu süreci sisteminize entegre edebilirsiniz.

PowerShell Script’inin Ekran Görüntüsü;
Kodları konsola yapıştırdığımızda bu şekilde izleme ekranı geliyor.

![3](https://github.com/user-attachments/assets/21a44988-e38d-49c6-9a4f-5a10598fa1d1)



Daha sonra AD üzerinden bir kullanıcı oluşturulduğunda yada sildiğinizde bu şekilde olayı algılıyor konsolda silindi yada oluşturuldu uyarısı verip alıcıda belirttiğimiz mail adresine raporu gönderiyor.
![4](https://github.com/user-attachments/assets/bef17930-4a83-483b-86ae-c473d716906d)


 

Yeni kullanıcı oluşturulduğunda ekran görüntüsü;
![1](https://github.com/user-attachments/assets/54efdf5d-62f0-47e0-ad2d-6c314ac72462)



Kullanıcı silindiğinde ekran görüntüsü;
![2](https://github.com/user-attachments/assets/4c3a7552-d315-4c87-a4fc-e388097ce25d)
