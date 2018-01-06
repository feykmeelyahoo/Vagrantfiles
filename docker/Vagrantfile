VAGRANTFILE_API_VERSION = "2"

$minion_count=0

$ansible_memory=1024
$ansible_cpus=1

$master_memory=4096
$master_cpus=3

$minion_memory=2048
$minion_cpus=1

def workerIP(num)
  return "172.17.8.#{num+101}"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  ip = "172.17.8.100"
  config.ssh.insert_key = false
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.define "master" do |master|
    masterip = "172.17.8.101"
    master.vm.network :private_network, :ip => "#{masterip}"
    master.vm.hostname = "master"
    master.vm.provider "virtualbox" do |v|
      v.memory = $master_memory
      v.cpus = $master_cpus
    end
    master.vm.provision :shell, :inline => "sed 's/127.0.0.1.*/#{ip} master/' -i /etc/hosts"
    master.vm.provision :shell, :inline => "sed   's/^name.*$/nameserver 10.151.0.3/' -i /etc/resolv.conf"
    master.vm.provision :shell, :path => "bootstrap.sh"
  end
  (1..$minion_count).each do |i|
    config.vm.define vm_name = "minion-%d" % i do |node|
      node.vm.network :private_network, :ip => "#{workerIP(i)}"
      node.vm.hostname = vm_name
      node.vm.provider "virtualbox" do |v|
        v.memory = $minion_memory
        v.cpus = $minion_cpus
      end
      node.vm.provision :shell, :inline => "sed 's/127.0.0.1.*minion-#{i}/#{workerIP(i)} minion-#{i}/' -i /etc/hosts"
    end
  end
end
