class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.4.0/podium-darwin-arm64.tar.gz"
      sha256 "fa30cc44cfebd55c2e031577a9b6d2ce64bb2ba07504a099e2ff5cd90989f0c8" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.4.0/podium-linux-amd64.tar.gz"
      sha256 "b49d3b3d882f299c90b096351e432504bcd8272204e32b287b2f75eab5625943" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.4.0/podium-linux-arm64.tar.gz"
      sha256 "9d748ef1f7d2391a8931cb5dc2cac3c32542aea51b919a6fd8a365bf64d4fbde" # linux-arm64
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
