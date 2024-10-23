{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  programs.git = {
    enable = true;
    userName = userSettings.nameGithub;
    userEmail = userSettings.emailGithub;
    # extraConfig = {
    #   # init.defaultBranch = "main";
    # };
    ignores = [
      ".direnv"
      ".vscode"
      ".env"
      ".env.production"
    ];
  };

  #!! fix for vscode (and etc) clone to container (ssh forwarding)
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
  };
}
