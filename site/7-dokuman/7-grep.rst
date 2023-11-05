grep Kullanımı
==============

grep komutu, bir metin dosyasında veya bir dizede belirli bir deseni aramak için kullanılan güçlü bir arama aracıdır.

Temel kullanımı
+++++++++++++++

.. code-block:: shell
	
	grep "aranacak_desen" dosya_adı

Örneğin, "dosya" adlı bir metin dosyasında "merhaba" kelimesini aramak istediğimizi varsayalım. Aşağıdaki komutu kullanabiliriz:


.. code-block:: shell
	
	grep "merhaba" dosya.

grep komutu, dosya içinde "merhaba" kelimesini içeren tüm satırları ekrana yazdıracaktır.

Ayrıca, grep komutunu kullanırken bazı seçenekler de belirleyebilirsiniz. Örneğin, büyük/küçük harf duyarlılığını devre dışı bırakmak için "-i" seçeneğini kullanabilirsiniz:


.. code-block:: shell

	grep -i "merhaba" dosya

Bu komut, "merhaba" kelimesini büyük/küçük harf farkı olmaksızın arayacak ve eşleşen tüm satırları ekrana yazdıracaktır.

grep komutunun daha fazla seçeneği ve kullanımı hakkında daha fazla bilgi için "man grep" komutunu kullanabilirsiniz.

Bu şekilde, grep komutunu kullanarak belirli bir deseni arayabilir ve metin dosyalarında hızlı bir şekilde bilgi bulabilirsiniz.
Bazı kriterlere göre listeler almak için grep komutu  göre listeler oluşt
Bazen dosya içerisinde farklı kelimelerin geçtiği tüm satırları görmek isteyebilirsiniz.

Çoklu Kelime Arama
++++++++++++++++++
grep komutunu kullanırken birden fazla ifade ile arama yapmak için “-e” opsiyonu kullanılabilir.

.. code-block:: shell
	
	grep  -e bash -e ahmet -e mehmet /etc/passwd

.. raw:: pdf

   PageBreak
