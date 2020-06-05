{ config, lib, pkgs, ... }:

let
  # A colorfull ls package
  ls-colors = pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
  '';

  # Haskell IDE engine
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  home.packages = with pkgs; [
    # _1password
    # NOTE: GUI apps don't show up in spotlight search
    alacritty
    bat
    clojure
    clojure-lsp
    docker
    docker-compose
    elmPackages.elm-language-server
    git
    (all-hies.selection { selector = p: { inherit (p) ghc865; }; })
    fzf
    # google-chrome
    jump
    # NOTE: custom
    ls-colors
    ngrok
    ripgrep
    rnix-lsp
    nodejs
    # postman
    python3
    pipenv
    python3Packages.pip
    python3Packages.black
    python3Packages.ipython
    python3Packages.pynvim
    python3Packages.isort
    python3Packages.jedi
    python3Packages.rope
    python3Packages.mypy
    python3Packages.flake8
    # python3Packages.flake8-annotations
    # NOTE: Need to add support for mac
    # spaceship-prompt
    tmux
    universal-ctags
    zsh-syntax-highlighting
    ytop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sherubthakur";
  home.homeDirectory = "/Users/sherubthakur";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";


  programs.alacritty = {
    enable = true;
    settings = (import ./alacrity-config.nix);
  };

  programs.bat = {
    enable = true;
    config.theme = "OneHalfDark";
  };

  programs.git = {
    enable = true;
    userName = "Sherub Thakur";
    userEmail = "sherub.thakur@gmail.com";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Appearance
      vim-airline
      vim-one
      vim-devicons

      # Navigation
      vim-tmux-navigator
      vim-sneak
      fzf-vim

      # Programming
      vim-elm-syntax
      # markdown-preview
      vim-which-key
      # python-syntax
      vim-haskellConcealPlus
      vim-nix
      coc-nvim
      # coc-actions
      coc-eslint
      # coc-explorer
      coc-go
      coc-json
      # coc-markdownlint
      coc-pairs
      coc-prettier
      coc-python
      coc-snippets
      coc-spell-checker
      coc-tsserver
      coc-yaml

      # Text objects
      tcomment_vim
      vim-surround
      vim-repeat
      vim-indent-object

      # vim-floaterm
      vim-fugitive
      vim-gitgutter
    ];

    extraConfig = ''
      ${builtins.readFile ./nvim/sane_defaults.vim}
      ${builtins.readFile ./nvim/airline.vim}
      ${builtins.readFile ./nvim/navigation.vim}
      ${builtins.readFile ./nvim/theme.vim}
      ${builtins.readFile ./nvim/coc.vim}
      ${builtins.readFile ./nvim/which_key.vim}
    '';

  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    shellAliases = (import ./zsh_aliases.nix);
    history.extended = true;
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
    ];
    oh-my-zsh = {
    };
    initExtraBeforeCompInit = ''
      ${builtins.readFile ./zsh_functions.zsh}
      ${builtins.readFile ./zsh_secrets.zsh}

      bindkey -M vicmd 'k' history-beginning-search-backward
      bindkey -M vicmd 'j' history-beginning-search-forward

      eval "$(jump shell)"
      alias ls="ls --color=auto -F"
    '';
    loginExtra = ''
      ${builtins.readFile ./zsh_prompt.zsh}
    '';
    sessionVariables = rec {
      KEYTIMEOUT=1;
      DOTFILES="/Users/sherubthakur/.dotfiles";

      PATH=":$HOME/.local/bin:/Users/sherubthakur/.nix-profile/bin:/Users/sherubthakur/Library/Python/3.7/bin:$PATH";

      # Path to your oh-my-zsh installation.;
      ZSH="/Users/sherubthakur/.oh-my-zsh";
      NVIM_TUI_ENABLE_TRUE_COLOR=1;
      EDITOR="nvim";
      LC_ALL="en_US.UTF-8";
      LANG="en_US.UTF-8";

      SSL_CERT_FILE=~/.nix-profile/etc/ssl/certs/ca-bundle.crt;
      NIX_PATH="$HOME/.nix-defexpr/channels:nixpkgs=https://github.com/NixOS/nixpkgs/archive/release-19.03.tar.gz";
    };
  };

}
