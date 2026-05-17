{ stdenv, fetchTarball, lib }:

stdenv.mkDerivation {
  pname = "sbx";
  version = "0.29.0";

  src = fetchTarball {
    url = "https://github.com/docker/sbx-releases/releases/download/v0.29.0/DockerSandboxes-linux.tar.gz";
    sha256 = "";
  };

}
