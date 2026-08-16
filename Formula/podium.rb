class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.0/podium-darwin-arm64.tar.gz"
      sha256 "1e64a22022a8a8eba828ac4f5504b17fab19a7781aa531283b95efb4b52df9ef" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.0/podium-linux-amd64.tar.gz"
      sha256 "cb3b7c4988481ee217795501c25ecbed5165475c3cb741303d3e579268961365" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.0/podium-linux-arm64.tar.gz"
      sha256 "bc0112b7794bd1b691fd7525613f89749d317512823478e42db91aa5f6baf9ce" # linux-arm64
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
