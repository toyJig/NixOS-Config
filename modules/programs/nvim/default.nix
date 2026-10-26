{
  flake.modules.homeManager.nvim = { config, pkgs, ... }: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        sideloadInitLua = true;

        plugins = with pkgs.vimPlugins; [
            friendly-snippets
            mini-nvim
            netrw-nvim
            nvim-lspconfig
            orgmode
            render-markdown-nvim

            nvim-treesitter.withAllGrammars

        ];

        extraPackages = with pkgs; [
            lua-language-server
            nil
            ripgrep
            fd
            gcc
        ];
    };

    xdg.configFile."nvim" = {
        source = ./setup;
        recursive = true;
    };
  };
}
