{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "axioncs";
      user.email = "your@email.com";
      init.defaultBranch = "main";
      pull.rebase = false;
      credential.helper = "!gh auth git-credential";
    };
  };
}
