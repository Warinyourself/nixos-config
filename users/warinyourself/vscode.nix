{ lib, pkgs, ... }: {
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
}