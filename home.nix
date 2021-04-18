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
  vim-code-dark = pkgs.vimUtils.buildVimPlugin {
    name = "vim-code-dark";
    src = pkgs.fetchFromGitHub {
      owner = "tomasiser";
      repo = "vim-code-dark";
      rev = "9a76050073754a8ccc57cc0c1c51aa4328b00097";
      sha256 = "1hsq08y68iqmwkscf4zr7lgmw3r6v97gbafj5z0g1flzvb98ly0s";
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
  indent-blankline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "indent-blankline-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "6c7ac766ba164af0111457fdb248e7dc96eae7c7";
      sha256 = "109j1d3q3bgy0zjd8vjj4mk36gwj40qp4av3z4rymavmqbpkwprr";
    };
  };
  tree-sitter-ts = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "tree-sitter-ts-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:tree-sitter/tree-sitter-typescript";
      "rev" = "6231a793ef596c4e8162cf569291a28f2169223d";
    };
    buildPhase = ''
      runHook preBuild
      mkdir -p parser/
      $CC -o parser/typescript.so -I$src/typescript/src $src/typescript/src/parser.c $src/typescript/src/scanner.c -shared  -Os -lstdc++ -fPIC
      runHook postBuild
    '';
  };
  tree-sitter-tsx = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "tree-sitter-tsx-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:tree-sitter/tree-sitter-typescript";
      "rev" = "6231a793ef596c4e8162cf569291a28f2169223d";
    };
    buildPhase = ''
      runHook preBuild
      mkdir -p parser/
      $CC -o parser/tsx.so -I$src/tsx/src $src/tsx/src/parser.c $src/tsx/src/scanner.c -shared  -Os -lstdc++ -fPIC
      runHook postBuild
    '';
  };
  tree-sitter-go = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "tree-sitter-go-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:tree-sitter/tree-sitter-go.git";
      "rev" = "2a83dfdd759a632651f852aa4dc0af2525fae5cd";
    };
    buildPhase = ''
      runHook preBuild
      mkdir -p parser/
      $CC -o parser/go.so -I$src/src $src/src/parser.c -shared  -Os -lstdc++ -fPIC
      runHook postBuild
    '';
  };
  tree-sitter-php = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    version = "latest";
    name = "tree-sitter-php-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:tree-sitter/tree-sitter-php";
      "rev" = "0d63eaf94e8d6c0694551b016c802787e61b3fb2";
    };
    buildPhase = ''
      runHook preBuild
      mkdir -p parser/
      ${pkgs.clang}/bin/clang++ -o parser/php.so -I$src/src $src/src/parser.c $src/src/scanner.cc -shared  -Os -lstdc++ -fPIC
      runHook postBuild
    '';
  };

in {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

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
    "/Users/angeloashmore/go/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    fzf
    gitAndTools.gh
    jetbrains-mono
    jq
    pwgen
    reattach-to-user-namespace
    trash-cli
    tree-sitter
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
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
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = [
      indent-blankline-nvim
      nvim-miniyank
      pkgs.vimPlugins.auto-pairs
      pkgs.vimPlugins.coc-css
      pkgs.vimPlugins.coc-eslint
      pkgs.vimPlugins.coc-jest
      pkgs.vimPlugins.coc-json
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-prettier
      pkgs.vimPlugins.coc-snippets
      pkgs.vimPlugins.coc-tsserver
      pkgs.vimPlugins.coc-vimlsp
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.lightline-vim
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
      tree-sitter-go
      tree-sitter-php
      tree-sitter-ts
      tree-sitter-tsx
      vim-code-dark
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
