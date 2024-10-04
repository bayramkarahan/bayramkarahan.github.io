Yazıcı
++++++

Terminal üzerinden yazıcı kurulumunu yapmak için aşağıdaki işlem adımlarını kullanabiliriz.

Yazıcı bağlantılarını listeler
------------------------------

Komut
.....

.. code-block:: shell

	sudo lpinfo -v|grep direct|cut -d ' ' -f2

Çıktı
.....

.. code-block:: shell

	hp:/usb/HP_LaserJet_1020?serial=FN2FRY9
	usb://HP/LaserJet%201020?serial=FN2FRY9


Yazıcı ekleme
-------------

Komut
.....

.. code-block:: shell

	sudo lpadmin -p YaziciAdi -E -P hp-laserjet_1020.ppd -v hp:/usb/HP_LaserJet_1020?serial=FN2FRY9
	#sudo lpadmin -p YaziciAdi -E -P ./HP-LaserJet_1020.ppd -v hp:/usb/HP_LaserJet_1020?serial=FN2FRY9


Varsayılan yazıcı atama
-----------------------

Komut
.....

.. code-block:: shell

	sudo lpoptions -d YaziciAdi


.. raw:: pdf

   PageBreak
