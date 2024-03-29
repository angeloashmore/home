{ config, pkgs, ... }:

let
  # vim-scratch = pkgs.vimUtils.buildVimPlugin {
  #   name = "vim-scratch";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "duff";
  #     repo = "vim-scratch";
  #     rev = "96f2e92a187948d20c97ce705a2f863507234f99";
  #     sha256 = "02223q6gazr6hb827gc6hq8sbhjk87r232ji60rbjl3qhcim9bdg";
  #   };
  # };
  # nvim-miniyank = pkgs.vimUtils.buildVimPlugin {
  #   name = "nvim-miniyank";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "bfredl";
  #     repo = "nvim-miniyank";
  #     rev = "2a3a0f3ae535e1b93a8c17dfdac718b9a12c772b";
  #     sha256 = "0ql1jb97d3zyk33cbq96b3l8p590kdcbbnwmpn81bswi8vpa8fc8";
  #   };
  # };
  # plenary-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "plenary-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:nvim-lua/plenary.nvim";
  #     "rev" = "4b7e52044bbb84242158d977a50c4cbcd85070c7";
  #   };
  # };
  scratch-vim = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "scratch-vim-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:vim-scripts/scratch.vim";
      "rev" = "90c2bc4bfe01151aa5c71d9cb243b05bc105ae01";
    };
  };
  yanky-nvim = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "yanky-nvim-${version}";
    src = builtins.fetchGit {
      "ref" = "main";
      "url" = "git@github.com:gbprod/yanky.nvim";
      "rev" = "39bef9fe84af59499cdb88d8e8fb69f3175e1265";
    };
  };
  # indent-blankline-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "indent-blankline-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:lukas-reineke/indent-blankline.nvim";
  #     "rev" = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6";
  #   };
  # };
  # nvim-surround = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "nvim-surround-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:kylechui/nvim-surround";
  #     "rev" = "81f672ad6525b5d8cc27bc6ff84636cc12664485";
  #   };
  # };
  # comment-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "comment-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:numToStr/Comment.nvim";
  #     "rev" = "ad7ffa8ed2279f1c8a90212c7d3851f9b783a3d6";
  #   };
  # };
  # nvim-ts-context-commentstring = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "nvim-ts-context-commentstring-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:JoosepAlviste/nvim-ts-context-commentstring";
  #     "rev" = "2941f0064874b33e93d3a794a8a4e99f5f6ece56";
  #   };
  # };
  # nvim-autopairs = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "nvim-autopairs-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:windwp/nvim-autopairs";
  #     "rev" = "4fc96c8f3df89b6d23e5092d31c866c53a346347";
  #   };
  # };
  # nvim-lspconfig = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "nvim-lspconfig-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:neovim/nvim-lspconfig";
  #     "rev" = "35a731bddaf20be0a2a0492cfa489ae6130a4eb6";
  #   };
  # };
  # nvim-cmp = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "nvim-cmp-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:hrsh7th/nvim-cmp";
  #     "rev" = "3347dd3c59b6c62288d861ddb92b9ba1227257a8";
  #   };
  # };
  # cmp-nvim-lsp = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "cmp-nvim-lsp-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:hrsh7th/cmp-nvim-lsp";
  #     "rev" = "3cf38d9c957e95c397b66f91967758b31be4abe6";
  #   };
  # };
  # cmp-nvim-lua = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "cmp-nvim-lua-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:hrsh7th/cmp-nvim-lua";
  #     "rev" = "d276254e7198ab7d00f117e88e223b4bd8c02d21";
  #   };
  # };
  # luasnip = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "luasnip-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:L3MON4D3/LuaSnip";
  #     "rev" = "663d54482b11bca1ce94f56993b9f6ab485a13dc";
  #   };
  # };
  # cmp_luasnip = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "cmp_luasnip-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:saadparwaiz1/cmp_luasnip";
  #     "rev" = "a9de941bcbda508d0a45d28ae366bb3f08db2e36";
  #   };
  # };
  # cmp-path = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "cmp-path-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:hrsh7th/cmp-path";
  #     "rev" = "91ff86cd9c29299a64f968ebb45846c485725f23";
  #   };
  # };
  # null-ls-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "null-ls-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:jose-elias-alvarez/null-ls.nvim";
  #     "rev" = "643c67a296711ff40f1a4d1bec232fa20b179b90";
  #   };
  # };
  tmux-nvim = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "tmux-nvim-${version}";
    src = builtins.fetchGit {
      "ref" = "main";
      "url" = "git@github.com:aserowy/tmux.nvim";
      "rev" = "1ad660c1c28aa81fd67a56ef60f46121711ed6fb";
    };
  };
  # lualine-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "lualine-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:nvim-lualine/lualine.nvim";
  #     "rev" = "edca2b03c724f22bdc310eee1587b1523f31ec7c";
  #   };
  # };
  # schemastore-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "schemastore-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:b0o/SchemaStore.nvim";
  #     "rev" = "17d16277a214cc67710694c83c6c0c5aa1e13bb0";
  #   };
  # };
  # telescope-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "telescope-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:nvim-telescope/telescope.nvim";
  #     "rev" = "f174a0367b4fc7cb17710d867e25ea792311c418";
  #   };
  # };
  # editorconfig-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "editorconfig-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:gpanders/editorconfig.nvim";
  #     "rev" = "7d10fe6bc340fd783c0b61cf627dd235100284db";
  #   };
  # };
  # lsp_signature-nvim = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "lsp_signature-nvim-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "master";
  #     "url" = "git@github.com:ray-x/lsp_signature.nvim";
  #     "rev" = "e65a63858771db3f086c8d904ff5f80705fd962b";
  #   };
  # };
  arial-nvim = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "arial-nvim-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:stevearc/aerial.nvim";
      "rev" = "3748e87a316a68754341cdffcef44fee61dee51c";
    };
  };
  # auto-session = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "auto-session-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:rmagatti/auto-session";
  #     "rev" = "609c952a50ff1d415d79323364e934eba607fce0";
  #   };
  # };
  tree-sitter-astro = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "tree-sitter-astro-${version}";
    src = builtins.fetchGit {
      "ref" = "master";
      "url" = "git@github.com:virchau13/tree-sitter-astro.git";
      "rev" = "e924787e12e8a03194f36a113290ac11d6dc10f3";
    };
    buildPhase = ''
      runHook preBuild
      mkdir -p parser/
      ${pkgs.clang}/bin/clang++ -o parser/astro.so -I$src/src $src/src/parser.c $src/src/scanner.cc -shared  -Os -lstdc++ -fPIC
      runHook postBuild
    '';
  };
  # rose-pine = pkgs.vimUtils.buildVimPlugin rec {
  #   version = "latest";
  #   name = "rose-pine-${version}";
  #   src = builtins.fetchGit {
  #     "ref" = "main";
  #     "url" = "git@github.com:rose-pine/neovim";
  #     "rev" = "40c4fd7f5551710e388e0df85bb43d6e1627ca80";
  #   };
  # };
  oh-lucy-nvim = pkgs.vimUtils.buildVimPlugin rec {
    version = "latest";
    name = "oh-lucy-nvim-${version}";
    src = builtins.fetchGit {
      "ref" = "main";
      "url" = "git@github.com:Yazeed1s/oh-lucy.nvim";
      "rev" = "b53f8c8735ca7e788994147bfa10eb04331eaf7c";
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
    "/Users/angeloashmore/bin"
    "/Users/angeloashmore/go/bin"
    "/Users/angeloashmore/.npm-global/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    clang_12
    coursier
    gitAndTools.gh
    jq
    lazygit
    reattach-to-user-namespace
    ripgrep
    trash-cli
    watchman

    lua-language-server
    nodePackages.typescript-language-server
    nodePackages.svelte-language-server
    nodePackages.graphql-language-service-cli
    stylua
    nodePackages.eslint_d
    nodePackages.prettier
    nodePackages.vscode-langservers-extracted
    nodePackages.typescript
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

      export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
      [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
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

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = [
      arial-nvim
      oh-lucy-nvim
      scratch-vim
      tmux-nvim
      tree-sitter-astro
      yanky-nvim
      pkgs.vimPlugins.SchemaStore-nvim
      pkgs.vimPlugins.auto-session
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-nvim-lua
      pkgs.vimPlugins.cmp-path
      pkgs.vimPlugins.cmp_luasnip
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.editorconfig-nvim
      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.lsp_signature-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.null-ls-nvim
      pkgs.vimPlugins.nvim-autopairs
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-metals
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.nvim-ts-context-commentstring
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.vim-abolish
      pkgs.vimPlugins.vim-dispatch
      pkgs.vimPlugins.vim-easy-align
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-rhubarb
      pkgs.vimPlugins.vim-vinegar
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
      # {
      #   plugin = pkgs.tmuxPlugins.tmux-colors-solarized;
      #   extraConfig = "set -g @colors-solarized 'dark'";
      # }
    ];
  };
}
