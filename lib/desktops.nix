rec {
  names = [
    "hyprland"
    "umbriel"
    "mango"
    "sway"
    "labwc"
  ];

  usesGreetd = desktop: true;

  greeterSession = desktop:
    {
      hyprland = "Hyprland";
      umbriel = "Umbriel";
      mango = "MangoWC";
      sway = "sway";
      labwc = "labwc";
    }
    .${desktop};

  assertValid = desktop:
    if builtins.elem desktop names then
      desktop
    else
      builtins.throw "Unknown desktop '${desktop}'. Expected one of: ${builtins.concatStringsSep ", " names}";
}
