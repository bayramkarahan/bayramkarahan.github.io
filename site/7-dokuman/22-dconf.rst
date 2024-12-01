
dconf ve Sistem Ayarları
++++++++++++++++++++++++

dconf
-----

dconf, sistem ayarlarını  düzenlemek için kullanılan bir veritabanıdır. **/home/etapadmin/.config/dconf/user**
içinde ayarlar saklanmaktadır. 

Aşağıda dconf komutu ile kullanıcının kullandığı fontu öğreniliyor. 
Bu bilgi  **/home/etapadmin/.config/dconf/user** dosyasının içinde saklanıyor.

.. code-block:: shell

	dconf read /org/gnome/desktop/interface/font-name

Aşağıda dconf komutu ile kullanıcının fontu değiştiriliyor.

.. code-block:: shell

	dconf write /org/gnome/desktop/interface/font-name "'Sans 12'"
	dconf update

Burada yapılan işlemleri **dconf-editor** grafik uygulamasıyla yapılabilir.


gsetting
--------
gsettings uygulaması dconf'un kullanıcı dostu altyernatifidir. Yukarıdaki işlemi gsettings ile yapalım.

Font Öğrenme
............

Aşağıda dconf komutu ile kullanıcının kullandığı fontu öğreniliyor.

.. code-block:: shell

	gsettings get org.gnome.desktop.interface font-name


Font Değiştirme
...............

Aşağıda dconf komutu ile kullanıcının fontu değiştiriliyor.

.. code-block:: shell

	gsettings set org.gnome.desktop.interface font-name "'Sans 12'"
	dconf update
 

schemas
-------

dconf ve gsettings  kullanmadan schemas dosyalarıylada ayarlar düzenlenebilir. 

Kullanıcıya özel ayarlar yapmak istiyorsak **$HOME/.local/share/glib-2.0/schemas/** kullanıcı konumuna xxx.xml konulur.

.. code-block:: shell

	#kullanıcıda  değişiklik yapılmışsa ayarları geçerli kılma
	glib-compile-schemas $HOME/.local/share/glib-2.0/schemas


Tüm sistemi kullananlarda geçerli olmasını istiyorsak  **/usr/share/glib-2.0/schemas/** kullanıcı konumuna xxx.xml konulur.

.. code-block:: shell
	
	#sistem değişiklik yapılmışsa ayarları geçerli kılma
	sudo glib-compile-schemas /usr/share/glib-2.0/schemas

Ayarları Kaldırma
-----------------

Ayarları kaldırmak için yerel kullanıcıdan **$HOME/.local/share/glib-2.0/schemas/**, 
sistemden kaldırmak için **/usr/share/glib-2.0/schemas/** konumundan xxx.xml dosyamızı silmeliyiz.
Ayarların sistemde geçerli olması için aşağıdaki komut çalıştırmalıdır;

.. code-block:: shell
	
	#sistem değişiklik yapılmışsa ayarları geçerli kılma
	sudo glib-compile-schemas /usr/share/glib-2.0/schemas
	
	#kullanıcıda  değişiklik yapılmışsa ayarları geçerli kılma
	glib-compile-schemas $HOME/.local/share/glib-2.0/schemas


schemas Override
----------------

Sistem için schemas dosyaları **/usr/share/glib-2.0/schemas** konumunda bulunur.
Bu dosyalarda bir değişiklik yapmadan sadece istediğimiz değerleri değiştirmek istiyorsak
**/usr/share/glib-2.0/schemas/ozelayarlar.gschema.override** adlı bir dosya oluşturup **xml** uzantılı dosyalardaki ayarları geçersiz kılabiliriz.

.. code-block:: shell
	
	#ozelayarlar.gschema.override doaya içeriği
	
	#monitör ölçeklendirme
	[org.gnome.desktop.interface]
	text-scaling-factor=0.75
	scaling-factor=2
	
	#font değiştirme
	[org.gnome.desktop.interface]
	font-name='Sans 12'

override dosyalarında yapılan ayarların geçerli olması için sistemin yeniden başlatılması gerekmektedir.
override dosyasının geçerli olması için dosya içerisinde değiştirilen değerlerin resetlenmesi(ayarlanmamış)  gerekmektedir.

Aşağıda font ismi resetleniyor. Eğer resetlenmezse override dosyasındaki ayarlar geçerli olmaz.

.. code-block:: shell
	
	gsettings reset org.gnome.desktop.interface font-name
	

.. raw:: pdf

   PageBreak

