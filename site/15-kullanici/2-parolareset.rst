Şifre Sıfırlama
================

Bazı durumlarda sistem kullanıcı şifresi unutulabilir. Bu durumda şifres sıfırlaması yapılır.
Bu işlem için;

1- Bilgisayarı açtığınızda karşınıza gelen ilk ekranda (grub) seçeneği üzerindeyken e tuşuna basın

2- Kernel ile başlayan satırın en sonuna gidin ve bir karekter boşluk bırakdıkdan sonra *init=/bin/bash* yazın

3- Enter tuşuna basın sonra da b tuşuna basarak sistemi açın.

4- Bu işlem sizi direk konsolda root yapacaktır / (root). 

5- Sisteminizi yazılabilir şekilde yükleyin. mount -no remount,rw /

6- *passwd root* komutu girin. Sizden yeni yönetici şifresini isteyecek. Yeni root şifresini belirlemiş olacaksınız.

7- reboot komutu ile bilgisayarınızı tekrar başlatabilirsiniz.

.. raw:: pdf

   PageBreak
