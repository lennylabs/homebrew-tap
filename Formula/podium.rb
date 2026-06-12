class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.5/podium-darwin-arm64.tar.gz"
      sha256 "9f06d68dc306ad21e428f56e0e4bdb5a05f7bcc283d98430d9c1de9e4b096ce2" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.5/podium-linux-amd64.tar.gz"
      sha256 "27eb6feb84ffb084827c1c21164aa7eac4138dabdbe11e9b27dd0acc6a5060ad" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.5/podium-linux-arm64.tar.gz"
      sha256 "9c8ef2240f119519c404becdfec8c6ee0b635a9f57bdd5ad6fd5d59ddc82c882" # linux-arm64
    end
  end

  # The tarball contains podium, podium-server, and podium-mcp at the
  # top level (no platform suffix on the names inside the archive).
  def install
    bin.install "podium", "podium-server", "podium-mcp"
  end

  test do
    assert_match "podium #{version}", shell_output("#{bin}/podium version")
    assert_predicate bin/"podium-server", :executable?
    assert_predicate bin/"podium-mcp", :executable?
  end
end
