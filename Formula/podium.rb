class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.2/podium-darwin-arm64.tar.gz"
      sha256 "0a7c5e987de1a22d410d6098b657655817ad5a4cddddcdf257cb72c9bff2d389" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.2/podium-linux-amd64.tar.gz"
      sha256 "049c5762758efaacb3ccda0050d4d6ced4bb6310f9714b932f08be2cb14c79de" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.2/podium-linux-arm64.tar.gz"
      sha256 "f929c6e73000047577b101eaf3296e4ea450ddadae55b5765991805f8f1bd010" # linux-arm64
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
