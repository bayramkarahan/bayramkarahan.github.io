**X Paketleri**
+++++++++++++++

x11 derlemek için maddeler halinde verilen adreslerin içinde bulunanan paketlerin son versiyonları derlenmelidir.
Bu paketler birbirine bağımlı paketlerdir.  Bundan dolayı aşağıda verdiğim sıralamaya göre derlenmelidir.

- https://www.x.org/releases/individual/xcb/
- https://www.x.org/releases/individual/util/
- https://www.x.org/releases/individual/proto/
- https://www.x.org/releases/individual/driver/
- https://www.x.org/releases/individual/lib/
- https://www.x.org/releases/individual/xserver/
- https://www.x.org/releases/individual/font/
- https://www.x.org/releases/individual/app/

Bunların dışında x11 pencere sisteminin en önemli paketleri şunlardır;

1. mesa : https://gitlab.freedesktop.org/mesa/mesa/-/tags
2. llvm	: https://github.com/llvm/llvm-project/tags
3. cairo: https://gitlab.freedesktop.org/cairo/cairo/-/tags

Tüm paketleri derlesek bile **mesa,llvm,cairo** paketleri düzgün ve uyumlu versiyonları olmadığı zaman X penceremiz açılmayacaktır.

Buradaki tüm paketler ve bağımlılıkları derlendikten sonra **Xorg:0** şeklinde elle çalıştırarak hata ayıklama yapılmalıdır. 

.. raw:: pdf

   PageBreak

