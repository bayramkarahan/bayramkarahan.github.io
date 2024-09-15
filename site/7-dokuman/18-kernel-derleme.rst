Kernel Modul Derleme
++++++++++++++++++++

Kernel linux sistemlerinin temel dosyasıdır.

Kaynak Dosya İndirme
--------------------


# Linux çekirdeğinin kaynak kodunu https://kernel.org üzerinden indirin.

.. code-block:: shell

	wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.10.tar.xz
	tar -xvf linux-6.6.10.tar.xz
	cd linux-6.6.10

Kernel Ayarları
---------------

Arşiv açıldıktan sonra arşşivin açıldığı dizinde **.config** dosyası oluşturmalıyız. Bu dosyada hangi ayarlara göre derleme yapılacağını belirten parametreler var.
Eğer temel(varsayılan) ayarlarda derlenmesini istersek **make defconfig** komutyla **.config** adında bir dosya oluşturacaktır.

Ben kendim belirleyeceğim bu ayarları diyorsak **make menuconfig** komutuyla açılan ekrandan ayarlamaları yapıp ayarları kaydetmeliyiz. Ayarlar kaydedilince **.config** dossyası oluşacaktır.

Bunların dışında ben Arch, Debian vb. dağıtımların **.config** dosyasını kullanacağımda diyebilirsiniz. Burada Arch Linux **.config** dosyasını kullanacağız.

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config?ref_type=heads

Bu adresten indirilen **config** dosyasını **.config** olarak tarball(tar uzantılı şıkıştırlmış) dosyasının açıldığı dizine kopyalayalım.
 
Kernel Derleme 
--------------

**.config** ayarlamaları yapıldıktan sonra derleme yapılacak. Derleme aşağıdaki komutla yapılır.

.. code-block:: shell

	make bzImage # tek çekirdekle derleme yapacak yavaş olur
	#make bzImage -j$(proc) #işlemci çekirdek sayını sistemden alarak yapıyor, hızlı olur

Derleme işlemi biraz zaman alacakır.

Derleme tamamlandığında Kernel: arch/x86/boot/bzImage is ready (#1) şeklinde bir satır yazmalıdır. Kernelimizin düzgün derlenip derlenmediğini anlamak için aşağıdaki komutu kullanabilirsiniz.

file arch/x86/boot/bzImage 
arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version 6.6.2 (etapadmin@etahta) #1 SMP PREEMPT_DYNAMIC Sat Nov 25 19:53:19 +03 2023, RO-rootFS, swap_dev 0XC, Normal VGA

Kernel derledikten sonra kendi sistemimizde kullanmak için **/arch/x86/boot/bzImage** konumundan alıp kullanabiliriz.
Derlenen kernele uygun modüllerin derlenmesi gerekmektedir.

Modul Derleme
-------------

Modul ise kernel ile donanım arasında iletişim kuran yazılımlardır. Modüller kernel verisiyonuyla aynı versiyonda olmalıdır. Başka versiyon kerneller derlenen modül kernel tarafından kullanılamaz. Bundan dolayı kullanılacak modüllerin kernel verisyonuna uygun derlenmesi lazım.

.. code-block:: shell

	make modules  # tek çekirdekle derleme yapacak yavaş olur
	#make modules -j$(proc) #işlemci çekirdek sayını sistemden alarak yapıyor, hızlı olur

Derleme işlemi biraz zaman alacakır. Modüller derlendikten sonra sisteme aşağıdaki komutla yüklenir.

Modül Yukleme
-------------
Moduller istenilen konuma yüklenebilir. Yükleme konumunu **INSTALL_MOD_PATH** parametresiyle belirleyebiliriz.
Eğer belirmezsek /lib/konumuna yüklenecektir.

.. code-block:: shell

	INSTALL_MOD_PATH="$HOME/distro/initrd" make modules_install

Strip Yapma
-----------


Kernel Yukleme
--------------


Header Yukleme
--------------


libc Yukleme
------------


.. raw:: pdf

   PageBreak



