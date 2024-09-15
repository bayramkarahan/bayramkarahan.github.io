
Paket Kaldırma
++++++++++++++

Sistemde kurulu paketleri kaldırmak için işlem adımları şunlardır.

1. Paketin kullandığı bağımlılıkları başka paketler kullanıyor mu kontrol edilir. Eğer kullanılmıyorsa kaldırılır.
2. Paketin paket.LIST dosyası içerisindeki dosyalar, dizinler kaldırılır.
3. Kaldırılan dosyalardan sonra /paket/veri/yolu/paket.LIST dosyasından paket bilgisi kaldırılır.
4. sistemde kurulu paketler index dosyasından ilgili paket satırı kaldırılmalıdır.


Paketi kaldırmak için ise aşağıdaki örnek kullanılabilir.

.. code-block:: shell

	cat /paket/veri/yolu/paket.LIST | while read dosya ; do
	    if [[ -f "$dosya" ]] ; then
	        rm -f "$dosya"
	    fi
	done
	cat /paket/veri/yolu/paket.LIST | while read dizin ; do
	    if [[ -d "$dizin" ]] ; then
	        rmdir "$dizin" || true
	    fi
	done
	rm -f /paket/veri/yolu/paket.LIST

Bu örnekte paket listesini satır satır okuduk. Önce dosya olanları sildik.
Daha sonra tekrar okuyup boş kalan dizinleri sildik.
Son olarak palet listesi dosyamızı sildik.
Bu işlem sonunda paket silinmiş oldu.


.. raw:: pdf

   PageBreak
   

**bps Paket Kaldırma Scripti Tasarlama**
----------------------------------------

Dokumanda örnek olarak verilen bps paket sistemi için yukarıdaki paket kaldırma bilgilerini kullanarak tasarlanmıştır.

**bpskaldir** scripti
.....................

.. code-block:: shell
	
	#!/bin/sh
	#set -e
	paket=$1
	paketname="name=\"${paket}\""
	indexpaket=$(cat /var/lib/bps/index.lst|grep $paketname)
	name=""
	version=""
	depends=""
	if [ -n "${indexpaket}" ]; then
		namex=$(echo $indexpaket|cut -d":" -f1)
		versionx=$(echo $indexpaket|cut -d":" -f2)
		dependsx=$(echo $indexpaket|cut -d":" -f3)
		name=${namex:6:-1}
		version=${versionx:9:-1}
		depends=${dependsx:9:-1}
	else
		echo "***********Paket Bulunamadı**********"; exit
	fi
	# Bağımlılıkları başka paketler kullanıyor mu kontrol edilir
	echo "bağımlılık kontrolü yapılacak"
	 
	# Paketin file.lst dosyası içerisindeki dosyalar, dizinler kaldırılır.
	cat /var/lib/bps/${paket}-${version}.lst | while read dosya ; do if [[ -f "$dosya" ]] ; then rm -f "$dosya"; fi done
	cat /var/lib/bps/${paket}-${version}.lst  | while read dizin ; do if [[ -d "$dizin" ]] ; then rmdir "$dizin" || true; fi done

	#/var/lib/bps/paket-version.lst dosyasından paket bilgisi kaldırılır.
	rm -f /var/lib/bps/${paket}-${version}.lst
	#/var/lib/bps/index.lst dosyasından ilgili paket satırı kaldırılır.
	sed '/^name=\"${paket}\"/d' /var/lib/bps/index.lst
	
Bağımlılıkları başka paketler kullanıyor mu kontrol edilir. Script içinde bu işlem yapılmamıştır. Daha sonra güncellenecektir.
Bu örnekte paket listesini satır satır okuduk. Önce dosya olanları sildik.
Daha sonra tekrar okuyup boş kalan dizinleri sildik.
Son olarak paket listesi dosyamızı sildik.
Bu işlem sonunda paket silinmiş oldu.

**bpskaldir** Kullanma
......................

**bpskaldir** scripti aşağıdaki gibi kullanılır.

.. code-block:: shell
	
	./bpskaldir readline

.. raw:: pdf

   PageBreak

