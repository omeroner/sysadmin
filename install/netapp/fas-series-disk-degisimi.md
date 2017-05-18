-Console veya SSH üzerinden sisteme bağlanılır.

-CLI ekranında aşağıda ki komutlar çalıştırılıp gerekli kontroller yapılır.

### 7 Mode İçin CLI Komutları

Hangi node ait disk arızalanmış tespit et
```sh
 aggr status -f
```

Spare diski kontrol ederek sağlamasını yap

```sh
aggr status -s
```

Tüm diskleri gör,
```sh
sysconfig -r
```

Tüm Detayları gör
```sh
sysconfig -a
```

## Disk değişimini yap

Disk takıldıktan sonra diski gör
```sh
disk show -n
```

Sahipliği Olmayan diskleri gör
```sh
disk show -v  
```

Disk’i assign et
```sh
disk assign 0a.12.16
```

Assign edilmiş diski spare tablosunda gör
```sh
aggr status -s 
```

AutoSupport Maili gönder.
```sh
options autosupport.doit disk_replaced
```

## Auto Assing
AutoAssign Gör
```sh
options disk.auto_assign
```

AutoAssign Off yapıyoruz.
```sh
options disk.auto_assign OFF
```
Disk otomatik olarak controller’a assign edilip edilmediğini kontrol et. Eğer On ise OFF olarak ayarla 


## LED yanmıyorsa
Eğer disk Işığı yanmıyorsa , İlgili disk için LED ışığını kendimiz yakmamız gerekiyor

Advanced Moda geçiyoruz
```sh
priv set advanced
```

İlgili Disk Led’ini yakıyoruz.
```sh
led_on 0a.12.16
```

Admin Moda Geçiyoruz.
```sh
priv set admin
```

## Disk Sahipliğini Değiştir

Otomatik disk assign açık ve otomatik olarak disk ataması yapıldıysa , farklı disk pool içerisine diski atamak için

Advanced Moda geçiyoruz
```sh
priv set advanced
```

Diskin OwnerShip'liğini değiştiriyoruz
```sh
disk remove_ownership 0a.12.16
```

Sahipliği Olmayan diskleri gör
```sh
disk show -v
```

Diski Talep edilen sahipliğe aktar
```sh
disk assign 0a.12.16 -o netapp -s 4082368508
```

### CLUSTERED DATA ONTAP İçin CLI Komutları
Clustered Data Ontap OS üzerinde disk değişim işlemi 7 MODE üzerinden yaptığımız şekildedir. Sadece burada Cluster Shell üzerinde'ki komut farklılıkları bulunmaktadır.

Tüm diskleri gösterir.
```sh
storage disk show
```

Arızalı diskleri gösterir.
```sh
storage disk show -broken
```

Sistemde ki spare diskleri gösterir.
```sh
storage disk show -spare
```

Tüm diskleri gör
```sh
run -node ntappcls-pr-03 -command sysconfig -r
```                           

Tüm Detayları gör
```sh
run -node ntappcls-pr-03 -command Sysconfig -a
```

## Disk değişimini yap

Yeni takilan diski unassign olarak gösterir
```sh
run -node ntapcls-pr-03 -command disk show -n
```

Sahipliği Olmayan diskleri gör
```sh
run -node ntapcls-pr-03 -command disk show -v
```

Takılan diski assign etmek için kullanılır.
```sh
storage disk assign -disk 0a.12.16 owner CLS001
```

Disk değişimi sonunda autosupport maili gönderilir.
```sh
Autosupport invoke -node cluster001 -type test -message DISK_REP
```

## Auto Assing
AutoAssign açık olup olmadığını kontrol eder
```sh
storage disk option show
```
Autoassign özelliğini devre dışı bırakır
```sh
storage disk option modify -node cluster1-01 -autoassign on/off
```
## LED yanmıyorsa

Advance Moda Geç
```sh
set advanced
```

Yanmayan Led ‘i yakar , söndürür
```sh
storage disk set-led -disk 0a.12.16 -action on/off
```
