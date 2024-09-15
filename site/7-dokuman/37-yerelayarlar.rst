Kullanıcı Sistem Ayarları
+++++++++++++++++++++++++

Profile Dosyası
---------------

/etc/profile dosyası, Linux sistemlerinde kullanıcıların oturum açtıklarında çalıştırılan bir betik dosyasıdır. Bu dosya, tüm kullanıcılar için ortak kabuk ayarlarını ve ortam değişkenlerini tanımlar. Kullanıcı oturumu başlatıldığında, /etc/profile dosyası sistem genelindeki ayarları yükler ve kullanıcı oturumuna uygular. Bu dosya, kullanıcıların kabuk ortamlarını yapılandırmak ve özelleştirmek için kullanılır. Örneğin, PATH değişkenini tanımlamak veya diğer kabuk ayarlarını yapılandırmak için /etc/profile dosyası düzenlenebilir. Bu dosya, sistem genelinde tutarlı bir kabuk ortamı sağlamak için önemlidir.

.. code-block:: shell

		/etc/profile
		/etc/profile.d/*
		/etc/environment
		~/.profile, veya ~/.bash_profile veya ~/.login veya ~/.zprofile giriş kabuğunuza bağlı olarak
		~/.pam_environment
		(yalnızca terminalde çalışan kabuklar için) /etc/bash.bashrc, /etc/zshrc, ~/.bashrc, ~/.zshrc, vesaire.


 **Not:**   /etc/profile.d/ dizinine root dışında kullanıcılar erişim sağlaması için 755 yapmalısınız.
 
** profile**
------------

 /etc/profile dosyanının içerisinde aşağıdaki betik olmalıdır. Bu betik **/etc/profile.d** içerisinde betikler varsa tüm kullanıcılar için çalıştırılmasını sağlar.

.. code-block:: shell

	if [ -d /etc/profile.d ]; then
	  for i in /etc/profile.d/*.sh; do
		if [ -r $i ]; then
		  . $i
		fi
	  done
	  unset i
	fi


.. raw:: pdf

   PageBreak

