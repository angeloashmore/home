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
  nvim-miniyank = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-miniyank";
    src = pkgs.fetchFromGitHub {
      owner = "bfredl";
      repo = "nvim-miniyank";
      rev = "2a3a0f3ae535e1b93a8c17dfdac718b9a12c772b";
      sha256 = "0ql1jb97d3zyk33cbq96b3l8p590kdcbbnwmpn81bswi8vpa8fc8";
    };
  };
  indent-blankline-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "indent-blankline-nvim-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:lukas-reineke/indent-blankline.nvim";
      "rev" = "045d9582094b27f5ae04d8b635c6da8e97e53f1d";
    };
  };
  rose-pine = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "rose-pine-${version}";
    src = builtins.fetchGit {
      "ref" = "main";
      "url" = "git@github.com:rose-pine/neovim";
      "rev" = "40c4fd7f5551710e388e0df85bb43d6e1627ca80";
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
  home.stateVersion = "21.03";

  # Extra directories to add to PATH.
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/Users/angeloashmore/go/bin"
    "/Users/angeloashmore/.npm-global/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    clang_12
    fzf
    gitAndTools.gh
    jq
    reattach-to-user-namespace
    trash-cli
    watchman
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
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
      export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
       --color=fg:#e0def4,bg:#1f1d2e,hl:#6e6a86
       --color=fg+:#908caa,bg+:#191724,hl+:#908caa
       --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
       --color=marker:#ebbcba,spinner:#eb6f92,header:#ebbcba"
    '';
    initExtra = ''
      if [ -e "$HOME/.config/nixpkgs/secrets.sh" ]; then
        source "$HOME/.config/nixpkgs/secrets.sh"
      fi
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
      indent-blankline-nvim
      nvim-miniyank
      pkgs.vimPlugins.auto-pairs
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.editorconfig-vim
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.lightline-vim
      pkgs.vimPlugins.lush-nvim
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.tmux-navigator
      pkgs.vimPlugins.vim-abolish
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.vim-dispatch
      pkgs.vimPlugins.vim-easy-align
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.vim-rhubarb
      pkgs.vimPlugins.vim-sensible
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.vim-vinegar
      pkgs.vimPlugins.vista-vim
      rose-pine
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
