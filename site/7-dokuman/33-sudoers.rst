sudoers
+++++++
sudoers dosyasını düzenleyerek, belirli kullanıcıların veya kullanıcı gruplarının parola sormadan sudo komutlarını çalıştırabilmesini sağlayabilirsiniz. Bunun için aşağıdaki adımları izleyebilirsiniz:

Terminali açın ve sudo visudo komutunu çalıştırın. Bu komut, sudoers dosyasını düzenlemek için kullanılır.
Dosya açıldığında, aşağıdaki gibi bir satır bulun:

.. code-block:: shell

	%sudo   ALL=(ALL:ALL) ALL


    Bu satırın altına, aşağıdaki gibi bir satır ekleyin:

.. code-block:: shell

	deneme ALL=(ALL) NOPASSWD: ALL

Burada deneme yerine parola sormadan sudo komutlarını çalıştırmak istediğiniz kullanıcının adını yazın.
Dosyayı kaydedin ve kapatın.

Artık belirtilen kullanıcı, parola sormadan sudo komutlarını çalıştırabilecektir. Ancak, bu işlemi yaparken dikkatli olun. Parola sormadan sudo kullanmak, güvenlik risklerine yol açabilir. Bu nedenle, yalnızca güvendiğiniz kullanıcılar için bu yapılandırmayı kullanmanız önerilir.

Bu yöntemle sudoers dosyasını düzenleyerek, belirli kullanıcıların veya kullanıcı gruplarının parola sormadan sudo komutlarını çalıştırabilmesini sağlayabilirsiniz.

Yukarıdaki yöntem yerine aşağıdaki gibi yapabiliriz.

.. code-block:: shell
	
	sudo touch /etc/sudoers.d/deneme
	sudo chmod 440 /etc/sudoers.d/deneme

/etc/sudoers.d/deneme içeriğine aşağıdaki gibi yapılandıralım.

.. code-block:: shell

	%sudo	ALL=(ALL) NOPASSWD:ALL
	deneme	ALL=(ALL) NOPASSWD:ALL


.. raw:: pdf

   PageBreak
