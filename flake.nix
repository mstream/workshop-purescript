{
  description = "Purescript workshop exercise";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = inputs:
    let
      name = "purescript-bmi";
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];

    in inputs.flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        pursTidy = pkgs.nodePackages.purs-tidy;

        format-check = pkgs.stdenvNoCC.mkDerivation {
          checkPhase = ''
            purs-tidy check {src,test}
          '';
          doCheck = true;
          dontBuild = true;
          installPhase = ''
            mkdir "$out"
          '';
          name = "format-check";
          nativeBuildInputs = [ pursTidy ];
          src = ./.;
        };

      in {
        checks = { inherit format-check; };
        devShell = pkgs.mkShell {
          inherit name;
          buildInputs = [ pkgs.spago pursTidy ];
          shellHook = ''
            PS1="\[\e[33m\][\[\e[m\]\[\e[34;40m\]${name}:\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] "
          '';
        };
      });
}
