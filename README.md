Merhabalar bu makalede, Active Directory ortamında kullanıcı hesapları oluşturulduğunda veya silindiğinde otomatik olarak e-posta bildirimi gönderen bir PowerShell komut dosyasının nasıl oluşturulacağını inceleyeceğiz. Paylaşılan bu PowerShell kodları, konsolda çalıştırıldığında her 5 saniyede bir AD üzerindeki kullanıcı değişikliklerini dinler. Yeni bir kullanıcı oluşturulduğunda veya mevcut bir kullanıcı silindiğinde, belirlenen alıcı adresine bu değişikliklerle ilgili bir rapor gönderir. Otomatik e-posta bildirimlerinin kesintisiz çalışabilmesi için PowerShell konsolunun açık bırakılması gerektiğini unutmayın. SMTP, alıcı ve gönderici bilgilerini kendinize göre özelleştirerek bu süreci sisteminize entegre edebilirsiniz.

PowerShell Script’inin Ekran Görüntüsü;

Kodları konsola yapıştırdığımızda bu şekilde izleme ekranı geliyor.



Daha sonra AD üzerinden bir kullanıcı oluşturulduğunda yada sildiğinizde bu şekilde olayı algılıyor konsolda silindi yada oluşturuldu uyarısı verip alıcıda belirttiğimiz mail adresine raporu gönderiyor.



 

Yeni kullanıcı oluşturulduğunda ekran görüntüsü;



Kullanıcı silindiğinde ekran görüntüsü;

