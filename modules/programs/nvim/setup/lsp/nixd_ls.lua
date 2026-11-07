return {
    settings = {
        nixd = {
            formatting = {
                command = { "alejandra" },
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.home-desktop.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake (toString ./.)).homeConfigurations."toyjig@home-desktop".options',
                },
            },
        },
    },
}
