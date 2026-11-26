class Actae < Formula
  desc "Durable execution for AI agents"
  homepage "https://actae.dev"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "d278292b0602bf4525fc4bd593014493baeabdca623d31b5463660e6446ed76e"
    else
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "bbb701995338e65a2656db1f60aad7fe59f7df776bacf46a9641318c89f83523"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "09fdf417b97bfc3895fc2569d64fb3e0feb33856c7924c0d1ba9fc22910cbe69"
    else
      url "https://github.com/DivigaActae/actae/releases/download/v0.3.0/actae-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f62ae36a3b8c270eb2ba6a021fb14a5f630760cbdf75a8a4ad73122acc2dbe1"
    end
  end

  def install
    bin.install "actae"
  end

  test do
    assert_match "actae", shell_output("#{bin}/actae --version")
  end
end
