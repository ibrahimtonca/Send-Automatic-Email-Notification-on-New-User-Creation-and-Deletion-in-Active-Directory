Merhabalar bu makalede, Active Directory ortamında kullanıcı hesapları oluşturulduğunda veya silindiğinde otomatik olarak e-posta bildirimi gönderen bir PowerShell komut dosyasının nasıl oluşturulacağını inceleyeceğiz. Paylaşılan bu PowerShell kodları, konsolda çalıştırıldığında her 5 saniyede bir AD üzerindeki kullanıcı değişikliklerini dinler. Yeni bir kullanıcı oluşturulduğunda veya mevcut bir kullanıcı silindiğinde, belirlenen alıcı adresine bu değişikliklerle ilgili bir rapor gönderir. Otomatik e-posta bildirimlerinin kesintisiz çalışabilmesi için PowerShell konsolunun açık bırakılması gerektiğini unutmayın. SMTP, alıcı ve gönderici bilgilerini kendinize göre özelleştirerek bu süreci sisteminize entegre edebilirsiniz.

PowerShell Script’inin Ekran Görüntüsü;
![3](https://github.com/user-attachments/assets/21a44988-e38d-49c6-9a4f-5a10598fa1d1)

Kodları konsola yapıştırdığımızda bu şekilde izleme ekranı geliyor.



Daha sonra AD üzerinden bir kullanıcı oluşturulduğunda yada sildiğinizde bu şekilde olayı algılıyor konsolda silindi yada oluşturuldu uyarısı verip alıcıda belirttiğimiz mail adresine raporu gönderiyor.



 

Yeni kullanıcı oluşturulduğunda ekran görüntüsü;



Kullanıcı silindiğinde ekran görüntüsü;

