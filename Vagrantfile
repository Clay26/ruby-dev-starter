# We want to use version '2' of Vagrant's configuration language
Vagrant.configure("2") do |config|
  
  # This is the operating system to use, in this case Ubuntu Linux
  config.vm.box = "ubuntu/jammy64"
  
  # This is configuration specifically for the virtual machine, and this gives it 4G of memory
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end
  
  # When Rails runs on port 3000 inside your virtual machine, this allows you to access it from a browser on your machine by going to port 3000 on your machine.
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  
  # This will mount your current directory on your computer to the directory /files_on_your_computer inside the virtual machine
  config.vm.synced_folder ".", "/files_on_your_computer"
end
