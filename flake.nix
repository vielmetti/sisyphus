{
  description = "tools for the never ending task";
 
  inputs.flake-utils.url = "github:numtide/flake-utils";
 
  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      my-name = "sisyphus";
      my-buildInputs = with pkgs; [ bash coreutils ];
      my-script = (pkgs.writeScriptBin my-name (builtins.readFile ./sisyphus)).overrideAttrs(old: {
        buildCommand = "${old.buildCommand}\n patchShebangs od awk $out";
      });
      in rec {
        defaultPackage = packages.my-script;
        packages.my-script = pkgs.symlinkJoin {
         name = my-name;
          paths = [ my-script ] ++ my-buildInputs;
          buildInputs = [ pkgs.makeWrapper ];
         postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
       };
     } 
   );
}
