class Actae < Formula
  desc "Durable execution for AI agents"
  homepage "https://actae.dev"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "630d45a76e06ab95a4f2518d0b6b5631a54e8d6211c1ee8188619f726e250fae"
    else
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "b8419166be02c707a3d465e6311904769285c3f17acf2b4cb62b5580065d4b6f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "132971b6010d3436d4750e3982513e9a5b1eaafc4038e12b2698c98a36646008"
    else
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6645c05f27814599e6c89f924e861d7a8febd5de487b45c1f03395f26ee1c76"
    end
  end

  def install
    bin.install "actae"
  end

  test do
    assert_match "actae", shell_output("#{bin}/actae --version")
  end
end
