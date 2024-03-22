{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly.packages.${pkgs.system}.neovim;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-colorizer-lua
      nvim-autopairs
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-spell
      cmp_luasnip
      clangd_extensions-nvim
      luasnip
      gitsigns-nvim
      rainbow-delimiters-nvim
    ];

    extraPackages = with pkgs; [
      git # gitsigns

      # lsp's
      nil
      nixpkgs-fmt
      nodePackages.bash-language-server
      texlab
      lua54Packages.digestif
      yaml-language-server
      dockerfile-language-server-nodejs
      cmake-language-server
      ruff
      lua-language-server
    ];

    extraLuaConfig =
      builtins.readFile neovim/basic.lua
      + builtins.readFile neovim/jump-to-last-position.lua
      + builtins.readFile neovim/lsp-conf.lua
      + builtins.readFile neovim/lsp-list.lua;
  };
  home.sessionVariables.EDITOR = "nvim";
}
