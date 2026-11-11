class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.6.0/podium-darwin-arm64.tar.gz"
      sha256 "2047e39ceb60f7f070ec9e516bd16081f2630e5532480b3006c6f6404095038e" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.6.0/podium-linux-amd64.tar.gz"
      sha256 "5f3ad807bfea10acc58fa01dd98b1af7e08aa17e2aeedd4ede3c41e0ca5b8d79" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.6.0/podium-linux-arm64.tar.gz"
      sha256 "4abc744188ba8401606e5da8b405b339dbd2f549b8ccf97fde7f42a14f85c5db" # linux-arm64
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
