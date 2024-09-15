Paket Kurma
+++++++++++

Hazırlanan dağıtımda paketlerin kurulması için  sırasıyla aşağıdaki işlem adımları yapılmalıdır.

1. Paketin indirilmesi
2. İndirilen paketin /tmp/bps/kur/ konumunda açılması
3. Açılan paket dosyalarının / konumuna yüklenmesi(kopyalanması)

	- Paketin bağımlı olduğu paketler varmı kontrol edilir
	- Yüklü olmayan bağımlılıklar yüklenir
	
4. Yüklenen paket bilgileri(name, version ve bağımlılık) yüklü paketlerin index bilgilerini tutan paket sistemi dizininindeki index dosyasına eklenir.	
5. Açılan paket içindeki yüklenen dosyaların nereye yüklendiğini tutan file.index dosyası paket sistemi dizinine yüklenir


Bu işlemler daha detaylandırılabilir. Bu işlemlerin detaylı olması paket sisteminin kullanılabilirliğini ve yetenekleri olarak ifade edebiliriz. İşlem adımlarını kolaylıkla sıralarken bunları yapacak script yazmak ciddi planlamalar yapılarak tasarlanması gerekmektedir.


Örneğin bir paketimiz zip dosyası olsun ve içinde dosya listesini tutan **file.index** adında bir dosyamız olsun. Paketi aşağıdaki gibi kurabiliriz.

.. code-block:: shell

	cd /tmp/kur/
	unzip /dosya/yolu/paket.zip
	cp -rfp ./* /
	cp file.index /paket/veri/yolu/paket.index

- Bu örnekte ilk satırda geçici dizine gittik 
- Paketi oraya açtık.
- Paket içeriğini kök dizine kopyaladık.
- Paket dosya listesini verilerin tutulduğu yere kopyaladık.

Bu işlemden sonra paket kurulmuş oldu.


.. raw:: pdf

   PageBreak

**bps Paket Kurma Scripti Tasarlama**
-------------------------------------
Burada basit seviyede kurulum yapan script kullanılmıştır. Detaylandırıldıkça doküman güncellenecektir. Kurulum scripti aşağıda görülmektedir.

Paket kurulurken paket içerisinde bulunan dosyalar sisteme kopyalanır.
Daha sonra istenirse silinebilmesi için paket içeriğinde dosyaların listesi tutulur.
Bu dosya ayrıca paketin bütünlüğünü kontrol etmek için de kullanılır.


**bpskur** Scripti
..................

.. code-block:: shell
	
	#!/bin/sh
	#set -e
	paket=$1
	paketname="name=\"${paket}\""
	ROOTFS=$2
	#echo "$paket"
	indexpaket=$(cat /etc/bps/index.lst|grep $paketname)
	name=""
	version=""
	depends=""
	if [ -n "${indexpaket}" ]
		then
			namex=$(echo $indexpaket|cut -d"|" -f1)
			versionx=$(echo $indexpaket|cut -d"|" -f2)
			dependsx=$(echo $indexpaket|cut -d"\|" -f3)
			name=${namex:6:-1}
			version=${versionx:9:-1}
			depends=${dependsx:9:-1}
		else
		echo "***********Paket Bulunamadı**********"; exit
	fi

	# 1. adım paketi indirme
	mkdir -p /tmp/bps
	mkdir -p /tmp/bps/kur
	rm -rf /tmp/bps/kur/*
	curl -Lo /tmp/bps/kur/${name}-${version}.tar.gz https://github.com/basitdagitim/kly-binary-packages/raw/master/${name}/${name}-${version}.bps
	
	mkdir -p /var/lib/bps
	cd /tmp/bps/kur/

	#2. adım paketi açma
	tar -xf ${name}-${version}.tar.gz
	mkdir -p rootfs
	tar -xf rootfs.tar.xz -C rootfs

	#3. adım  paketi kurma
	cp -prfv rootfs/* $ROOTFS/

	#4. adım name version depends /var/lib/bps/index.lst eklenmesi
	echo "name=\"${name}\":"version=\"${version}\":"depends=\"${depends}\"">>var/bps/index.lst
	# 5. adım paket içinde gelen paket dosyalarının dosya ve dizin yapısını tutan file index dosyanının /var/lib/bps/ konumuna kopyalanması
	cp file.index /var/lib/bps/${name}-${version}.lst



**bpskur** Scriptini Kullanma
.............................

Script iki parametre almaktadır. İlk parametre paket adı. İkinci parametremiz ise nereye kuracağını belirten hedef olmalıdır. Bu scripti kullanarak readline paketi aşağıdaki gibi kurulabilir. 

.. code-block:: shell
	
	./bpskur readline /	

.. raw:: pdf

   PageBreak

