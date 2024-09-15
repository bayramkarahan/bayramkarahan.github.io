**X Pencere Derleme**
++++++++++++++++++++

X Pencere sistemini derlemek için öncelikle gerekli bağımlılıkların kurulu olduğundan emin olmalısınız. Aşağıdaki adımları izleyerek X Pencere'yi derleyebilirsiniz:

    Gerekli Paketleri Yükleyin: Gerekli kütüphaneleri ve araçları yüklemek için terminalde aşağıdaki komutu çalıştırın:

.. code-block:: shell

	sudo apt-get install build-essential xorg-dev

Kaynak Kodunu İndirin: X Pencere kaynak kodunu resmi web sitesinden indirin. Örneğin:

.. code-block:: shell

	wget https://www.x.org/archive/individual/xserver/xorg-server-1.20.13.tar.gz
	tar -xzf xorg-server-1.20.13.tar.gz
	cd xorg-server-1.20.13

Yapılandırma: Yapılandırma dosyasını oluşturmak için ./configure komutunu kullanın:

.. code-block:: shell

	./configure

Derleme: Derleme işlemini başlatmak için:

.. code-block:: shell

	make

Kurulum: Derleme tamamlandıktan sonra, X Pencere'yi kurmak için:

.. code-block:: shell

	sudo make install

Bu adımları takip ederek X Pencere sistemini başarıyla derleyebilir ve kurabilirsiniz. Herhangi bir hata ile karşılaşırsanız, hata mesajlarını dikkatlice inceleyerek gerekli düzeltmeleri yapmalısınız.


.. raw:: pdf

   PageBreak

