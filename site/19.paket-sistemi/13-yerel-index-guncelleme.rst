
index Güncelleme
++++++++++++++++

İndex güncelleme uzak(internet) depodaki paketlerin index listesinin yerelde tutulan index dosyasıyla eşitlemek işlemidir.
Depoda olan paketlerin listesi yerelde tutulan index.lst dosyasındada olması gerekmetedir. Bu işlemi yapan bpsupdate dosya içeriği aşağıdadır.

**bpsupdate** 
-------------

.. code-block:: shell
	
	#!/bin/sh
	curl -Lo /etc/bps/index.lst https://github.com/basitdagitim/kly-binary-packages/releases/download/current/index.lst

**index.lst** dosyamızı github üzerinden indiren scriptimiz tek bir satırdan oluşmaktadır. Bu hali şimdilik ihtiyacımızı görecektir.
Bu komut https://github.com/basitdagitim/kly-binary-packages/releases/download/current/index.lst adresindeki dosyayı index.lst dosyasını /etc/bps/index.lst konumuna indirecektir.

Fakat birden fazla depo(github repository) olması durumunda birazdah karmaşık bir yapısı olacaktır. Bu durumda debian sisteminde /etc/apt/source.list gibi bir yapıkullanılarak her depo indexi çekilip tek bir index.lst dosyası oluşturulabilir. Bu sistem için ise /etc/bps/source.list dosyası kullanılmaktadır. Birden fazla index dosyasını birleştiren ve güncelleyen scriptimiz aşağıdadır.
 
.. code-block:: shell
	
	#!/bin/sh
	curl -Lo /tmp/index.lst https://github.com/basitdagitim/kly-binary-packages/releases/download/current/index.lst
	target=""
	if [ -n "${1}" ];then target="$1"; else target="/";fi
	mkdir -p $target/etc/bps
	rm -rf $target/etc/bps/index.lst
	rm -rf $target/tmp/temp.lst
	while IFS= read -r adres
	do
	rm -rf $target/tmp/temp.lst 1>$target/dev/null 2>$target/dev/null
	github_adres=$(echo $adres|cut -d"/" -f1)
	binary_package_adres=$(echo $adres|cut -d"/" -f2)
	#echo $github_adres
	#echo $binary_package_adres

	curl -Lo /tmp/temp.lst "https://github.com/${github_adres}/${binary_package_adres}/releases/download/current/index.lst"
	if [ ! -f "$target/tmp/temp.lst"  ]; then echo "Paket adresleri hatalı /etc/bps/sources.list dosya içeriğini kontrol ediniz!"; continue; fi

		while IFS= read -r liste
		do
			echo "${liste}|https://github.com/${adres}/raw/master/">>$target/etc/bps/index.lst
		done < $target/tmp/temp.lst
		
	done < $target/etc/bps/sources.list
    
**bpsupdate** Kullanma
----------------------

Script bir parametre almaktadır. Parametremiz --update veya -u olmalıdır. Bu scripti kullanarak /etc/bps/index.lst dosyasını github depomuzdaki paket listesiyle güncelleyecektir. 

.. code-block:: shell
	
	./bpsupdate -u	


.. raw:: pdf

   PageBreak


