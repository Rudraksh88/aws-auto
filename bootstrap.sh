#!/bin/bash

# Function to run command and print its output
run_command() {
    echo "Running: $1"
    eval "$1"
    echo "Command finished with exit code $?"
    echo "----------------------------------------"
}

echo "Starting EC2 instance setup..."

echo "Updating and upgrading the system..."
run_command "sudo apt update && sudo apt upgrade -y"

echo "Installing zsh and other required packages..."
run_command "sudo apt install -y zsh fzf python3-full build-essential python3-dev"

echo "Changing default shell to zsh..."
run_command "sudo chsh -s $(which zsh) $(whoami)"

echo "Installing Oh My Zsh..."
run_command 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

echo "Installing zsh plugins..."
run_command "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
run_command "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

echo "Installing Powerlevel10k theme..."
run_command "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
run_command "sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/' ~/.zshrc"

echo "Updating plugins in .zshrc..."
run_command "sed -i '/^plugins=/ c\plugins=(\n\tgit\n\tfzf\n\ttmux\n\tthemes\n\tsudo\n\tpython\n\tzsh-autosuggestions\n\tzsh-syntax-highlighting\n)' ~/.zshrc"

echo "Downloading p10k configuration file..."
run_command "curl -o ~/.p10k.zsh https://raw.githubusercontent.com/Rudraksh88/aws-auto/refs/heads/master/.p10k.zsh"

echo "Adding Powerlevel10k configuration sourcing to .zshrc..."
run_command "echo '\n# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.\n[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc"

echo "Sourcing the updated .zshrc..."
run_command "source ~/.zshrc"

echo "Setup complete! Please log out and log back in for all changes to take effect."
