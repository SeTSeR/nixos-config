{
  nixpkgs,
  config,
  lib,
  pkgs,
  ...
}:

let
  sshdTmpDirectory = "${config.user.home}/.sshd-tmp";
  sshdDirectory = "${config.user.home}/.sshd";
  port = 8022;
  bash-profile = pkgs.writeText "bash_profile" "source ~/.bashrc";
  bash-logout = pkgs.writeText "bash_logout" ''
    pkill ssh-agent
  '';
  linkFile = from: to: ''
    $VERBOSE_ECHO Writing ${to}...
    $DRY_RUN_CMD ln -fs ${from} ${to}
  '';
  bashrc = pkgs.writeText "bashrc" (
    import ./files/bashrc.nix {
      bash-completion = pkgs.bash-completion;
      openssh = pkgs.openssh;
    }
  );
  ssh-config = ./files/ssh-config;
  sshd-start = pkgs.writeScriptBin "sshd-start" ''
    #!${pkgs.runtimeShell}

    echo "Starting sshd on port ${toString port}"
    ${pkgs.openssh}/bin/sshd -f "${sshdDirectory}/config"
  '';
in
{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    vim # or some other editor, e.g. nano or neovim

    # Some common stuff that people expect to have
    procps
    killall
    diffutils
    findutils
    util-linux
    tzdata
    hostname
    man
    gawk
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
    openssh
    mosh
    git
    rclone
    bash-completion
    sshd-start
    pkgs.emacsPackages.melpaPackages.telega
    (emacs.pkgs.withPackages (
      epkgs: with epkgs; [
        org
        melpaPackages.telega
        tree-sitter
        vterm
        nix-mode
      ]
    ))
  ];

  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  build.activation = {
    sshd = ''
      $DRY_RUN_CMD mkdir $VERBOSE_ARG --parents "${config.user.home}/.ssh"

      if [[ ! -d "${sshdDirectory}" ]]; then
        $DRY_RUN_CMD rm $VERBOSE_ARG --recursive --force "${sshdTmpDirectory}"
        $DRY_RUN_CMD mkdir $VERBOSE_ARG --parents "${sshdTmpDirectory}"

        $VERBOSE_ECHO "Generating host keys..."
        $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t rsa -b 4096 -f "${sshdTmpDirectory}/ssh_host_rsa_key" -N ""

        $VERBOSE_ECHO "Writing sshd_config..."
        $DRY_RUN_CMD echo -e "HostKey ${sshdDirectory}/ssh_host_rsa_key\nPort ${toString port}\n" > "${sshdTmpDirectory}/config"

        $DRY_RUN_CMD mv $VERBOSE_ARG "${sshdTmpDirectory}" "${sshdDirectory}"
      fi
    '';
    ssh-config = linkFile "${ssh-config}" "${config.user.home}/.ssh/config";
    bash-profile = linkFile "${bash-profile}" "${config.user.home}/.bash_profile";
    bash-logout = linkFile "${bash-logout}" "${config.user.home}/.bash_logout";
    bashrc = linkFile "${bashrc}" "${config.user.home}/.bashrc";
  };

  # Set up nix for flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry = {
      np.flake = nixpkgs;
    };
  };

  user = {
    userName = "whaleahead";
    group = "users";
  };

  # Set your time zone
  time.timeZone = "Europe/Moscow";
}
