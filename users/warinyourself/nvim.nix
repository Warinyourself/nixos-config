{ config, pkgs, lib,  ... }: {
  config = {
    xdg.configFile."nvim".recursive = true;
    xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "80c63b790c370fa65f5765d8e40a1544137c1c37";
      sha256 ="RkTzmgBMAgIRX4ZOQ0X4GqgR9fZjMjWlLUwrX6qIeZc=";
    };
  };
}
