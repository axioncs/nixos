{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "axioncs";
      user.email = "shadman17244@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = false;
      credential.helper = "!gh auth git-credential";
    };
  };
}
