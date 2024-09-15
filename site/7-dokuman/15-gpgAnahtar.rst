GPG Nedir?
==========
GnuPG, RFC4880 ( PGP olarak da bilinir ) tarafından tanımlanan OpenPGP standardının eksiksiz ve ücretsiz bir uygulamasıdır . GnuPG, verilerinizi ve iletişimlerinizi şifrelemenize ve imzalamanıza olanak tanır; her türlü ortak anahtar dizini için erişim modüllerinin yanı sıra çok yönlü bir anahtar yönetim sistemine sahiptir. GPG olarak da bilinen GnuPG, diğer uygulamalarla kolay entegrasyon sağlayan özelliklere sahip bir komut satırı aracıdır. Çok sayıda ön uç uygulama ve kütüphane mevcuttur. GnuPG ayrıca S/MIME ve Secure Shell (ssh) desteği de sağlar.

Ayrıntılı bilgi:

1. https://www.gnupg.org/
2. https://tr.wikipedia.org/wiki/GNU_Privacy_Guard)

GPG anahtar çifti oluşturma
+++++++++++++++++++++++++++

gpg komutunun, bir gpg anahtar çifti oluşturmak için üç seçeneği vardır:

1. --quick-generate-key seçeneği; komut satırında USER-ID alanını ve isteğe bağlı olarak bir algoritma, kullanım ve son kullanma tarihi belirtmenizi gerektirir. Diğer tüm seçenekler için varsayılanları uygular.

2. --generate-key seçeneği; devam etmek için onay istemeden önce gerçek adı ve e-posta alanlarını girmenizi ister. Anahtar oluşturmanın yanı sıra iptal sertifikasını da saklar.

3. --full-generate-key seçeneği, tüm verileri istemek için bir iletişim kutusu sağlar.

.. code-block:: shell

	$ gpg --full-generate-key


Bizden kullanmak istediğimiz anahtar türünü seçmemizi isteyecek.
1 numarayı seçelim. 

.. image:: /_static/images/gpg1.png

1024 - 4096 bit arasında bir anahtar uzunluğunu belirlememizi isteyecek. Mesela 4096 yazalım.

.. image::  /_static/images/gpg2.png

Anahtar geçerlilik süresini belirlememizi isteyecek.

* 0  = Süresiz
* 7  = 7 gün çeçerli
* 8w = 8 hafta geçerli
* 3m = 3 ay geçerli
* 1y = 1 yıl geçerli

İstediğiniz birini seçin. Bu doğru mu? (e/H yada y/N) sorusunu cevaplayın.

.. image::  /_static/images/gpg3.png

Kullanıcı kimliği oluşturmak için bazı bilgiler isteyecek onları yazın.

.. image::  /_static/images/gpg4.png

Değiştirmek istediğiniz bilgi varsa burada değiştirebilirsiniz. Herşey doğru ise T yazın.

Şimdi bizden oluşturduğumuz anahtarın güvenliği için parola belirlememizi isteyecek. Rakam, harf ve özel karakterlerden oluşan unutmayacağınız bir parola belirleyin. 


.. image::  /_static/images/gpg5.png

Aynı parolayı iki defa yazmamızı isteyecek. Herşey tamam ise anahtarımızı oluşturduk.

.. image::  /_static/images/gpg6.png


Sahib olduğumuz anahtarları görmek için

.. code-block:: bash

    $gpg --list-key

yazabiliriz.

Home dizinimiz altında .gnupg adlı bir dizin oluturuldu.


.. image::  /_static/images/gpg7.png


Bir dosya imzalamak için --sign veya --clear-sign seçeneklerinden birini kulalnabiliriz.

.. code-block:: shell

    $gpg --clear-sign ./deneme.txt

İmza Kontrolü
-------------

.. image::  /_static/images/gpg8.png

Dosya imza kontrolü için --verify seçeneğini kullanabiliriz.


.. code-block:: shell

    $gpg --verify ./deneme.txt


.. image::  /_static/images/gpg9.png


GPG Key Silme
-------------
Var olan GPG anahtarlarını silmek için öncelikle secret keyi silmemiz gerekir. Daha sonrasında public keyi silerek tüm anahtarları silmiş oluruz.

* gpg --delete-secret-key "Kullanıcı Adı"
* gpg --delete-key "Kullanıcı Adı"

- Celaleddin AKARSU

.. raw:: pdf

   PageBreak
