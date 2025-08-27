Arquitetura do Kubernetes:







Tem duas partes, ( 1 e 2 ) -> Control Plane e o Data Plane

Control Plane é oq faz a parte crítica do cluster ( parte de gerenciamento )
Estão inclusos:

-API Server = Um pod ( conteiner ) que poderemos escutar as requisições de API, ou seja, sempre que quisermos conversar com o cluster, passaremos primeiro por ele
-ETCD = Componente mais critico do cluster, é um banco de dados de chave/valor do kubernets; sempre que criarmos um POD/deployment pela API, ficará salvo no ETCD
-Scheduler = Também será um POD, e o scheduler seria uma organização de decissões, por exemplo, ver containers que ainda não possuem nodes e encontrar um para ele
-Controller Manager = Uma aplicação que irá ficar lendo alguma regra e quando algo acontecer ele entrará em ação e executar a regra
-Cloud Controller = Basicamente tudo que o kubernets precisa para interagir com a API das Clouds


---------------------------------------------------------------------
DataPlane é como vamos usar nossas aplicações e roda-las

Exemplo:

Node_1=
kubelet
kube-proxy

Node_2=
kubelet
kube-proxy

Os componentes do DataPLane são:

Kubelet = agente do cluster que estará rodando dentro da VM como serviço que falará diretamente com o API Server do Control Plane, é ele que faz os healthy check para o container, assim garantindo a saude do container
Kube-Proxy =  rodará como um pod, e ele gerenciará as regras de iptables para garantir que conseguemos usar os services do kubernets 