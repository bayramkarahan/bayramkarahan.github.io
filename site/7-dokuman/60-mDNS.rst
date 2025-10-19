Linux Üzerinde Hostname (İsim) ile UDP Haberleşmesi
===================================================

Bu öğreticide, **IP adresleri yerine makine isimlerini (hostname)** kullanarak 
**UDP haberleşmesi** yapmayı öğreneceksiniz.  
Amaç, aynı yerel ağda bulunan iki bilgisayarın birbirleriyle IP adresleri yerine 
örneğin ``pc-a.local`` ve ``pc-b.local`` isimleri üzerinden iletişim kurmasını sağlamaktır.

.. contents::
   :local:
   :depth: 2

---

Sistem Bilgileri
----------------

Örnek ağ yapımız şu şekildedir::

    Bilgisayar A: 192.168.1.102 (hostname: pc-a)
    Bilgisayar B: 192.168.1.103 (hostname: pc-b)

Hedefimiz:
   - A makinesi, UDP mesajlarını **pc-b.local** adresine gönderecek.  
   - B makinesi, **pc-a.local** adresinden gelen mesajları alacak.

---

1. Avahi Kurulumu (mDNS Yapılandırması)
---------------------------------------

mDNS (Multicast DNS), küçük ağlarda DNS sunucusu olmadan
makine adlarını ``.local`` uzantısıyla otomatik olarak çözümleyen bir sistemdir.
Linux'ta bu işlevi ``avahi-daemon`` ve ``libnss-mdns`` paketleri sağlar.

Her iki bilgisayarda aşağıdaki adımları izleyin:

.. code-block:: bash

    sudo apt update
    sudo apt install avahi-daemon libnss-mdns

Servisin aktif olup olmadığını kontrol edin:

.. code-block:: bash

    sudo systemctl enable avahi-daemon
    sudo systemctl start avahi-daemon
    sudo systemctl status avahi-daemon

Çıktı içinde ``active (running)`` ibaresi görünmelidir.

---

2. Bilgisayar İsimlerini (Hostname) Ayarlama
--------------------------------------------

Her bilgisayara anlamlı bir hostname verelim.

Bilgisayar A (192.168.1.102):

.. code-block:: bash

    sudo hostnamectl set-hostname pc-a

Bilgisayar B (192.168.1.103):

.. code-block:: bash

    sudo hostnamectl set-hostname pc-b

Değişikliklerin etkili olması için ``avahi-daemon`` servisini yeniden başlatın:

.. code-block:: bash

    sudo systemctl restart avahi-daemon

---

3. İsim Çözümleme Testi
-----------------------

Şimdi her iki makine arasında ``.local`` uzantılı isimlerle iletişimi test edelim.

Bilgisayar A üzerinde:

.. code-block:: bash

    ping pc-b.local

Bilgisayar B üzerinde:

.. code-block:: bash

    ping pc-a.local

Eğer her iki yönde de yanıt alıyorsanız, mDNS yapılandırmanız başarılı olmuştur ✅

---

4. Qt C++ ile UDP Haberleşmesi
------------------------------

Bu bölümde iki küçük Qt C++ uygulaması oluşturacağız:
bir **UDP alıcı (receiver)** ve bir **UDP gönderici (sender)**.

---

Receiver (Dinleyici) – pc-b.local
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``udp_receiver.cpp``:

.. code-block:: cpp

    #include <QUdpSocket>
    #include <QCoreApplication>
    #include <QDebug>

    int main(int argc, char *argv[])
    {
        QCoreApplication a(argc, argv);
        QUdpSocket socket;

        quint16 port = 45454;
        if (!socket.bind(QHostAddress::AnyIPv4, port)) {
            qCritical() << "Bağlantı hatası:" << socket.errorString();
            return -1;
        }

        QObject::connect(&socket, &QUdpSocket::readyRead, [&]() {
            while (socket.hasPendingDatagrams()) {
                QByteArray data;
                data.resize(socket.pendingDatagramSize());
                QHostAddress sender;
                quint16 senderPort;
                socket.readDatagram(data.data(), data.size(), &sender, &senderPort);
                qDebug() << "Mesaj geldi:" << data << "Gönderen:" << sender.toString();
            }
        });

        qDebug() << "UDP alıcı çalışıyor. Port:" << port;
        return a.exec();
    }

``udp_receiver.pro``:

.. code-block:: make

    QT += core network
    CONFIG += console c++11
    SOURCES += udp_receiver.cpp

---

Sender (Gönderici) – pc-a.local
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``udp_sender.cpp``:

.. code-block:: cpp

    #include <QUdpSocket>
    #include <QCoreApplication>
    #include <QHostInfo>
    #include <QDebug>

    int main(int argc, char *argv[])
    {
        QCoreApplication a(argc, argv);
        QUdpSocket socket;

        QString targetHost = "pc-b.local";
        quint16 port = 45454;
        QByteArray message = "Merhaba pc-b!";

        // Host adını IP'ye çevir
        QHostInfo::lookupHost(targetHost, [&](const QHostInfo &info) {
            if (info.error() != QHostInfo::NoError) {
                qCritical() << "Çözümleme hatası:" << info.errorString();
                return;
            }

            for (const auto &addr : info.addresses()) {
                if (addr.protocol() == QAbstractSocket::IPv4Protocol) {
                    socket.writeDatagram(message, addr, port);
                    qDebug() << "Gönderildi:" << message << "->" << addr.toString();
                    break;
                }
            }
        });

        return a.exec();
    }

``udp_sender.pro``:

.. code-block:: make

    QT += core network
    CONFIG += console c++11
    SOURCES += udp_sender.cpp

---

5. Derleme ve Çalıştırma
------------------------

1. **pc-b.local** üzerinde alıcıyı çalıştırın:

   .. code-block:: bash

       ./udp_receiver

2. **pc-a.local** üzerinde göndericiyi çalıştırın:

   .. code-block:: bash

       ./udp_sender

Eğer her şey doğru yapılandırıldıysa, alıcı terminalinde aşağıdaki gibi bir çıktı görürsünüz:

::

    Mesaj geldi: "Merhaba pc-b!" Gönderen: "192.168.1.102"

---

6. Güvenlik Duvarı Kontrolü
---------------------------

Eğer ping çalışıyor ama UDP mesajları ulaşmıyorsa,
muhtemelen sistem güvenlik duvarı (UFW) UDP trafiğini engelliyordur.

Aşağıdaki komutla UDP po

