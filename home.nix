{ config, pkgs, ... }:

let
  vim-scratch = pkgs.vimUtils.buildVimPlugin {
    name = "vim-scratch";
    src = pkgs.fetchFromGitHub {
      owner = "duff";
      repo = "vim-scratch";
      rev = "96f2e92a187948d20c97ce705a2f863507234f99";
      sha256 = "02223q6gazr6hb827gc6hq8sbhjk87r232ji60rbjl3qhcim9bdg";
    };
  };
  space-vim-theme = pkgs.vimUtils.buildVimPlugin {
    name = "space-vim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "liuchengxu";
      repo = "space-vim-theme";
      rev = "4790dbba31f678f75af4f4c7a1465008542bd979";
      sha256 = "1nv099x5qq8mal9dwjj29dk357mzhn4vb9wljhglra9imammrz43";
    };
  };
  nvim-miniyank = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-miniyank";
    src = pkgs.fetchFromGitHub {
      owner = "bfredl";
      repo = "nvim-miniyank";
      rev = "2a3a0f3ae535e1b93a8c17dfdac718b9a12c772b";
      sha256 = "0ql1jb97d3zyk33cbq96b3l8p590kdcbbnwmpn81bswi8vpa8fc8";
    };
  };

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "angeloashmore";
  home.homeDirectory = "/Users/angeloashmore";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    fzf
    gitAndTools.hub
    jetbrains-mono
    pwgen
    reattach-to-user-namespace
    trash-cli
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      cask = "/usr/local/bin/brew cask";
      brew-bundle = "/usr/local/bin/brew bundle";
      docker = "/usr/local/bin/docker";
      docker-compose = "/usr/local/bin/docker-compose";
      docker-credential-desktop = "/usr/local/bin/docker-credential-desktop";
      docker-credential-osxkeychain = "/usr/local/bin/docker-credential-desktop";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "docker"
        "docker-compose"
      ];
    };
    plugins = [
      {
        name = "lean-theme";
        file = "lean.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "miekg";
          repo = "lean";
          rev = "7b723d4df0bd902da3b43fcb9f9bf9f0795e29d9";
          sha256 = "1yq7k0v557jsw36q0pbc3yr8ncj9nr9l88s0kh7zrc1ls4ik54dq";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "4cf464f843902b6e1e2778b85b70f4c098789b6f";
          sha256 = "0s197576djz1ysk0s5zlmw4v657v0f598mkmqzk32wgs4yvfqabx";
        };
      }
    ];
    envExtra = ''
      export FZF_DEFAULT_OPTS='
       --color=fg:#b2b2b2,bg:#292b2e,hl:#4f97d7
       --color=fg+:#e5e5e5,bg+:#444155,hl+:#bc6ec5
       --color=info:#2d9574,prompt:#b2b2b2,pointer:#bc6ec5
       --color=marker:#B1951D,spinner:#43505c,header:#43505c
      '
    '';
    initExtraBeforeCompInit = ''
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
    '';
  };

  programs.git = {
    enable = true;
    userName = "Angelo Ashmore";
    userEmail = "angeloashmore@users.noreply.github.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "simple";
      };
    };
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = [
      pkgs.vimPlugins.auto-pairs
      pkgs.vimPlugins.coc-css
      pkgs.vimPlugins.coc-eslint
      pkgs.vimPlugins.coc-jest
      pkgs.vimPlugins.coc-json
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-prettier
      pkgs.vimPlugins.coc-tsserver
      pkgs.vimPlugins.coc-vimlsp
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.lightline-vim
      pkgs.vimPlugins.tmux-navigator
      pkgs.vimPlugins.vim-abolish
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.vim-easy-align
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.vim-rhubarb
      pkgs.vimPlugins.vim-sensible
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-vinegar
      nvim-miniyank
      space-vim-theme
      vim-scratch
    ];
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ./tmux.conf;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      {
        plugin = pkgs.tmuxPlugins.tmux-colors-solarized;
        extraConfig = "set -g @colors-solarized 'dark'";
      }
    ];
  };
}
