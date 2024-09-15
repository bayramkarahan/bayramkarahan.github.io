Tek Bölüm Kurulum
=================
Diskler üzerinde işlem yapabilmek için evdev veya udevd servisi çalışıyor olmalı.
Ayrıca aşağıdaki modüllerin yüklü olduğundan emin olun.
Anlatım boyunca **/dev/sda** diski üzerinden örnekleme yapılmıştır. Siz kendi diskinize göre düzenleyebilirsiniz.
Disk ve isoya erişim için aşağıdaki modüllerin yüklü olduğundan emin olun.

- loop
- squashfs
- ext4 modulleri **modprobe** komutuyla yüklenmeli.

Disk Hazırlanmalı(legacy)
^^^^^^^^^^^^^^^^^^^^^^^^^
Öncelikle **cfdisk** veya **fdisk** komutları ile diski bölümlendirelim. Ben bu anlatımda **cfdisk** kullanacağım.


0. cfdisk komutuyla disk bölümlendirilmeli.

.. code-block:: shell
		
	$ cfdisk /dev/sda
	
1. dos seçilmeli
2. type linux system
3. write
4. quit
5. Bu işlem sonucunda sadece sda1 olur
6. mkfs.ext2 ile disk biçimlendirilir.

.. code-block:: shell

	$ mkfs.ext2 /dev/sda1


Dosya sistemini kopyalama
^^^^^^^^^^^^^^^^^^^^^^^^^
Kurulum medyası **/cdrom** dizinine bağlanır.
Kurulacak sistemin imajını bir dizine bağlayalım.

.. code-block:: shell
		
	$ mkdir -p cdrom
	$ mkdir -p source
	$ mount -t iso9660 -o loop /dev/sr0 /cdrom/
	$ mount -t squashfs -o loop /cdrom/live/filesystem.squashfs /source

Şimdi de disk bölümümüzü bağlayalım.

.. code-block:: shell

	$ mkdir -p target
	$ mount /dev/sda1 /target
	$ mkdir -p /target/boot

Ardından dosyaları kopyalayalım.

.. code-block:: shell

	# -p dosya izinlerini korur
	# -r alt dizinlerle beraber kopyalar
	# -f soru sormayı kapatır
	# -v detaylı çıktıları gösterir
	$ cp -prfv /source/* /target

Daha sonra diski senkronize edelim.

.. code-block:: shell

	$ sync

Bootloader kurulumu
^^^^^^^^^^^^^^^^^^^
grub kurulumu yapmak için grub paketinini kurulu olduğundan emin olun.

.. code-block:: shell

	$ mkdir -p /target/dev
	$ mkdir -p /target/sys
	$ mkdir -p /target/proc 
	$ mkdir -p /target/run
	$ mkdir -p /target/tmp
	$ mount --bind /dev /target/dev
	$ mount --bind /sys /target/sys
	$ mount --bind /proc /target/proc
	$ mount --bind /run /target/run
	$ mount --bind /tmp /target/tmp
	
	# Bunun yerine aşağıdaki gibi de girilebilir.
	for dir in /dev /sys /proc /run /tmp ; do
		mount --bind /$dir /target/$dir
	done
	$ chroot /target


Grub Kuralım
^^^^^^^^^^^^
.. code-block:: shell

	$ grub-install --boot-directory=/boot  /dev/sda


Grub yapılandırması
^^^^^^^^^^^^^^^^^^^
1. /boot bölümünde initrd.img-<çekirdek-sürümü> dosyamızın olduğundan emin olalım.
2. /boot bölümünde vmlinuz-<çekirdek-sürümü>  kernel dosyamızın olduğundan emin olalım.
3. /boot/grub/grub.cfg konumunda dostamızı oluşturalım(vi, touch veya nano ile).
4. dev/sda1 diskimizim uuid değerimizi bulalım.


.. code-block:: shell

	$ blkid | grep /dev/sda1
	/dev/sda1: UUID="..." BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="..."

Şimdi aşağıdaki gibi bir yapılandırma dosyası yazalım ve /boot/grub/grub.cfg dosyasına kaydedelim.
Burada uuid değerini ve çekirdek sürümünü düzenleyin.

.. code-block:: shell

	linux /boot/vmlinuz-<çekirdek-sürümü>	root=UUID=<uuid-değeri> rw quiet
	initrd /boot/initrd.img-<çekirdek-sürümü>
	boot


Ayrıca otomatik yapılandırma da oluşturabiliriz.

.. code-block:: shell
	
	$ grub-mkconfig -o /boot/grub/grub.cfg

**Not:** Disk bölümü konumu yerine **UUID="<uuid-değeri>"** şeklinde yazmanızı öneririm.
Bölüm adları değişebilirken uuid değerleri değişmez.


.. raw:: pdf

   PageBreak
