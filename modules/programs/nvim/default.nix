{
  flake.modules.homeManager.nvim = { config, pkgs, ... }: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        package = pkgs.neovim-unwrapped;

        sideloadInitLua = true;

        plugins = with pkgs.vimPlugins; [
            friendly-snippets
            mini-nvim
            netrw-nvim
            nvim-lspconfig
            render-markdown-nvim
            guess-indent-nvim

            nvim-treesitter.withAllGrammars

            #Searcher
            plenary-nvim
            telescope-nvim

            #Color Theme
            tokyonight-nvim
        ];

        extraPackages = with pkgs; [
            # --- Tools & Utilities ---
            ripgrep
            fd

            # --- Nix Development ---
            nixd
            nixfmt

            # --- Languages & LSP Servers explicitly used in your lua setup ---
            lua-language-server # lua_ls
            basedpyright        # basedpyright (Python)
            bash-language-server# bashls
            clang-tools         # clangd (C/C++)
            vscode-langservers-extracted # cssls & jsonls
            neocmakelsp
            rust-analyzer       # rust_analyzer
            superhtml           # superhtml
            taplo               # taplo (TOML)
            vtsls               # vtsls (TypeScript/JavaScript backend)
            yaml-language-server# yamlls
            python3Packages.pylatexenc# latex 2 text
            tree-sitter
        ];
    };

    # Home Manager's equivalent to environment.variables
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    xdg.configFile."nvim" = {
        source = ./setup;
        recursive = true;
    };
  };
}
