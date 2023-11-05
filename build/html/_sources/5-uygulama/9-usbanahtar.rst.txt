usbkeycreaterusers
==================

	.. image:: /_static/images/0-usbkeycreater.svg
  		:width: 100

Bu proje usb anahtar hazırlama ve açılmasını içeren bir projedir.

**Kurulum:**

Kurulum için deb paketini indirip kurununuz.

**Usb Hazırlamak:**

Aşağıdaki aşamaları sırasıyla uygulayarak usb disk hazırlanabilir.

| Yönetici şifresini girerek uygulama açılır.

	.. image:: /_static/images/2-usbkey.png
  		:width: 600

| Usb anahtarın kullanacağı kullanıcı adını yazınız. 

	.. image:: /_static/images/3-usbkey.png
  		:width: 600

| Anahtar oluştur seçildiğinde alt köşede disk hazırlandı mesajı verir ve usb olmadığı zaman kullanmak için parola verir. Disk hazırlandı mesajını aldığınızda usb diskiniz hazırlanmıştır.
	
	.. image:: /_static/images/4-usbkey.png
  		:width: 600



**Usb Anahtar Olarak Kullanma:**

1- Sistemi yeniden başlatın

2- Oturum açma giriş ekranına geldiğinde usb diskiniz takınız.

3- Usb disk takılınca sistem ebaqr kullanıcısıyla açılacaktır.

4- Oturum açıkken usb diski çıkartığınız  oturumu kapatacaktır.

5- Eğer disk çıkartıldığında başka bir farklı bir komut çalıştırmak isterseniz;


.. code-block:: shell

  /usr/share/usbkeycreater/command.conf dosya içeriğini değiştirin.


**Örnek 1(Oturum Kapatma varsayılan bu var):**

.. code-block:: shell
  
  sudo echo "loginctl terminate-seat seat0">/usr/share/usbkeycreater/command.conf

**Örnek 2(Sistemi Kapatma):**

.. code-block:: shell
 
  sudo echo "poweroff">/usr/share/usbkeycreater/command.conf

**Örnek 3(Sistemi Yeniden Başlatma):**

.. code-block:: shell
  
  sudo echo "reboot">/usr/share/usbkeycreater/command.conf

Yukarıdaki örnekleri veya başka bir işi yapacak komutları çalıştırabilirsiniz. Kurulduğunda varsayılan olarak ilk örnek çalışacak şekilde ayarlanmıştır.
Terminalde örneklerde gösterilen komut çalıştırılarak görev tanımlaması yapabilirsiniz.


Paket Ve Kod
| usbkeycreaterusers paket ve kaynak kodları için `tıklayınız. <https://github.com/bayramkarahan/usbkeycreaterusers>`_
| usbkeycreaterusers imajı için usbkeycreaterusers `indir. <https://github.com/bayramkarahan/usbkeycreaterusers/raw/master/usbkeycreaterusers_1.5.0_amd64.deb>`_

.. raw:: pdf

   PageBreak
