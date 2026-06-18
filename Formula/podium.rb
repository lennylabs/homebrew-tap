class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.6/podium-darwin-arm64.tar.gz"
      sha256 "cbb5a3353df9aa9bef87dd502f4f318e8a708dd8cbe6191c4199ceeec768acb5" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.6/podium-linux-amd64.tar.gz"
      sha256 "3b03ccc40b6e33759458fc88124a17483a5b130c13d3e99f0b2951764434f957" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.6/podium-linux-arm64.tar.gz"
      sha256 "5422b247a26e3f13b533037304cce027fbd2c74915eef1e25d45d1b3ff1723f4" # linux-arm64
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
