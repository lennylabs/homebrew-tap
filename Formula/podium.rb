class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.1/podium-darwin-arm64.tar.gz"
      sha256 "ee3394c87c073553ec6036a2cdcbdd7ada88e1fde38d026b586e8b7c68386a87" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.1/podium-linux-amd64.tar.gz"
      sha256 "c85644101f3cb48d01b4a4d4ff1342cb3f5d653202fea7ea7ed81e3f591c4d1d" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.1/podium-linux-arm64.tar.gz"
      sha256 "18d58172b6d1118f53d6943360fb9ca63f2e8e1d0511e8f8473bde65fc4c0165" # linux-arm64
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
