{ config, lib, ... }:

{
  environment.variables = {
    XCURSOR_SIZE = "20";
    QT_QPA_PLATFORM = "wayland";
  };
}
