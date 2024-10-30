#############################################################################
# Author: İbrahim Tonca
# Date: 30/10/2024
# Description: AD Kullanıcı Ekle/Sil Mail Bildirimi
#############################################################################
#Asagidaki bilgileri kendinize göre dolduruyorsunuz.
# SMTP ayarları
$smtpServer = "smtp_ip"
$fromEmail = "gonderici_mail"
$toEmail = "alici_mail"
# Log dosyasının yolu ve dizin oluşturma
$logDir = "C:\Logs"
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir
}
$logPath = "$logDir\logfile.log"
if (-not (Test-Path $logPath)) {
    New-Item -ItemType File -Path $logPath
}
# İşlenen olayların kaydı için bir liste
$processedEvents = @{}
# Kullanıcı değişikliklerini izleme fonksiyonu
function Watch-ADUserChanges {
    Write-Host "Active Directory kullanıcı değişiklikleri izleniyor. Çıkmak için Ctrl+C tuşlayın."
    # Olayları izlemek için döngü başlat
    while ($true) {
        # Kullanıcı oluşturma (ID: 4720) ve silme (ID: 4726) olaylarını al
        $events = Get-WinEvent -LogName "Security" -MaxEvents 10 | Where-Object {
            $_.Id -eq 4720 -or $_.Id -eq 4726
        }
        # Olayları kontrol et
        if ($events.Count -eq 0) {
            Start-Sleep -Seconds 5  # Olay yoksa bekle
            continue  # Döngünün başına dön
        }
        foreach ($event in $events) {
            $eventId = $event.Id
            $userName = $event.Properties[0].Value  # Kullanıcı adı
            $eventKey = "$($event.TimeCreated)_$userName"  # Her olay için benzersiz anahtar oluştur
            # Olay daha önce işlendi mi kontrol et
            if ($processedEvents.ContainsKey($eventKey)) {
                continue  # İşlenmişse atla
            }
            # İşlenmiş olayları kaydet
            $processedEvents[$eventKey] = $true
            # Konsolda göster ve log kaydına yaz
            $message = "$(Get-Date): Olay ID: $eventId, Kullanıcı: $userName"
            Add-Content -Path $logPath -Value $message
            Write-Host $message
            # Oturum açan kullanıcıyı tespit et
            $logonEvent = (Get-WinEvent -LogName "Security" | Where-Object {
                $_.Id -eq 4624 -and $_.Properties[5].Value -like "*$env:COMPUTERNAME*"
            } | Select-Object -First 1)
            $loggedOnUser = if ($logonEvent) { "$($logonEvent.Properties[5].Value)\$($logonEvent.Properties[6].Value)" } else { "Bilinmeyen Kullanıcı" }
            # Yeni kullanıcı oluşturulduysa
            if ($eventId -eq 4720) {
                $newUser = Get-ADUser -Identity $userName -Properties DistinguishedName, GivenName, Surname, SamAccountName, UserPrincipalName, WhenCreated
                
                # OU bilgisini almak ve sadece DC'yi silmek
                $ouName = ($newUser.DistinguishedName -split ",") | Where-Object { $_ -notlike "DC=*" }
                $ouName = $ouName -join ", "  # Join işlemini burada yapıyoruz
                $messageBody = @"
<html>
<body>
    <h1 style="font-size: 15px; font-weight: bold;">AD - Yeni Kullanıcı Oluşturuldu!</h1>
    <p><strong>Kullanıcı Adı:</strong> $($newUser.SamAccountName)</p>
    <p><strong>Tam Ad:</strong> $($newUser.GivenName) $($newUser.Surname)</p>
    <p><strong>UPN:</strong> $($newUser.UserPrincipalName)</p>
<p><strong>OU:</strong> $ouName</p>
    <p><strong>Oluşturulma Tarihi:</strong> $($newUser.WhenCreated)</p>
</body>
</html>
"@
                # E-posta gönderim denemesi
                try {
                    Send-MailMessage -SmtpServer $smtpServer -From $fromEmail -To $toEmail -Subject "AD - Yeni Kullanıcı Uyarısı" -Body $messageBody -BodyAsHtml -Encoding UTF8
                    Add-Content -Path $logPath -Value "$(Get-Date): E-posta gönderildi: Yeni Kullanıcı Oluşturuldu: $userName"
                    Write-Host "E-posta gönderildi: Yeni Kullanıcı Oluşturuldu: $userName"
                } catch {
                    Add-Content -Path $logPath -Value "$(Get-Date): E-posta gönderim hatası - $($_.Exception.Message)"
                }
            }
            # Kullanıcı silindiyse
            elseif ($eventId -eq 4726) {
                $deletionTime = $event.TimeCreated
                $messageBody = @"
<html>
<body>
    <h1 style="font-size: 15px; font-weight: bold;">AD - Kullanıcı Silindi!</h1>
    <p><strong>Kullanıcı Adı:</strong> $userName</p>
    <p><strong>Silinme Tarihi:</strong> $deletionTime</p>
</body>
</html>
"@
                # E-posta gönderim denemesi
                try {
                    Send-MailMessage -SmtpServer $smtpServer -From $fromEmail -To $toEmail -Subject "AD - Kullanıcı Silinme Uyarısı" -Body $messageBody -BodyAsHtml -Encoding UTF8
                    Add-Content -Path $logPath -Value "$(Get-Date): E-posta gönderildi: Kullanıcı Silindi: $userName"
                    Write-Host "E-posta gönderildi: Kullanıcı Silindi: $userName"
                } catch {
                    Add-Content -Path $logPath -Value "$(Get-Date): E-posta gönderim hatası - $($_.Exception.Message)"
                }
            }
        }
        Start-Sleep -Seconds 5  # Her 5 saniyede bir kontrol et
    }
}
# Fonksiyonu çağır
Watch-ADUserChanges
