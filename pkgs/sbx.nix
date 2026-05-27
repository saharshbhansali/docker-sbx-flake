{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
  makeWrapper,
  zlib,
  lz4,
  zstd,
  xxhash,
  e2fsprogs,
  ...
}@args:

# with import <nixpkgs> { };

stdenv.mkDerivation {
  pname = "sbx";
  version = "0.29.0";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    e2fsprogs
    zlib
    lz4
    zstd
    xxhash
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
    install -Dm755 sbx $out/bin/sbx
    install -Dm755 libkrun.so $out/libexec/lib/libkrun.so
    install -Dm755 mkfs.erofs $out/libexec/mkfs.erofs
    install -Dm755 containerd-shim-nerdbox-* $out/libexec/
    install -Dm644 nerdbox-initrd-* $out/libexec/
    install -Dm644 nerdbox-kernel-* $out/libexec/
    install -Dm644 apparmor-profile $out/etc/apparmor.d/docker-sbx-nerdbox-shim
  '';

}
