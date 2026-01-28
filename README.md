# home

```bash
# clone
cd ~
git init
git remote add origin https://github.com/angeloashmore/home
git fetch
git checkout -f main

# antidote (zsh plugins)
git clone https://github.com/mattmc3/antidote ~/.config/zsh/.antidote

# mise
curl https://mise.run | sh
source ~/.config/zsh/.zshrc
mise install

# npm global packages
xargs npm i -g < ~/.npm-global-packages

# homebrew (casks only)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=~/Brewfile
```
