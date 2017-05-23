### Memcached Notlari


- Yükleme
```sh
	aptitude install memcached
	aptitude install python-memcache
```

- Python örnek kod
```sh
	#!/usr/bin/python

	import memcache

	servers = ['127.0.0.1:11211', '127.0.0.1:11212'] 
	memc = memcache.Client(servers, debug=1)

	key = memc.get('key1001')
	if not key:
		print("memcache'de yok")
		value = 'value1001'
		memc.set('key1001', value, 20)
	else:
		print("memcache'de var")
		value = memc.get('key1001')

	print(value)
```

- Python memcache komutlari
  Memcache'e kaydedilirken degerler otomatik olarak serilestirilir.
```
	Client(sunucu_listesi)
	get(key)			-> Deger yoksa None gelir.
	set(key, value, [expire])	-> expire süresi boyunca deger saklanir.
					   0 olursa expire olmaz.
					   expire süresi 30 günden (30*24*60*60) fazla ise
					   epoch degeri olarak kabul edilir.
	delete(key, [time])		-> time süresince deger saklanir ve sonra silinir.
					   Bu süre boyunca deger degistirilemez.
	incr(key, [value])		-> Degeri value degeri kadar arttirir.
	decr(key, [value])		-> Value verirmezse 1 artar.

```


- Memcached istatistikleri
```sh
	aptitude install telnet

	telnet 127.0.0.1 11211

		stats

		STAT pid 17110			-> pid
		STAT uptime 190			-> Oturum süresi
		STAT time 1321789537		-> Epoch time
		STAT version 1.4.5		-> Sürüm
		STAT pointer_size 32
		STAT rusage_user 0.008000	-> Oturum için toplam user süresi
		STAT rusage_system 0.056003	-> Oturum için toplam sistem süresi
		STAT curr_connections 5		-> Açik baglanti sayisi
		STAT total_connections 13	-> Oturum için yapilan toplam baglanti sayisi
		STAT connection_structures 7
		STAT cmd_get 12			-> Oturum için toplam get komutu sayisi
		STAT cmd_set 2			-> Oturum için toplam set komutu sayisi
		STAT cmd_flush 0		-> Oturum için toplam flush komutu sayisi
		STAT get_hits 10		-> Oturum için depodan cevaplanan get sayisi
		STAT get_misses 2		-> Oturum için cevaplanamayan get sayisi
		STAT delete_misses 0		-> Oturum için gerçeklestirilen delete sayisi
		STAT delete_hits 0		-> Oturum için key'i olmayan delete sayisi
		STAT incr_misses 0		-> Oturum için key'i olmayan incr sayisi
		STAT incr_hits 5		-> Oturum için gerçeklestirilen incr sayisi
		STAT decr_misses 0		-> Oturum için key'i olmayan decr sayisi
		STAT decr_hits 0		-> Oturum için gerçeklestirilen decr sayisi
		STAT cas_misses 0
		STAT cas_hits 0
		STAT cas_badval 0
		STAT auth_cmds 0
		STAT auth_errors 0
		STAT bytes_read 335		-> Memcached'in agdan okudugu veri miktari
		STAT bytes_written 4305		-> Memcached'in aga yazdigi veri miktari
		STAT limit_maxbytes 67108864	-> Memcached'in kaydedebilecegi maksimum veri miktari
		STAT accepting_conns 1
		STAT listen_disabled_num 0
		STAT threads 4
		STAT conn_yields 0
		STAT bytes 60			-> Kayitli degerleri saklamak için kullanilan alan boyutu
		STAT curr_items 1		-> Kayitli deger sayisi
		STAT total_items 2		-> Oturum için toplam kaydedilen deger sayisi
		STAT evictions 0		-> Oturum için hafizayi bosaltmak için kaç geçerli degerin silindigi
		STAT reclaimed 0
		END

		stats slabs

		STAT 1:chunk_size 80		-> Her chunk için ayrilan alan miktari
		STAT 1:chunks_per_page 13107	-> Her sayfadaki chunk sayisi
		STAT 1:total_pages 1		-> Toplam sayfa sayisi
		STAT 1:total_chunks 13107	-> Toplam chunk sayisi
		STAT 1:used_chunks 1		-> Kullanilan chunk sayisi
		STAT 1:free_chunks 0		-> Bos chunk sayisi
		STAT 1:free_chunks_end 13106	-> Son sayfanin sonundaki toplan bos chunk miktari
		STAT 1:mem_requested 60		-> Ä°htiyaç duyulan gerçek RAM alani
		STAT 1:get_hits 10		-> Toplam get sayisi
		STAT 1:cmd_set 2		-> Toplam set sayisi
		STAT 1:delete_hits 0		-> Toplam delete sayisi
		STAT 1:incr_hits 5		-> Toplam incr sayisi
		STAT 1:decr_hits 0		-> Toplam decr sayisi
		STAT 1:cas_hits 0
		STAT 1:cas_badval 0
		STAT active_slabs 1		-> Aktif slabs sayisi
		STAT total_malloced 1048560	-> Slab sayfalari için ayrilan toplam hafiza alani
		END

		stats items

		STAT items:1:number 1		-> Kayitli olan deger sayisi
		STAT items:1:age 1958		-> En eski degerin saniye olarak yasi
		STAT items:1:evicted 0		-> Alan yaratmak için silinen deger sayisi
		STAT items:1:evicted_nonzero 0	-> Son geçerli deger silme zamani (nonzero)
		STAT items:1:evicted_time 0	-> Son geçerli deger silme zamani
		STAT items:1:outofmemory 0	-> Hafiza yetersiz sonucu alan deger sayisi
		STAT items:1:tailrepairs 0
		STAT items:1:reclaimed 0
		END

		stats sizes

		STAT 64 1			-> (Boyut, adet) çifti
		END

		quit
```
