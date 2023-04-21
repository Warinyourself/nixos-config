{ config, lib, pkgs, ... }: {
  # Import gnome settings
  imports = [ ./gnome-extensions.nix ./openvpn.nix ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------
  home.packages = [
    pkgs.bat
    pkgs.fd
    pkgs.fzf
    pkgs.jq
    pkgs.ripgrep
    pkgs.tree
    pkgs.watch

    pkgs.blender
    pkgs.mattermost-desktop
  ];

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------
  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
    };
  };

  home.file = {
    "./Documents/Programming/.stignore".text = ''
      **/node_modules
      **/dist
      **/.nuxt
    '';
  };

  programs.vscode.enable = true;
  programs.vscode.keybindings = [
    {
      key = "ctrl+tab";
      command = "workbench.action.nextEditor";
    }
    {
      key = "ctrl+pagedown";
      command = "-workbench.action.nextEditor";
    }
    {
      key = "ctrl+shift+tab";
      command = "workbench.action.previousEditor";
    }
    {
      key = "ctrl+pageup";
      command = "-workbench.action.previousEditor";
    }
    { key = "ctrl+, ctrl+,"; command = "workbench.action.openSettings2"; }
    { key = "ctrl+, ctrl+."; command = "workbench.action.openGlobalKeybindings"; }
  ];

  programs.vscode.userSettings = {
    "security.workspace.trust.untrustedFiles" = "open";
    "terminal.integrated.defaultProfile.linux" = "fish";
    "workbench.colorTheme" = "Adwaita Dark";
    "files.autoSave" = "off";
    "[nix]"."editor.tabSize" = 2;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
    };
  };

  programs.git = {
    enable = true;
    userName = "Warinyourself";
    userEmail = "warinyourself@gmail.com";
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
  };
}
