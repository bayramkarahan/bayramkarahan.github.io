cgroup
++++++

Cgroup, Linux çekirdeği tarafından sağlanan bir özellik olup, sistem kaynaklarını gruplar halinde yönetmemize olanak tanır. Bu, özellikle sunucu ortamlarında ve konteyner teknolojilerinde oldukça faydalıdır. Cgroup sayesinde, belirli bir grup süreç için kaynakları sınırlayabilir, izleyebilir ve yönetebilirsiniz.

Cgroup'un Temel Özellikleri
---------------------------

- **Kaynak Sınırlama:** Cgroup, belirli bir grup süreç için CPU, bellek, disk ve ağ gibi kaynakları sınırlamanıza olanak tanır. Örneğin, bir uygulamanın bellek kullanımını 512 MB ile sınırlamak istiyorsanız, cgroup kullanarak bunu kolayca yapabilirsiniz.

- **Kaynak İzleme:** Cgroup, süreçlerin kaynak kullanımını izlemek için de kullanılabilir. Bu, sistem yöneticilerinin hangi süreçlerin ne kadar kaynak kullandığını görmesine yardımcı olur.

- **Hiyerarşi:** Cgroup, hiyerarşik bir yapıya sahiptir. Yani, bir cgroup içinde başka cgroup'lar oluşturabilirsiniz. Bu, daha karmaşık kaynak yönetimi senaryoları için faydalıdır.

Cgroup Kullanımı
----------------

Cgroup kullanmaya başlamak için öncelikle sisteminizde cgroup'un etkin olduğundan emin olmalısınız. Genellikle modern Linux dağıtımlarında cgroup varsayılan olarak aktiftir. Cgroup ile çalışmak için aşağıdaki adımları izleyebilirsiniz:
1. Cgroup Oluşturma

Öncelikle, bir cgroup oluşturmalısınız. Bunun için terminalde aşağıdaki komutu kullanabilirsiniz:


.. code-block:: shell

	sudo mkdir /sys/fs/cgroup/memory/my_cgroup

Bu komut, "my_cgroup" adında bir bellek cgroup'u oluşturur.

2. Kaynak Sınırlama

Oluşturduğunuz cgroup'a bellek sınırı eklemek için şu komutu kullanabilirsiniz:


.. code-block:: shell

	echo 512M | sudo tee /sys/fs/cgroup/memory/my_cgroup/memory.limit_in_bytes

Bu komut, "my_cgroup" için bellek sınırını 512 MB olarak ayarlar.

3. Süreç Ekleme

Artık bir cgroup oluşturduğunuza göre, bu cgroup'a süreç ekleyebilirsiniz. Bunun için, eklemek istediğiniz sürecin PID'sini öğrenin ve aşağıdaki komutu kullanın:


.. code-block:: shell

	echo <PID> | sudo tee /sys/fs/cgroup/memory/my_cgroup/cgroup.procs

Burada <PID> kısmını eklemek istediğiniz sürecin PID'si ile değiştirin.

4. İzleme

Cgroup'un kaynak kullanımını izlemek için aşağıdaki komutu kullanabilirsiniz:


.. code-block:: shell

	cat /sys/fs/cgroup/memory/my_cgroup/memory.usage_in_bytes

Bu komut, "my_cgroup" içindeki süreçlerin toplam bellek kullanımını gösterir.

Cgroup'un Avantajları
---------------------

- **Kaynak Yönetimi:** Sunucu kaynaklarını daha verimli bir şekilde yönetmenizi sağlar.
- **Performans İyileştirmesi:** Süreçlerin kaynak kullanımını sınırlayarak sistemin genel performansını artırabilir.
- **Güvenlik:** Belirli süreçlerin diğer süreçlerin kaynaklarına erişimini kısıtlayarak güvenliği artırır.

Sonuç
-----

Cgroup, Linux sistemlerinde kaynak yönetimi için güçlü bir araçtır. Özellikle sunucu ve konteyner ortamlarında, kaynakları etkili bir şekilde yönetmek ve izlemek için vazgeçilmezdir. Yukarıda bahsedilen adımları takip ederek, cgroup ile kaynak yönetimi yapmaya başlayabilirsiniz. Unutmayın, her zaman sistem kaynaklarınızı izlemek ve gerektiğinde ayarlamalar yapmak önemlidir.
	
	
.. raw:: pdf

   PageBreak
