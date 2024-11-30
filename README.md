# diy.nvim

## Introduction
This is my own Neovim configuration, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

Provide modular configuration and some customized plugins, works ok on Linux an Mac.

### Install Neovim

`diy.nvim` targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - Set `vim.g.have_nerd_font` in `init.lua` to true if have it.

### Install diy.nvim
```sh
git clone https://github.com/TangSiyang2001/diy.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

Could use alias to start if config directory name is not nvim.
```
alias nvim-alias='NVIM_APPNAME="alias-config-dir" nvim'
```
Then start with nvim-alias.

### More infomation
Refer to [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

