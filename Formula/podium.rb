class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.1/podium-darwin-arm64.tar.gz"
      sha256 "023924577f681dad1860a6d1cbc20d82dc9c5d9995db67465459a059d2db3a23" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.1/podium-linux-amd64.tar.gz"
      sha256 "d5e83fbc5262fda23040c190338609f77a77e71a5b723208ebc0e72bea776265" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.1/podium-linux-arm64.tar.gz"
      sha256 "2800ddafbdbf180aee95dd5cb1b465fe00af77fd370dc950bcda70a1b8a8f89c" # linux-arm64
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
