# KubeSpray ile Ubuntu K8S Kurulumu

ansible 4 k8s ubuntu node'u ayaklandır

## tüm nodelarda ssh olmalı
## ansible makinesinde
>sudo apt install python3-pip
>sudo pip3 install --upgrade pip

>cat /etc/ssl/certs/PCAcert.pem >> /home/vagrant/.local/lib/python3.5/site-packages/pip/_vendor/certifi/cacert.pem 
>sudo pip install -r requirements.txt
>sudo vi /etc/fstab # comment out swap
>ssh-keygen -t rsa
>ssh-copy-id vagrant@172.17.8.201 - 4'e kadar
>sudo su -
>cat /etc/ssl/certs/PCAcert.pem >> /usr/local/lib/python3.5/dist-packages/pip/_vendor/certifi/cacert.pem

### **Set Locale**
>- export LC_ALL="en_US.UTF-8"
>- export LC_CTYPE="en_US.UTF-8"
>- sudo dpkg-reconfigure locales
### Add the following section in ansible.cfg file
> -remote_user=vagrant
> -cp -rfp inventory/sample inventory/prod
> -CONFIG_FILE=inventory/prod/hosts.ini python3 contrib/inventory_builder/inventory.py 172.17.8.201 172.17.8.202 172.17.8.203 172.17.8.204
<!-- ### Change the value of the variable ‘boostrap_os’ from ‘none ’to ‘ubuntu’ in the file all.yml. -->
>- vim inventory/mycluster/group_vars/all.yml
>- sudo ufw status
>- sudo ufw disable
>- ansible-playbook -b -v -i inventory/prod/hosts.ini cluster.yml

### hosts.ini sampple generated
> Buradaki node isimlendirmelerini istediğin gibi değiştir

[all]
node1 	 ansible_host=172.17.8.201 ip=172.17.8.201
node2 	 ansible_host=172.17.8.202 ip=172.17.8.202
node3 	 ansible_host=172.17.8.203 ip=172.17.8.203
node4 	 ansible_host=172.17.8.204 ip=172.17.8.204

[kube-master]
node1 	 
node2 	 

[kube-node]
node2 	 
node3 	 
node4 	 

[etcd]
node1 	 
node2 	 
node3 	 

[k8s-cluster:children]
kube-node 	 
kube-master 	 

[calico-rr]

[vault]
node1 	 
node2 	 
node3 	 

