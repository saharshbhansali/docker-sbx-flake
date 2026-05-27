{
  stdenv,
  fetchzip,
  lib,
  ...
}@args:

with import <nixpkgs> { };

stdenv.mkDerivation {
  pname = "sbx";
  version = "0.29.0";

  buildInputs = [
    pkgs.e2fsprogs
  ];

  src = fetchzip {
    url = "https://github.com/docker/sbx-releases/releases/download/v0.29.0/DockerSandboxes-linux.tar.gz";
    # sha256 = lib.fakeSha256;
    sha256 = "sha256-E9Fu3FZNA88LRyaxAfxDwFQAXgo9lT8MhnH/c+bDBgc=";
  };

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/libexec/lib
    mkdir -p $out/share
    mkdir -p $out/etc/apparmor.d
    cp sbx $out/bin/sbx
    cp libkrun.so $out/libexec/lib/libkrun.so
    cp mkfs.erofs $out/libexec/mkfs.erofs
    cp containerd-shim-nerdbox-* $out/libexec/
    cp nerdbox-initrd-* $out/libexec/
    cp nerdbox-kernel-* $out/libexec/
    cp apparmor-profile $out/etc/apparmor.d/docker-sbx-nerdbox-shim
  '';

}
