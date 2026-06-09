class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.4/podium-darwin-arm64.tar.gz"
      sha256 "a9aac9acd4a02fc9159c89476d04530e2220ed486792dad3affb56c7b151fe3b" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.4/podium-linux-amd64.tar.gz"
      sha256 "e4cc3cd74caacd11f6013b3ce5ddc73bf4f37077436ec3c6ceb41538728ac18a" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.4/podium-linux-arm64.tar.gz"
      sha256 "f344597f397c1427ddc64128b6f79d39078da08e1e97eb107008f5a6bbb441c7" # linux-arm64
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
