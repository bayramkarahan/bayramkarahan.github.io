Wine Ayarlama
=============

Wine ayarlarını yapılandırmak, Windows uygulamalarını daha iyi çalıştırmak ve performansı artırmak için önemlidir. İşte Wine ayarlarını yapılandırmak için adımlar

Yapılandırma Aracını
++++++++++++++++++++

Terminali açın ve **winecfg** komutunu çalıştırın. Bu komut, Wine yapılandırma aracını başlatacaktır.

	.. image:: /_static/images/1-wine-ayar.png
 		:width: 600
  
Wine yapılandırma
+++++++++++++++++

 Wine yapılandırma aracı, farklı sekmelerde çeşitli ayarları içerir.
 
	.. image:: /_static/images/2-wine-ayar.png
 		:width: 600
  
 
* "Uygulama" sekmesinde, belirli bir uygulama için özel ayarlar yapabilirsiniz.

	.. image:: /_static/images/3-wine-ayar.png
 		:width: 600
  
* "Ses" sekmesinde, ses ayarlarını yapılandırabilirsiniz. Diğer sekmelerde de çeşitli ayarlar bulunur.

	.. image:: /_static/images/4-wine-ayar.png
 		:width: 600
* "Ekran" ayarları yapılandırılır.

	.. image:: /_static/images/5-wine-ayar.png
 		:width: 600
  
* DLL dosyalarını yükleyin: Wine, bazı Windows DLL dosyalarını gerektirebilir. Bu DLL dosyalarını yüklemek için winetricks aracını kullanabilirsiniz. Örneğin, winetricks msxml6 komutuyla msxml6 DLL dosyasını yükleyebilirsiniz.

	.. image:: /_static/images/6-wine-ayar.png
 		:width: 600
  
Test Etme
+++++++++

Yapılandırdığınız Wine ayarlarını test etmek için bir Windows uygulamasını çalıştırın. Eğer sorunsuz bir şekilde çalışıyorsa, ayarlarınız doğru yapılandırılmış demektir.

.. raw:: pdf

   PageBreak
