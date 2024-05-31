{ pkgs ? import <nixpkgs> {
  config = {
    allowUnfree = true; # Required to allow terraform to be installed
  };
}}:

let
  tools = (import ./default.nix { inherit pkgs; });
in
pkgs.mkShell {
  name = "terramate-tools-shell";
  buildInputs = [ tools pkgs.pre-commit pkgs.figlet ];
  shell = pkgs.bash;

    shellHook = ''
      figlet "Terramate Tools Nix Shell"
      echo "Terraform version: $(terraform --version)"
      echo "Terramate version: $(terramate --version)"
      echo "Gitleaks version: $(gitleaks version)"
      echo "Infracost vergitsion: $(infracost --version)"
      echo "Google Cloud SDK version: $(gcloud --version)"
      echo "Git version: $(git --version)"
      echo "Pre-commit version: $(pre-commit --version)"
      echo "Terraform-docs version: $(terraform-docs --version)"
      echo "Checkov version: $(checkov --version)"
      echo "Tflint version: $(tflint --version)"
      echo "Yq version: $(yq --version)"
      echo "Jq version: $(jq --version)"
      pre-commit install

      # Load *.env files if available
      if [[ -f .env ]]; then
        source .env
      else
        echo -e "No .env file found!"
        ls -la
      fi


      # Check if GITLAB_ACCESS_TOKEN or TF_HTTP_PASSWORD is set
      if test -z "$GITLAB_ACCESS_TOKEN" && test -z "$TF_HTTP_PASSWORD"; then
         echo -e "GITLAB_ACCESS_TOKEN or TF_HTTP_PASSWORD is not set!"
         echo -e "Please set the environment variables GITLAB_ACCESS_TOKEN and TF_HTTP_PASSWORD via the .env as described in the README.md"
      fi

      # Add aliases for terramate and terraform
      alias tf='terraform'
      alias tm='terramate'
    '';
}
