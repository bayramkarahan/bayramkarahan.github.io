USB Tabanlı PAM Otomatik Oturum Açma Sistemi
=============================================

Bu belge, LightDM üzerinde çalışan bir sistemde **USB disk üzerinden kullanıcıya özel otomatik oturum açma** işlemini açıklamaktadır.  
Yapı, bir ``/etc/open.txt`` dosyası ile tetiklenir ve PAM modülü tarafından değerlendirilir.

Amaç
-----

USB diskin içinde kullanıcı bilgisi bulundurarak,
``/etc/open.txt`` dosyasını güncellemek ve sistemin LightDM üzerinden
ilgili kullanıcı için otomatik oturum açmasını sağlamaktır.

Genel Mantık
------------

1. PAM, oturum açma sırasında ``/usr/local/sbin/usb-pam-auth-test`` betiğini çağırır.
2. Betik, ``OPENSTATE`` ortam değişkenini veya ``/etc/open.txt`` dosyasını okur.
3. Dosyada belirtilen duruma göre ``exit 0`` (başarılı) veya ``exit 1`` (başarısız) döndürür.
4. Eğer oturum başarıyla açılırsa, ``/etc/open.txt`` içeriği sıfırlanır.
5. Böylece bir sonraki açılışta sistem otomatik olarak giriş yapmaz.

``/etc/open.txt`` Dosya Yapısı
-------------------------------

Dosya iki bilgiyi tutar::

    <KULLANICI>|<DURUM>

Örnek::

    etapadmin|1

Bu durumda:
- Kullanıcı adı: ``etapadmin``
- Durum: ``1`` → Oturum açılabilir.

Durum harf olduğunda PAM script ``exit 1`` döndürür ve oturum açılmaz::

    mehmet|0

Güncellenmiş PAM Script
------------------------

Dosya: ``/usr/local/sbin/usb-pam-auth-test``

.. code-block:: bash

    #!/bin/bash

    CONFIG="/etc/open.txt"

    # OPENSTATE yoksa /etc/open.txt dosyasını oku
    if [ -z "${OPENSTATE:-}" ]; then
        if [ -r "$CONFIG" ]; then
            line="$(head -n1 "$CONFIG" 2>/dev/null | tr -d '\r\n ' )"
            USERNAME="${line%%|*}"       # | öncesi kullanıcı adı
            OPENSTATE="${line##*|}"      # | sonrası durum
        fi
    fi

    # Durum kontrolü
    if [[ "$OPENSTATE" =~ ^[0-9]+$ ]] && [ -n "$USERNAME" ]; then
        echo "Oturum açılıyor: $USERNAME"

        # Oturum açıldıktan sonra tekrar açılmaması için open.txt sıfırlanır
        echo "${USERNAME}|0" > "$CONFIG"

        exit 0
    else
        echo "kapalı....."
        exit 1
    fi

Kurulum
-------

1. Betiği oluşturun::

       sudo tee /usr/local/sbin/usb-pam-auth-test > /dev/null <<'EOF'
       (yukarıdaki betik yapıştırılır)
       EOF

2. İzinleri ayarlayın::

       sudo chmod 700 /usr/local/sbin/usb-pam-auth-test
       sudo chown root:root /usr/local/sbin/usb-pam-auth-test

3. Test dosyasını oluşturun::

       echo "etapadmin|1" | sudo tee /etc/open.txt

4. PAM yapılandırmasında ``pam_exec.so`` modülünü ekleyin::

       auth requisite pam_exec.so quiet expose_authtok /usr/local/sbin/usb-pam-auth-test

   Bu satır, aşağıdaki dosyalardan birine eklenebilir:

   - ``/etc/pam.d/lightdm``
   - veya ``/etc/pam.d/common-auth`` (dağıtıma göre değişebilir)

   Örnek (``/etc/pam.d/lightdm`` içinde)::

       auth requisite pam_exec.so quiet expose_authtok /usr/local/sbin/usb-pam-auth-test
       auth required pam_unix.so

5. LightDM’i yeniden başlatın::

       sudo systemctl restart lightdm

6. Test edin::

       echo "etapadmin|1" | sudo tee /etc/open.txt
       sudo systemctl restart lightdm

       # Oturum açıldıktan sonra /etc/open.txt içeriği artık:
       # etapadmin|a

       # Tekrar açmayı denersen otomatik açılmaz.

Çalışma Prensibi
----------------

* ``/etc/open.txt`` içeriğinde geçerli (sayısal) değer varsa PAM ``exit 0`` döner.
* ``exit 0`` → Oturum açılır ve dosya sıfırlanır.
* ``exit 1`` → Greeter açık kalır, giriş engellenir.
* USB takıldığında ``/etc/open.txt`` dinamik olarak güncellenebilir.
* LightDM D-Bus API ile restart gerekmeden tetikleme ileride eklenebilir.

Gelecek Aşama
--------------

* LightDM D-Bus API veya ``dm-tool`` kullanarak **restart olmadan** oturum tetikleme.
* ``udev`` kuralı eklenerek USB takıldığında ``/etc/open.txt`` güncelleme
  ve otomatik oturum başlatma işlemini gerçekleştirme.

