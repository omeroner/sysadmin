### SVN KULLANIMI İÇİN GEREKLİ KOMUTLARDAN BAZILARI
svn kurulumu.
```sh
yum install subversion.x86_64 
```
svn son versiyon öğrenme.
```sh
svn log -r HEAD
```
Tarihte dosyanın değişip değişmediği.
```sh
svn log  -r {2012-05-16} dosya.adı 
```
Tarih arasındaki logu verir.
```sh
svn log -r {başlangıç tarihi}:{bitiş tarihi} 
```
Dosyaya ait tarih arasındaki logu verir.
```sh
svn log -r {başlangıç tarihi}:{bitiş tarihi} dosya.adı 
```
400 nolu sürümdden yeni bir kopya oluşturur.
```sh
svn checkout -r 400 
```
Mevcut dosyaları 400 nolu sürüm ile günceller.
```sh
svn update -r 400 
```
index.php nn 304. versiyonunun içeriğini görme.
```sh
svn cat -r 304 index.php
```
Deposundaki dosyalarin listesini verir. daha fazla ekstra bilgi istenirse -v veya verbose eklenebilir.
```sh
svn list -v svn://192.168.41.80/var/svn/apps_depo 
```
Tarih arasındaki logları ayrıntılı olarak verir.
```sh
svn log -vr {2012-05-21}:{2012-05-22} 
```
time arasındaki logları ayrıntılı olarak verir.
```sh
svn log -vr {'2012-05-25 13:38:00'}:{'2012-05-25 13:38:59'} 
```
SVN deposundaki dosya logunu gösterir.
```sh
svn log -v svn://localhost/var/svn/apps_depo 
```
Lokalde belirtilen dosyanın logunu gösterir.
```sh
svn log -v dosya.adı 
```
Dizindeki tüm dosyaların durumları hakkında bilgi alıyoruz (SVN kopyası).
```sh
svn status –v 
```
index.php nin 304 nolu versiyonuna dönüyoruz.
```sh
svn update -r 304 index.php  
```
dosya/dizinleri tasimak/ismini degistirmek için.
```sh
svn move  <dosyaadi> <değişendosyaadı>
```
Çakışmaları gidermek için.
```sh
svn revert * 
```

****

### GIT

Global seviyede kullanıcı bilgilerini belirlemek için
```sh
git config - -global user.name “isim,soyisim”
```
```sh
git config - -global user.email “email adresi”
```

Global seviyede tüm ayarları listelemek için
```sh
git config --global -l
```


