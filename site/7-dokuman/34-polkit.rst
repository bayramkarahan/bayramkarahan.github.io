polkit
++++++

Polkit, Linux sistemlerinde yetkilendirme ve erişim kontrolü sağlayan bir altyapıdır. Polkit kuralları, belirli kullanıcıların veya kullanıcı gruplarının belirli işlemleri gerçekleştirmesine izin vermek veya engellemek için kullanılır.

Polkit kurallarını eklemek için aşağıdaki adımları izleyebilirsiniz:

Polkit kurallarının bulunduğu dizine gidin. Genellikle **/etc/polkit-1/rules.d/** ve **/usr/share/polkit-1/rules.d/** dizininde bulunur.
Bir metin düzenleyici kullanarak yeni bir dosya oluşturun veya mevcut bir dosyayı düzenleyin. Dosya adı, genellikle **XX-name.rules** formatında
olmalıdır. Burada XX, kuralların uygulanma sırasını belirten bir sayıdır ve name ise dosyanın açıklamasını temsil eder.
Dosyaya aşağıdaki gibi bir polkit kuralı ekleyin:

.. code-block:: shell

	polkit.addRule(function(action, subject) {
	    if (action.id == "org.example.customaction" && subject.user == "username") {
		return polkit.Result.YES;
	    }
	});

Yukarıdaki örnekte, **org.example.customaction** adlı bir eylem için **username** kullanıcısına izin veriliyor. Bu kuralı ihtiyaçlarınıza göre düzenleyebilirsiniz.

Dosyayı kaydedin ve düzenlediğiniz kuralların etkili olması için Polkit servisini yeniden başlatın. Bu işlem için aşağıdaki komutu kullanabilirsiniz:

.. code-block:: shell

	sudo systemctl restart polkit

Artık polkit kurallarınız etkinleştirilmiş olmalı ve belirlediğiniz yetkilendirmeler uygulanmalıdır.

Polkit kuralları, sistem yöneticilerinin belirli işlemleri kontrol etmesine ve kullanıcıların erişimini yönetmesine olanak tanır. Bu sayede sistem güvenliği ve yetkilendirme düzeyi daha iyi kontrol edilebilir.

Tüm Uygulamalarda İzin Verme
----------------------------

.. code-block:: shell

	polkit.addRule(function(action, subject) {
			return polkit.Result.YES;
	});

Bir Gruba İzin Verme
--------------------

.. code-block:: shell

	polkit.addRule(function(action, subject) {
	    if (subject.isInGroup("test")) {
	      return polkit.Result.YES;
	  }
	});

Bir Grub-User-Uygulamaya İzin Verme
-----------------------------------
.. code-block:: shell

	 polkit.addRule( 
	  function(action,subject)
	  {
	    if ( (action.id == "org.freedesktop.policykit.exec") &&
		 (action.lookup("user") == "root") &&
		 (action.lookup("program") == "/path/to/script") &&
		 (subject.isInGroup("someGroup") ) )
	      return polkit.Result.YES;

	    return polkit.Result.NOT_HANDLED;
	  }
	);


Örnek Uygulama1
---------------

Bu örnekte /usr/bin/betikyukleyici ikili uygulamasını root yetkisisyle çalıştımak için aşağıdaki işlem adımları yapılır.

Policy Oluşturma
^^^^^^^^^^^^^^^^
/usr/share/polkit-1/action dizinine betikyuleyici.policy dosyası oluşturulur ve aşağıdaki kodlar içerisi eklenir ve kaydedilir.

.. code-block:: shell

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy 1.0//EN"
	"http://www.freedesktop.org/standards/PolicyKit/1.0/policy.dtd">
	<policyconfig>
	  <action id="org.example.betikyukleyici">
		<message>Bu uygulamayı çalıştırmak için izin gereklidir.</message>
		<defaults>
		  <allow_any>auth_admin</allow_any>
		  <allow_inactive>auth_admin</allow_inactive>
		  <allow_active>auth_admin</allow_active>
		</defaults>
		   <annotate key="org.freedesktop.policykit.exec.path">/usr/bin/betikyukleyici</annotate>
	   <annotate key="org.freedesktop.policykit.exec.allow_gui">true</annotate>
	  </action>
	</policyconfig>

allow_any ayarları:
...................

Bu ayarların her biri için aşağıdaki seçenekler mevcuttur:

    no : Kullanıcının işlemi gerçekleştirme yetkisi yoktur. Bu nedenle kimlik doğrulamaya gerek yoktur.
    yes : Kullanıcı herhangi bir kimlik doğrulaması olmadan işlemi gerçekleştirme yetkisine sahiptir.
    auth_self : Kimlik doğrulama gereklidir ancak kullanıcının yönetici kullanıcı olması gerekmez.
    auth_admin : Yönetici kullanıcı olarak kimlik doğrulaması gerekiyor.
    auth_self_keep : auth_self ile aynıdır ancak sudo gibi yetkilendirme birkaç dakika sürer.
    auth_admin_keep : auth_admin ile aynıdır ancak sudo gibi yetkilendirme birkaç dakika sürer.
    
rules Oluşturma
^^^^^^^^^^^^^^^

/usr/share/polkit-1/rules.d dizinine betikyuleyici.rules dosyası oluşturulur ve aşağıdaki kodlar içerisi eklenir ve kaydedilir.

.. code-block:: shell

	polkit.addRule(function(action, subject) {
		if (action.id == "com.example.betikyukleyici") {
		    return polkit.Result.YES;
		}
	});

Çalıştırılması
^^^^^^^^^^^^^^

.. code-block:: shell

	sudo systemctl restart polkit
	pkexec /usr/bin/betikyukleyici


Örnek Uygulama2
---------------

Bu örnekte /usr/bin/test.py python scriptinin root yetkisisyle çalıştımak için aşağıdaki işlem adımları yapılır.

.. code-block:: shell

	#!/usr/bin/pkexec /usr/bin/python3
	# test.py
	import os

	def main():
		print("Bu bir Polkit ile çalıştırılan Python dosyasıdır.")
		os.system("mkdir /test")  # Kökte test adında dizin oluşturur

	if __name__ == "__main__":
		main()


Policy Oluşturma
^^^^^^^^^^^^^^^^
/usr/share/polkit-1/action dizinine test.policy dosyası oluşturulur ve aşağıdaki kodlar içerisi eklenir ve kaydedilir.

.. code-block:: shell

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy 1.0//EN"
	"http://www.freedesktop.org/standards/PolicyKit/1.0/policykit-policy.dtd">
	<policyconfig>
	  <action id="org.example.test">
		<message>Bu scripti çalıştırmak için yetki gereklidir.</message>
		<defaults>
			  <allow_any>auth_admin</allow_any>
			  <allow_inactive>auth_admin</allow_inactive>
			 < allow_active>auth_admin</allow_active>
		</defaults>
		 <annotate key="org.freedesktop.policykit.exec.path">/test.py</annotate>
		<annotate key="org.freedesktop.policykit.exec.allow_gui">true</annotate>
	  </action>
	</policyconfig>


allow_any ayarları:
...................

Bu ayarların her biri için aşağıdaki seçenekler mevcuttur:

    no : Kullanıcının işlemi gerçekleştirme yetkisi yoktur. Bu nedenle kimlik doğrulamaya gerek yoktur.
    yes : Kullanıcı herhangi bir kimlik doğrulaması olmadan işlemi gerçekleştirme yetkisine sahiptir.
    auth_self : Kimlik doğrulama gereklidir ancak kullanıcının yönetici kullanıcı olması gerekmez.
    auth_admin : Yönetici kullanıcı olarak kimlik doğrulaması gerekiyor.
    auth_self_keep : auth_self ile aynıdır ancak sudo gibi yetkilendirme birkaç dakika sürer.
    auth_admin_keep : auth_admin ile aynıdır ancak sudo gibi yetkilendirme birkaç dakika sürer.
    
rules Oluşturma
^^^^^^^^^^^^^^^

/usr/share/polkit-1/rules.d dizinine test.rules dosyası oluşturulur ve aşağıdaki kodlar içerisi eklenir ve kaydedilir.

.. code-block:: shell

	polkit.addRule(function(action, subject) {
		if (action.id == "org.example.test") {
		   return polkit.Result.YES;
		}
	});
	
Çalıştırılması
^^^^^^^^^^^^^^

.. code-block:: shell

	sudo systemctl restart polkit
	pkexec /usr/bin/test.py


.. raw:: pdf

   PageBreak
