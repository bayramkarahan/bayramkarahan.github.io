Qemu Kullanımı
==============

.. image:: /_static/images/0-qemu.png
  	:width: 100

Qemu Nedir?
+++++++++++

Açık kaynaklı sanallaştırma aracıdır. 

Kaynaktan dosyalarından kurulum için;

.. code-block:: shell

	git clone https://gitlab.com/qemu-project/qemu.git
	cd qemu
	./configure
	make
	sudo make install
	
	
Sisteme Kurulum
+++++++++++++++

.. code-block:: shell

	sudo apt update
	sudo apt install qemu-system-x86  qemu-utils

* 30GB bir disk oluşturup etahta.iso dosyamızı 2GB ramdan oluşan bir makina çalıştıralım.
	
.. code-block:: shell

	qemu-img create disk.img 30G #30GB disk oluşturuldu.
	qemu-system-x86_64 --enable-kvm -hda disk.img -m 2G -cdrom etahta.iso 

* Oluşturulan sanal disk ve 2GB ram ile açma.
	
.. code-block:: shell

	qemu-system-x86_64 --enable-kvm -hda disk.img -m 2G #sadece disk ile çalıştırılıyor

* Sistemi etahta.iso dosyamızı 2GB ramdan oluşan bir makina olarak çalıştıralım.
	
.. code-block:: shell
	
	qemu-system-x86_64 -m 2G -cdrom etahta.iso          #sadece iso doayası ile çalıştırma

Sistem Hızlandırılması
++++++++++++++++++++++

**--enable-kvm** eğer sistem disk ile çalıştırıldığında bu parametre eklenmezse yavaş çalışacaktır.

Boot Menu Açma
++++++++++++++

Sistemin diskten mi imajdan mı başlayacağını başlangıçta belilemek için boot menu gelmesini istersek aşağıdaki gibi komut satırına seçenek eklemeliyiz.
	
.. code-block:: shell
	
	qemu-system-x86_64 --enable-kvm -cdrom distro.iso -hda disk.img -m 4G -boot menu=on  

Uefi kurulum için:
++++++++++++++++++

sudo apt-get install ovmf

qemu-system-x86_64 --enable-kvm -bios /usr/share/ovmf/OVMF.fd -cdrom distro.iso -hda disk.img -m 4G -boot menu=on   

qemu Host Erişimi:
++++++++++++++++++

kendi ipsi:10.0.2.15 

ana bilgisayar 10.0.0.2 olarak ayarlıyor.

Kaynak:
| https://www.ubuntubuzz.com/2021/04/how-to-boot-uefi-on-qemu.html  

.. raw:: pdf

   PageBreak
