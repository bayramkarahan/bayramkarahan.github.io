z Kitap Parçalama
+++++++++++++++++

binwalk, bir dosyanın içeriğini analiz etmek ve içinde gizli olan verileri bulmak için kullanılan bir Linux aracıdır. Bu araç, dosyanın içindeki farklı dosya türlerini tanımlamak ve çıkarmak için imza tabanlı bir tarama yapar.

binwalk'ı kullanmak için aşağıdaki adımları izleyebilirsiniz:

    İlk olarak, binwalk'ı sisteminize yüklemeniz gerekmektedir. Bunun için aşağıdaki komutu kullanabilirsiniz:

.. code-block:: shell
	
	sudo apt install binwalk
	
binwalk ile analiz etmek istediğiniz dosyayı belirtin. Örneğin, aşağıdaki komutu kullanarak "ornek.dosya" adlı bir dosyayı analiz edebilirsiniz:

.. code-block:: shell
	
	binwalk ornek.dosya

binwalk, dosyanın içindeki farklı dosya türlerini ve verileri taramak için imza tabanlı bir analiz yapacaktır. Sonuçları ayrıntılı bir şekilde görüntülemek için -e veya --extract parametresini kullanabilirsiniz:

.. code-block:: shell
	
	binwalk -e ornek.dosya

binwalk, dosyanın içindeki herhangi bir gizli veriyi veya dosyayı çıkarmak için -D veya --dd parametresini kullanabilirsiniz:

.. code-block:: shell
	
	binwalk -D ornek.dosya

binwalk, dosyanın içindeki gizli verileri bulmak ve analiz etmek için güçlü bir araçtır. Yukarıdaki adımları izleyerek binwalk'ı kullanabilir ve dosyalarınızı analiz edebilirsiniz.

.. raw:: pdf

   PageBreak
