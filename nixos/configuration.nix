# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

    # Use the GRUB 2 boot loader.
    #boot.loader.grub.enable = true;
    #boot.loader.grub.version = 2;
    boot.loader.grub.enable = false;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false;
    boot.loader.timeout = 4;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

    networking.networkmanager.enable = true;
    networking.hostName = "asus-nixos"; # Define your hostname.
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;

    fonts.enableFontDir = true;
    fonts.enableCoreFonts = true;
    fonts.enableGhostscriptFonts = true;
    fonts.fonts = with pkgs; [
        corefonts
        inconsolata
        liberation_ttf
        dejavu_fonts
        bakoma_ttf
        gentium
        ubuntu_font_family
        terminus_font
        fira
        fira-mono
        fira-code
    ];

    # Select internationalisation properties.
    i18n = {
        consoleFont = "Fira Mono";
        consoleKeyMap = "sg-latin1";
        defaultLocale = "de_CH.UTF-8";
    };

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        # CLI Tools
        wget
        curl
        fd
        ripgrep
        zlib
        tig
        zip
        unzip
        tree
	    gitFull
        which
        vim
        gnome3.dconf
        exa

        # power management
        acpi

        # web/browsers/communication
        chromium
        firefoxWrapper

        # music/media
        mplayer
        vlc
        imagemagick
        
        # Terminals
        zsh
        fish
        alacritty
        gnome3.gnome_terminal
        
        # Haskell
        haskellPackages.intero
        haskellPackages.hlint
        haskellPackages.ghcid
        haskellPackages.pandoc
        haskellPackages.cabal2nix
        haskellPackages.stack2nix
        haskellPackages.pointfree
        haskellPackages.ShellCheck
	    haskellPackages.idris

        (haskellPackages.ghcWithPackages (self:
            [
                self.pretty-simple
            ]
            )
        )

        # Editors
        vscode
        neovim

        # development
        ncurses
        gnumake
        python3
        nixops
        disnix
        nodejs
    ];

    environment.shells = [ pkgs.zsh pkgs.fish ]; 

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.bash.enableCompletion = true;
    

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    services.redshift.enable = true;
    services.redshift.brightness.day = "0.95";
    services.redshift.brightness.night = "0.7";
    services.redshift.latitude = "47.376887";
    services.redshift.longitude = "8.541694";

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "ch,us";
    services.xserver.xkbModel = "pc105";
    services.xserver.xkbOptions = "eurosign:e";
    services.xserver.desktopManager.gnome3.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    services.xserver.libinput.enable = false;
    services.xserver.synaptics = {
	enable = true;
	tapButtons = true;
        twoFingerScroll = true;
    };
    
    services.gnome3 = {
        gnome-keyring.enable = true;
        gnome-terminal-server.enable = true;
        gpaste.enable = true;
        sushi.enable = true;
        seahorse.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    environment.variables = {
        # PATH = "Foo"
    };

    security.sudo.enable = true;
    security.sudo.wheelNeedsPassword = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.nico = {
        isNormalUser = true;
        uid = 1000;
        group = "users";
        extraGroups = [
	    "wheel"
            "networkmanager"
	];
        createHome = true;
        home = "/home/nico";
    };
 
    users.defaultUserShell = "/run/current-system/sw/bin/fish";

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "17.09"; # Did you read the comment?
}
