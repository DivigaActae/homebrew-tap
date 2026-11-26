#!/usr/bin/env bash
# Regenerates Formula/actae.rb from a published GitHub release.
# Usage: scripts/update-formula.sh v0.3.0
set -euo pipefail
VERSION="${1:?usage: $0 <tag, e.g. v0.3.0>}"
REPO="DivigaActae/actae"
NUM="${VERSION#v}"
DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

sha_for() {
  local target="$1"
  gh release download "$VERSION" -R "$REPO" -p "SHA256SUMS-${target}" -D "$TMP" --clobber >/dev/null
  awk '{print $1}' "$TMP/SHA256SUMS-${target}" | head -1
}

url_for() {
  echo "https://github.com/${REPO}/releases/download/${VERSION}/actae-${VERSION}-$1.tar.gz"
}

MAC_ARM=$(sha_for aarch64-apple-darwin)
MAC_INTEL=$(sha_for x86_64-apple-darwin)
LINUX_ARM=$(sha_for aarch64-unknown-linux-gnu)
LINUX_INTEL=$(sha_for x86_64-unknown-linux-gnu)

cat > "$DIR/Formula/actae.rb" <<EOF
class Actae < Formula
  desc "Durable execution for AI agents"
  homepage "https://actae.dev"
  version "${NUM}"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "$(url_for aarch64-apple-darwin)"
      sha256 "${MAC_ARM}"
    else
      url "$(url_for x86_64-apple-darwin)"
      sha256 "${MAC_INTEL}"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "$(url_for aarch64-unknown-linux-gnu)"
      sha256 "${LINUX_ARM}"
    else
      url "$(url_for x86_64-unknown-linux-gnu)"
      sha256 "${LINUX_INTEL}"
    end
  end

  def install
    bin.install "actae"
  end

  test do
    assert_match "actae", shell_output("#{bin}/actae --version")
  end
end
EOF

echo "wrote $DIR/Formula/actae.rb for ${VERSION}"
