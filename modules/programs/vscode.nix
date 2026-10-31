{ ... }: {
    flake.modules.homeManager.vscode = { pkgs, ... } : {
         programs.vscode = {
              enable = true;
              profiles.default.extensions = with pkgs.vscode-extensions; [
                    vscodevim.vim
                    yzhang.markdown-all-in-one

                    redhat.java
                    vscjava.vscode-java-pack
                    vscjava.vscode-java-debug
                    vscjava.vscode-java-test
                    vscjava.vscode-maven
                    vscjava.vscode-gradle
                    vscjava.vscode-java-dependency
                    vscjava.vscode-spring-initializr
              ];
        };   
    };
}
