pkexec Kullanma
===============

Gui uygulamalarda root yetkisi ile uygulama çalıştırmak istenebilir. bu durumda aşağıdaki komutla yapabiliriz.

pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY usbKeyCreater 

İstenilen bir kullanıcıda çalıştırmak
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: shell


	pkexec --user root /usr/bin/app şeklinde kullanılabilir.
	#veya
	echo password | su -c "pkill -9 java" user


Açık olan bir kullanıcı ile komut çalıştırma
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: shell

	echo password | su -c "pkill -9 java" $(whoami)

Desktop Dosyasından Çalıştırma
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: shell

	Exec=sh -c "pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY usbKeyCreater" bu şekilde kullanmalıyız.

Sadece root kullanıcı olarak çalıştırmak için dosya haklarını, 700 olarak değiştirmeliyiz.

Önemli Hususlar
^^^^^^^^^^^^^^^
* İstenilen bir kullanıcı ile komut çalıştırma(sudo yetkisi olmayan bir kullanıcı içinde geçerlidir)
* sudo kullanıcısı birden fazla ise hangisini kullanacağımızı seçebiliriz.


.. raw:: pdf

   PageBreak
