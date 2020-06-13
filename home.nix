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

  # Tmux onedark theme
  github-tmux-onedark-src = pkgs.fetchFromGitHub {
    owner = "odedlaz";
    repo = "tmux-onedark-theme";
    rev = "3607ef889a47dd3b4b31f66cda7f36da6f81b85c";
    sha256 = "19jljshwp2p83b634cd1mw69091x42jj0dg40ipw61qy6642h2m5";
  };
in
{
  home.packages = with pkgs; [
    # _1password # NOTE: GUI apps don't show up in spotlight search
    alacritty # NOTE: GUI apps don't show up in spotlight search
    tmux
    awscli
    bat
    git
    fzf
    # google-chrome
    jump
    ls-colors # NOTE: custom
    ngrok
    ripgrep
    # postman
    # spaceship-prompt # NOTE: Need to add support for mac
    universal-ctags
    zsh-syntax-highlighting
    ytop

    # Docker
    docker
    docker-compose

    # Programming

    # Clojure
    clojure
    clojure-lsp

    # Elm
    elmPackages.elm-language-server

    # Haskell
    ghc
    (all-hies.selection { selector = p: { inherit (p) ghc865; }; })
    haskellPackages.cabal-install
    haskellPackages.stack

    # JavaScript
    nodejs

    # Nix
    rnix-lsp

    # python
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
      vim-devicons
      awesome-vim-colorschemes
      vim-table-mode

      # Navigation
      vim-tmux-navigator
      vim-sneak
      fzf-vim

      # Programming
      # markdown-preview
      vim-which-key
      vim-haskellConcealPlus
      vim-polyglot

      coc-nvim
      # coc-actions
      coc-eslint
      # coc-explorer
      coc-go
      coc-json
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

  programs.tmux = {
    terminal = "xterm-256color";
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    secureSocket = false;
    shortcut = "a";
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 30000;
    extraConfig = ''
      # Default termtype. If the rcfile sets $TERM, that overrides this value.
      set -g terminal-overrides ',xterm-256color:Tc'

      # Create splits and vertical splits
      bind-key v split-window -h -p 50 -c "#{pane_current_path}"
      bind-key s split-window -p 50 -c "#{pane_current_path}"

      # Also use mouse
      setw -g mouse on

      # Hack to add onedark theme
      run-shell ${github-tmux-onedark-src}/tmux-onedark-theme.tmux
    '';

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    shellAliases = (import ./zsh/aliases.nix);
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
      ${builtins.readFile ./zsh/session_variables.zsh}
      ${builtins.readFile ./zsh/functions.zsh}
      ${builtins.readFile ./zsh/secrets.zsh}

      bindkey -M vicmd 'k' history-beginning-search-backward
      bindkey -M vicmd 'j' history-beginning-search-forward

      eval "$(jump shell)"
      alias ls="ls --color=auto -F"

      ${builtins.readFile ./zsh/prompt.zsh}
    '';
  };

}
