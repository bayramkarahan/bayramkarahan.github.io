user-dirs
+++++++++

user-dirs, Linux işletim sistemlerinde kullanıcıların özel klasörlerini içeren bir sistemdir. Bu klasörler genellikle "Masaüstü", "Belgeler", "İndirilenler" gibi isimlerle tanımlanır ve kullanıcıların dosyalarını düzenlemelerini kolaylaştırır.

user-dirs klasörünü kaldırmak için aşağıdaki adımları izleyebilirsiniz:

    Terminali açın ve aşağıdaki komutu girin:

.. code-block:: shell

	nano ~/.config/user-dirs.dirs

    Bu komut, user-dirs.dirs dosyasını açacaktır. Bu dosya, kullanıcı klasörlerinin yolunu ve adını içerir.

    Dosyayı düzenlemek için, kaldırmak istediğiniz klasörün satırını bulun ve "#" işaretiyle başlayan bir yorum satırı yapın. Örneğin, "Masaüstü" klasörünü kaldırmak istiyorsanız, satırı aşağıdaki gibi düzenleyin:

.. code-block:: shell

	#XDG_DESKTOP_DIR="$HOME/Masaüstü"

    Dosyayı kaydetmek ve kapatmak için "Ctrl + X" tuşlarına basın, ardından "Y" tuşuna basın ve Enter tuşuna basın.

    Değişikliklerin etkili olması için oturumu kapatıp tekrar açın veya aşağıdaki komutu girin:

.. code-block:: shell

	xdg-user-dirs-update

Bu adımları takip ederek user-dirs klasörünü Linux sisteminizden kaldırabilirsiniz. Ancak, dikkatli olun ve yanlışlıkla önemli dosyaları silmemeye özen gösterin.

Yeni oluşturulacak kullanıcılarda oluşturulmamasını istiyorsak **/etc/skel/.config/user-dirs.dirs** dosyasını silmeliyiz.


.. raw:: pdf

   PageBreak
