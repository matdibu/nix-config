{ pkgs, ... }:
let inherit (builtins) readFile;
in {
  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      # language servers
      nvim-lspconfig
      nvim-treesitter.withAllGrammars

      # autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-spell
      cmp_luasnip
      luasnip

      {
        plugin = gitsigns-nvim;
        config = "lua require('gitsigns').setup()";
      }
      clangd_extensions-nvim
      rainbow-delimiters-nvim # alternating syntax highlighting (“rainbow parentheses”)
    ];

    extraPackages = with pkgs; [
      git
      nil
      nixfmt-rfc-style
      nodePackages.bash-language-server
      texlab
      lua54Packages.digestif
      yaml-language-server
      dockerfile-language-server-nodejs
      cmake-language-server
      ruff
      lua-language-server
      clang-tools
    ];

    extraLuaConfig = readFile ./basic.lua + readFile ./jump-to-last-position.lua
      + readFile ./lsp-conf.lua + readFile ./lsp-list.lua;
  };
  home.sessionVariables.EDITOR = "nvim";
}
