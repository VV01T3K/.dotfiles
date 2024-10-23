# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # man-pages
    # man-pages-posix
    # nh # nix helper
    # nix-output-monitor # monitor nix builds
    # nvd # nix version manager (diffing)
    vim
    neovim
    wget
    xsettingsd # for partial scaling
    xorg.xrdb # for partial scaling
    jq
    fastfetch # neofetch
    tldr # man
    eza # ls
    ripgrep # grep
    pigz # gzip
    bat # cat
    fzf # fuzzy find
    zoxide # cd
    fd # find
    dust # du
    duf # df
    procs # ps
    # plasma-browser-integration #idk
    # starship
    # powertop # power managment
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true; maybe better than default bluetooth from kde ??
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Fix for windows time slipping
  # services.geoclue2.enable = true;
  # services.localtimed.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = false; #default true
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  programs.dconf.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Presumably better gpu drivers
  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      intel-vaapi-driver
      intel-media-driver

      vpl-gpu-rt # or intel-media-sdk for QSV
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh = {
  #   enable = true;
  #   ports = [ 22 ];
  #   settings = {
  #     PasswordAuthentication = true;
  #     # AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
  #     # UseDns = true;
  #     # X11Forwarding = false;
  #     # PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  #   };
  # };

  programs.ssh.startAgent = true; # !! fix for vscode (and etc) clone to container (ssh forwarding)

  # fonts.packages = with pkgs; [
  #   (nerdfonts.override { fonts = [ "FiraCode" "Hack" "GeistMono" "JetBrainsMono" ]; })
  # ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep-since 7d --keep 3";
    # flake = "/home/wojtek/.dotfiles";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "/home/wojtek/.dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      # "--commit-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.extraOptions = ''
    warn-dirty = false
  '';

}
