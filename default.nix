{ pkgs ? import <nixpkgs> {
  config = {
    allowUnfree = true; # Required to allow terraform to be installed
  };
}}:

let
  # Override the Terraform package to a specific version
  terraform = pkgs.terraform.overrideAttrs (oldAttrs: rec {
    version = "1.8.2";
    src = pkgs.fetchFromGitHub {
      owner = "hashicorp";
      repo = "terraform";
      rev = "v${version}";
      # Provide the SHA256 hash of the source to ensure reproducibility
      sha256 = "sha256-c9RzdmaTXMOi4oP++asoysDpt/BSvBK/GmEDDGViSl0=";
    };
  });
  # Override the Terramate package to a specific version
  terramate = pkgs.terramate.overrideAttrs (oldAttrs: rec {
    version = "0.8.2"; # Specify your desired version
    src = pkgs.fetchFromGitHub {
      owner = "mineiros-io";
      repo = "terramate";
      rev = "v${version}";
      sha256 = "sha256-aOKUC1FtDDhdUbPUSLW6GrSwh6r29Y2ObC6y487W4Zc="; # Replace with actual SHA25
    };
  });
    # Python environment with some basic packages
    pythonEnv = pkgs.python3.withPackages (ps: with ps; [
      ps.python-gitlab
      ps.pip
      ps.requests
      ps.pytest
      ps.black
      ps.flake8
    ]);
in
pkgs.buildEnv {
  name = "terramate-tools";
  paths = [
    pkgs.terraform
    pkgs.terramate
    pkgs.git
    pkgs.cacert
    pkgs.pre-commit
    pkgs.terraform-docs
    pkgs.checkov
    pkgs.tflint
    pkgs.gitleaks
    pkgs.infracost
    pkgs.bash
    pkgs.yq
    pkgs.jq
    pkgs.curl
    pkgs.google-cloud-sdk
    pkgs.go-task
    pkgs.nodePackages.markdown-link-check
    pkgs.zip
    pkgs.unzip
    pkgs.gnutar
    pkgs.wget
    pkgs.curl
    pkgs.gnugrep
    pkgs.gawk
    pkgs.openssl_3_2
    pkgs.openssh
    pkgs.coreutils
    pkgs.libzip
    pkgs.taglib
    pkgs.libxml2
    pkgs.libxslt
    pkgs.zlib
    pythonEnv
    ];
}
