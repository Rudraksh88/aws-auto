#!/bin/bash

echo "Starting EC2 instance setup..."

echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

echo "Installing zsh and other required packages..."
sudo apt install -y zsh fzf python3-full nodejs npm build-essential python3-dev libpoppler-cpp-dev

echo "Changing default shell to zsh..."
sudo chsh -s $(which zsh) $(whoami)

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

echo "Downloading p10k configuration file..."
curl -o ~/.p10k.zsh https://raw.githubusercontent.com/username/repo/main/.p10k.zsh

echo "Updating plugins in .zshrc..."
sed -i '/^plugins=/ c\plugins=(\n\tgit\n\tfzf\n\ttmux\n\tthemes\n\tsudo\n\tpython\n\tzsh-autosuggestions\n\tzsh-syntax-highlighting\n)' ~/.zshrc

echo "Sourcing the updated .zshrc..."
source ~/.zshrc

echo "Setup complete! Please log out and log back in for all changes to take effect."