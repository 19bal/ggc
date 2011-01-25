1. indir: [ty db](https://github.com/downloads/19bal/ggc/ty.zip) yi indir ve şu
   formatta dizin ağacını oluştur:

	ggc/a/1-alpha/runme.m
	             |
                 /...
	ggc/db/ty/hepsi/e01/lqf-00_1-007.png
	         |     |   |
	         |     |   /...
			 |	   /...
			 /...

2. çalıştır: `runme.m`

## Diğer

bu çalışmada kullanılan databaseler

- Orjinal [Veritabanı](http://github.com/downloads/19bal/gaitEmre/db.tar.gz)

- [Tek Yönlü Veritabanı](https://github.com/downloads/19bal/ggc/tyDB.rar)

Bu dosyaları indirip, aşağıdaki biçimde dizin hiyerarşisini oluşturun,

		a/
		  |
		  |---src/
		  | ...
		  |---db/
		         |
				 |---orjinal/hepsi/e01/lqf-00_1-007.png
				 | ...
				 |---ty/hepsi/e01/lqf-00_1-007.png
		   		 | ...

- Tek yönlü Veritabanı oluşturulurken aynı dizindeki tüm resimleri simetrikleştirmek için `1-alpha/` dizinindeki `db_simetriklestir.m` veya @emre hocanın hazırladığı [kodlar](https://sites.google.com/a/bil.omu.edu.tr/egurbuz/dosya/ters.m?attredirects=0&d=1) kullanılabilir.

- sites.bil.omu.edu.tr üzerindeki [egurbuz](https://sites.google.com/a/bil.omu.edu.tr/egurbuz/) sitesinde tutulan bu dokümanlara erişim izni için @nurettin hocama ve @erdem e yetki verildi. Sitedeki [Dosya](https://sites.google.com/a/bil.omu.edu.tr/egurbuz/dosya) bölümüne yeni dosyalar eklemek de mümkün olmaktadır.
