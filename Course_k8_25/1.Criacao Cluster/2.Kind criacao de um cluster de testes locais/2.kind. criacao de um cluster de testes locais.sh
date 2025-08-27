dOCUMENTAÇÃO DO KUBERNETS
kubernetes.io/docs/home 

Em Set up a k8s Cluster
Clicar em Learning Environment 

Comandos=
kubectl: comando para interagirmos com comandos no cluster
kind: rodar localmente o kubernetes, neessita de ja ter o docker instalado e configurado
minikube: rodar localmente o kubernets tbm, rodando um single-node cluster
kubeadm: cria um cluster um pouco mais localmente, mas ainda nada de produção

-------------------------------------------------------------------------------------------------------------


Utilizando o Kind.

No terminal=
cd /tmp
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
ls -l k*
sudo chmod +x kind
ls -l kind
which kind
sudo mv -f kind /usr/local/bin/kind
kind version

( Nessa aula, foi disponibilizado arquivos yaml para testar o comando kind)

Dentro do diretório com o arquivo disponibilizado=
kind --help
kind create --help
kind create cluster --help
kind create cluster --config config.yaml --name nome-cluster --kubeconfig config     ( --config é o path do arquivo de configuração, --name é o nome do cluster e o --kubeconfig é onde vai criar o kubeconfig)
docker ps            ( veremos os 3 containers que o kind criou )
ls                       ( veremos o arquivo config que criamos pelo --kubeconfig)
kubectl get pod -A --kubeconfig config                 ( mostra todos os pods que estão sendo rodados no kind)