{ ... }:

{
  programs.zen-browser.profiles.default = {
    spacesForce = true;
    pinsForce = true;

    spaces = {
      "Chaos" = {
        id = "3f9a1c52-7b84-4e0d-9a36-5c1d8e27b0f4";
        position = 1000;
      };

      "Study" = {
        id = "a7d2e4b9-1c63-4f58-8b0e-92f4a6c3d517";
        position = 2000;
      };

      "Socials" = {
        id = "5e0b8c71-d4a2-4936-b7f1-0c8e3a9d6254";
        position = 3000;
      };
    };

    pins = {
      "Claude" = {
        id = "1b6f3d90-8a4c-4d27-9e51-f3a07c82b6d9";
        url = "https://claude.ai/";
        position = 101;
        isEssential = true;
      };
      "ChatGPT" = {
        id = "c4e81a37-2d95-4b60-a8f3-7e1b9d054c82";
        url = "https://chatgpt.com/";
        position = 102;
        isEssential = true;
      };
      "GitHub" = {
        id = "82d0f6a5-b3e7-4c19-9d48-1a5c7e3f0b26";
        url = "https://github.com/";
        position = 103;
        isEssential = true;
      };
      "Gmail" = {
        id = "e9a35c14-6f08-4d72-b1c9-4d8a2f7e1035";
        url = "https://mail.google.com/";
        position = 104;
        isEssential = true;
      };
      "Google Keep" = {
        id = "0d7b4e28-95c1-4a63-8f2d-b6e30a1c9f47";
        url = "https://keep.google.com/";
        position = 105;
        isEssential = true;
      };
      "Sofascore" = {
        id = "6c1f9b83-e2a4-4075-a9d6-3f8b5c0e7d12";
        url = "https://www.sofascore.com/";
        position = 106;
        isEssential = true;
      };
    };
  };
}
