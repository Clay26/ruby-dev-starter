# We want to use version '2' of Vagrant's configuration language
Vagrant.configure("2") do |config|
  
  # Define the Ruby and Rails versions as variables
  RUBY_VERSION = "3.1.3"
  RAILS_VERSION = "7.0.4"
  
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
  
  # Provision the VM by running the necessary commands
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y build-essential git libsqlite3-dev redis ruby-dev tzdata
    sudo apt install -y rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    rbenv install #{RUBY_VERSION}
    rbenv global #{RUBY_VERSION}
    gem install rails -v #{RAILS_VERSION} --no-document
  SHELL
end
