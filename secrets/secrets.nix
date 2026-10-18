let
  machine = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsnJdua8fFjXkWlOt0m6oDGmCssTCt3mAt9lMtZOMdW agenix";
  me = "age1l03wtr52uv5s2np2fqess2qf5cllfzfm5et4dc2xcnnykncxldrsw57y77";
  all = [ machine me ];
in {
  "nix-netrc.age".publicKeys = all;
  "nix-github-token.age".publicKeys = all;
  "aria2-rpc.age".publicKeys = all;
  "steamgriddb.age".publicKeys = all;
}
