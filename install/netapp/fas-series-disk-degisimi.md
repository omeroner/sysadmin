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


