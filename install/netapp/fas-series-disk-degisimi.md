-Console veya SSH üzerinden sisteme bağlanılır.
-CLI ekranında aşağıda ki komutlar çalıştırılıp gerekli kontroller yapılır.

## 7 Mode İçin CLI Komutları

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
