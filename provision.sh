#!/bin/bash

set -e

# Define your Ruby and Rails versions
RUBY_VERSION="3.1.3"
RAILS_VERSION="7.1.3"

# Function to wait for a command to succeed
wait_for_success() {
  local command="$1"
  until $command; do
    echo "Waiting for $command to succeed..."
    sleep 2
  done
}

# Update package list
echo "Updating package list..."
wait_for_success "sudo apt-get update"

# Install required packages
echo "Installing required packages..."
wait_for_success "sudo apt-get install -y build-essential git libsqlite3-dev redis ruby-dev tzdata"

# Install rbenv
echo "Installing rbenv..."
wait_for_success "sudo apt-get install -y rbenv"

# Add rbenv to bashrc
if ! grep -q 'export PATH="$HOME/.rbenv/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
fi

if ! grep -q 'eval "$(rbenv init -)"' ~/.bashrc; then
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
fi

# Source the updated bashrc
echo "Sourcing ~/.bashrc..."
source ~/.bashrc

# Clone ruby-build plugin
echo "Cloning ruby-build plugin..."
wait_for_success "git clone https://github.com/rbenv/ruby-build.git $(rbenv root)/plugins/ruby-build"

# Install specified Ruby version
echo "Installing Ruby $RUBY_VERSION..."
wait_for_success "rbenv install $RUBY_VERSION"

# Set the installed Ruby version as global
echo "Setting Ruby $RUBY_VERSION as global version..."
rbenv global $RUBY_VERSION

# Install Rails gem
echo "Installing Rails $RAILS_VERSION..."
wait_for_success "gem install rails -v $RAILS_VERSION --no-document"

# Install Node.js and Yarn
echo "Installing Node.js and Yarn..."
wait_for_success "curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -"
wait_for_success "sudo apt-get install -y nodejs"
wait_for_success "sudo npm install -g yarn"

# Install Lua
echo "Installing Lua..."
wait_for_success "sudo apt-get install -y lua5.4"

# Add Neovim PPA and install the latest version
echo "Adding Neovim PPA and installing the latest version..."
wait_for_success "sudo add-apt-repository -y ppa:neovim-ppa/stable"
wait_for_success "sudo apt-get update"
wait_for_success "sudo apt-get install -y neovim"

echo "Provisioning complete."
