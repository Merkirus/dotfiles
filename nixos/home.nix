{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    ./nixvim
    ./wayland
  ];

  home.username = "frafau";
  home.homeDirectory = "/home/frafau";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  home.packages = with pkgs; [
    calibre
    cava
    chromium
    eza
    firefox
    fzf
    grim
    jq
    libnotify
    libreoffice
    ncspot
    neofetch
    neovide
    nsxiv
    obsidian
    obs-studio
    pavucontrol
    poppler
    rclone
    ripgrep
    rofi-wayland
    slurp
    swappy
    swww
    vlc
    wl-clipboard
    xfce.thunar
    zathura
    _7zz
  ];

  xdg.mimeApps.defaultApplications = {
    enable = true;
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "nsxiv.desktop" ];
    "video/*" = [ "vlc.desktop" ];
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     #pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config.common.default = "*";
  # };

  home.file = {
  };

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-storm;

  programs.lf.enable = true;

  programs.tmux.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
    shellAliases = {
      ll = "eza -l --git --header";
    };
  };

  programs.git = {
    enable = true;
    userName = "Rafał Mielniczuk";
    userEmail = "rmielniczuk001@gmail.com";
  };

  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; });
      name = "UbuntuMono Nerd Font";
      size = 18;
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = "0.2";
    };
  };

  home.pointerCursor = {
    package = pkgs.comixcursors.Opaque_Black;
    name = "ComixCursors-Opaque-Black";
  };

  gtk = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; });
      name = "UbuntuMono Nerd Font";
      size = 11;
    };
    cursorTheme = {
      package = pkgs.comixcursors.Opaque_Black;
      name = "ComixCursors-Opaque-Black";
    };
    theme = {
      package = pkgs.tokyo-night-gtk;
      name = "Tokyonight-Storm-BL";
    };
    iconTheme = {
      package = pkgs.tokyo-night-gtk;
      name = "Tokyonight-Moon";
    };
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
