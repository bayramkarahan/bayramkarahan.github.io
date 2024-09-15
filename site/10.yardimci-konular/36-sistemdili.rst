
Sistem Dili Değiştirme
++++++++++++++++++++++
Dil ayarlama

Sistem dilini ayarlamak için öncelikle /etc/locale.gen dosyamızı aşağıdaki gibi düzenleyelim.

    Dil kodlarına /usr/share/i18n/locales içerisinden ulaşabilirsiniz.

    Karakter kodlamalara /usr/share/i18n/charmaps içinden ulaşabilirsiniz.

tr_TR.UTF-8 UTF-8

Not: En altta boş bir satır bulunmalıdır.

Ardından /lib64/locale dizini yoksa oluşturalım.

mkdir -p /lib64/locale/

Şimdi de çevresel değişkenlerimizi ayarlamak için /etc/profile.d/locale.sh dosyamızı düzenleyelim.

#!/bin/sh
# Language settings
export LANG="tr_TR.UTF-8"
export LC_ALL="tr_TR.UTF-8"

Not: Türkçe büyük küçük harf dönüşümü (i -> İ ve ı -> I) ascii standartına uyumsuz olduğu için LC_ALL kısmını türkçe ayarlamayı önermiyoruz. Bunun yerine C.UTF-8 veya en_US.UTF-8 olarak ayarlayabilirsiniz.

Son olarak locale-gen komutunu çalıştıralım.

locale-gen

Eğer /lib64/locale/ dizine okuma iznimiz yoksa verelim.

chmod 755 -R /lib64/locale/



**1. Yöntem**
-------------

/etc/default/locale dosyasını root olarak bir metin editörü ile açın.

- **Türkçe için :** LANG=tr_TR.UTF-8
- **İngilizce için :** LANG=en_US.UTF-8

Sistemi yeniden başlattığınızda seçtiğiniz dil aktif olacaktır.


**2. Yöntem**
-------------

/etc/profile.d/locale.sh dosyanı oluşturun içeriğini aşağıdaki gibi ayarlayın.

.. code-block:: shell

	# Language settings
	export LANG="tr_TR.UTF-8"
	export LC_ALL="tr_TR.UTF-8"

**/etc/profile.d/**  dizin erişim iznini 755 yapın.

**profile**
-----------

**/etc/profile** dosya içeriğini  aşağıdaki gibi bir betik bulunmalıdır.
 /etc/profile dosyanının içerisinde aşağıdaki betik olmalıdır. Bu betik **/etc/profile.d** içerisinde betikler varsa tüm kullanıcalr için çalıştırılmasını sağlar.

.. code-block:: shell

	if [ -d /etc/profile.d ]; then
	  for i in /etc/profile.d/*.sh; do
		if [ -r $i ]; then
		  . $i
		fi
	  done
	  unset i
	fi


**3.Yöntem**
------------

ayarlarını değiştirmek istediğimiz kullanıcı dizinideki **~/.profile** dosyasının içeriğine aşağıdaki kod satırını eklemeliyiz.

.. code-block:: shell
	
	export LANG="tr_TR.UTF-8"
	export LC_ALL="tr_TR.UTF-8"


.. raw:: pdf

   PageBreak

