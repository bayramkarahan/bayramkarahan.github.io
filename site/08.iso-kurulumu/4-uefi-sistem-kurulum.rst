Uefi Sistem Kurulumu
++++++++++++++++++++

Bu bölümde **Ext4** dosya sistemine grub kullanarak kurulum anlatılacaktır.
Anlatım boyunca **/dev/sda** diski üzerinden örnekleme yapılmıştır. Siz kendi diskinize göre düzenleyebilirsiniz.
Diskler üzerinde işlem yapabilmek için evdev veya udevd servisi çalışıyor olmalı.
Disk ve isoya erişim için aşağıdaki modüllerin yüklü olduğundan emin olun.


- loop
- squashfs
- ext4 modulleri **modprobe** komutuyla yüklenmeli.

Uefi - Legacy tespiti
^^^^^^^^^^^^^^^^^^^^^
**/sys/firmware/efi** dizini varsa uefi, yoksa legacy sisteme sahipsinizdir.
Eğer uefi ise ia32 veya x86_64 olup olmadığını anlamak için **/sys/firmware/efi/fw_platform_size** içeriğine bakın.

.. code-block:: shell

	[[ -d /sys/firmware/efi/ ]] && echo UEFI || echo Legacy
	[[ "64" == $(cat/sys/firmware/efi/fw_platform_size) ]] && echo x86_64 || ia32

Disk Hazırlanmalı
^^^^^^^^^^^^^^^^^
Uefi kullananlar ayrı bir disk bölümüne ihtiyaç duyarlar.
Bu bölümü **fat32** olarak bölümlendirmeliler.

Bu anlatımda kurulum için **/boot** dizinini ayırmayı ve efi bölümü olarak aynı diski kullanmayı tercih edeceğiz.
Öncelikle **cfdisk** veya **fdisk** komutları ile diski bölümlendirelim. Ben bu anlatımda **cfdisk** kullanacağım.

0. cfdisk komutuyla disk bölümlendirilmeli.

.. code-block:: shell
		
	$ cfdisk /dev/sda

1. gpt seçilmeli
2. 512 MB type uefi alan(sda1)
3. geri kalanı type linux system(sda2)
4. write
5. quit
6. Bu işlem sonucunda sadece sda1 sda2 olur
7. mkfs.vfat ve mkfs.ext4 ile diskler biçimlendirilir.

.. code-block:: shell

	$ mkfs.vfat /dev/sda1
	$ mkfs.ext4 /dev/sda2
		
e2fsprogs Paketi
^^^^^^^^^^^^^^^^
e2fsprogs paket sistemde mkfs.ext4, e2fsck, tune2fs vb sistem araçlarının yüklenmesini sağlar. Eğer sistemde bu sistem uygulamaları yoksa bu paketin yüklenmesi veya derlenmesi gerekmektedir.

Eğer /boot bölümünü ayırmayacaksanız grub yüklenirken **unknown filesystem** hatası almanız durumunda aşağıdaki yöntemi kullanabilirsiniz.

.. code-block:: shell

	$ e2fsck -f /dev/sda2
	$ tune2fs -O ^metadata_csum /dev/sda2

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

	$ mkdir -p target || true
	$ mkdir -p /target/boot || true
	$ mkdir -p /target/boot/efi || true
	$ mount /dev/sda2 /target || true
	$ mount /dev/sda1 /target/boot/efi

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
	#efi alan bağlanıyor. Eğer uefi aktif edilmişse kernel **/sys/firmware/efi** tarafından budizinler ve dosyalar oluşuyor. 
	#sistem uefi değise **/sys/firmware/efi** konumunda dosyalar olmayacaktır.
	$ if [[ -d /sys/firmware/efi ]] ; then
    		mount --bind /sys/firmware/efi/efivars /target/sys/firmware/efi/efivars
	  fi
		
	# Bunun yerine aşağıdaki gibi de girilebilir.
	for dir in /dev /sys /proc /run /tmp ; do
		mount --bind /$dir /target/$dir
	done
	$ chroot /target

Şimdi de uefi kullandığımız için efivar bağlayalım.
.. code-block:: shell

	$ mount -t efivarfs efivarfs /sys/firmware/efi/efivarfs
	
Grub Kuralım
^^^^^^^^^^^^
.. code-block:: shell

	# biz /boot ayırdığımız ve efi bölümü olarak kullanacağız.
	# uefi kullanmayanlar --efi-directory belirtmemeliler.
	# kurulu sistemden bağımsız çalışması için --removable kullanılır.
	$ grub-install --removable --boot-directory=/boot --efi-directory=/boot --target=x86_64-efi /dev/sda

Grub yapılandırması
^^^^^^^^^^^^^^^^^^^
1. /boot bölümünde initrd.img-<çekirdek-sürümü> dosyamızın olduğundan emin olalım.
2. /boot bölümünde vmlinuz-<çekirdek-sürümü>  kernel dosyamızın olduğundan emin olalım.
3. /boot/grub/grub.cfg konumunda dostamızı oluşturalım(vi, touch veya nano ile).
4. dev/sda2 diskimizim uuid değerimizi bulalım.

.. code-block:: shell

	$ blkid | grep /dev/sda2
	/dev/sda2: UUID="..." BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="..."

Şimdi aşağıdaki gibi bir yapılandırma dosyası yazalım ve /boot/grub/grub.cfg dosyasına kaydedelim.
Burada uuid değerini ve çekirdek sürümünü düzenleyin.

.. code-block:: shell

	linux /vmlinuz-<çekirdek-sürümü>	root=UUID=<uuid-değeri> rw quiet
	initrd /initrd.img-<çekirdek-sürümü>
	boot


Ayrıca otomatik yapılandırma da oluşturabiliriz.

.. code-block:: shell

	$ grub-mkconfig -o /boot/grub/grub.cfg

**Not:** Disk bölümü konumu yerine **UUID="<uuid-değeri>"** şeklinde yazmanızı öneririm.
Bölüm adları değişebilirken uuid değerleri değişmez.


.. raw:: pdf

   PageBreak

