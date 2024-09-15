.. _paketsistemi:

**Paket Sitemi**
++++++++++++++++

Paket yönetim sistemleri bir dağıtımda bulunan en temel parçadır.
Sistem üzerine paket kurma ve kaldırma güncelleme yapma gibi işlemlerden sorumludur.
Başlıca 2 tip paket sistemi vardır:

* Binary (ikili) paket sistemi
* Source (kaynak) paket sistemi

Bir paket sistemi hem binary hem source paket sistemi özelliklerine sahip olabilir. Bununla birlikte son kullanıcı dağıtımlarında genellikle binary paket sistemleri tercih edilir.


**Binary Paket Sistemi**
------------------------

Bu tip paket sistemlerinde önceden derlenmiş olan paketler hazır şekilde indirilir ve açılarak sistem ile birleştirilir. 
Binary paket sistemlerinde paketler önceden derleme talimatları ile oluşturulmalıdır.

Binary paket sistemine örnek olarak **apt**, **dnf**, **pacman** örnek verilebilir.

**Source Paket Sistemi**
------------------------

Bu tip paket sistemlerinde derleme talimatları kurulum yapılacak bilgisayar üzerinde kullanılarak paketler kurulum yapılacak bilgisayarda oluşturulur ve kurulur.

Source paket sistemine örnek olarak **portage** örnek verilebilir.


**Paket sisteminin temel yapısı**
---------------------------------

Dağıtımlarda uygulamalar paketler halinde hazırlanır. Bu paketleri dağıtımda kullanabilmek için temel işlemler şunlardır;

1. Paket Oluşturma
2. Paket Liste İndexi Güncelleme
3. Paket Kurma
4. Paket Kaldırma
5. Paket Yükseltme gibi işlemleri yapan uygulamaların tamamı paket sistemi olarak adlandırılır.

Paket sisteminde, uygulama paketi haline getirilip sisteme kurulur. Genelde paket sistemi dağıtımın temel bir parçası olması sebebiyle üzerinde yüklü gelir.

Bazı dağıtımların kullandığı paket sistemeleri şunlardır.

- apt: Debian dağıtımının kullandığı paket sistemi.
- emerge :Gentoo dağıtımının kullandığı paket sistemi.

**bps Paket Sistemi**
---------------------

Bu dokümanda hazırlanan dağıtımın paket sistemi için ise bps(basit/basic/base paket sistemi) olarak ifade edeceğimiz paket sistemi adını kullandık. Bps paket sistemindeki beş temel işlemin nasıl yapılacağı ayrı başlıklar altında anlatılacaktır. Paket sistemi derlemeli bir dil yerine bash script ile yapılacaktır. Bu dokumanı takip eden kişi, bu dokümanda yazılanları anlaması için orta seviye bash script bilmesi gerekmektedir.


.. raw:: pdf

   PageBreak

