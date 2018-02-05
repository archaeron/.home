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
    boot.loader.gummiboot.enable = true;
    boot.loader.gummiboot.timeout = 2;
    # boot.loader.grub.efiSupport = true;
    # boot.loader.grub.efiInstallAsRemovable = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

    # networking.hostName = "nixos"; # Define your hostname.
    networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
        fira-code
    ];

    # Select internationalisation properties.
    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "de";
        defaultLocale = "en_US.UTF-8";
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


        # power management
        acpi

        # web/browsers/communication
        chromium
        firefoxWrapper
        wpa_supplicant_gui

        # music/media
        mplayer
        vlc
        imagemagick
        
        # Terminals
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
        haskellPackages.Shellcheck

        (haskellPackages.ghcWithPackages (self:
            [
                self.pretty-simple
            ]
            )
        )

        # Editors
        vscode
        vim

        # development
        ncurses
        gnumake
        python3
        nixops
        disnix
        nodejs
        idris
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.bash.enableCompletion = true;
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    services.redshift.enable = true;
    services.redshift.brightness.day = "0.95";
    services.redshift.brightness.night = "0.7";
    services.redshift.latitude = "47.376887";
    services.redshift.longitude = "8.541694";

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "us";
    services.xserver.xkbModel = "pc105";
    services.xserver.xkbOptions = "eurosign:e";
    services.xserver.desktopManager.gnome3.enable = true;

    nixpkgs.config.allowUnfree = true;
    # Enable touchpad support.
    # services.xserver.libinput.enable = true;

    environment.variables = {
        # PATH = "Foo"
    }

    security.sudo.enable = true;
    security.sudo.wheelNeedsPassword = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.nico = {
        isNormalUser = true;
        uid = 1000;
        group = "users";
        extraGroups = [ "wheel" "networkmanager" ];
        createHome = true;
        home = "/home/nico";
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "17.09"; # Did you read the comment?
}
