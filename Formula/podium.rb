class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.7.0/podium-darwin-arm64.tar.gz"
      sha256 "0712df51d054d02ed4afaf338542e35eb49a83c6cd95209b1562f9a0095c2248" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.7.0/podium-linux-amd64.tar.gz"
      sha256 "50e7b0bcffd3aa17aac9819e2ae64e67eca32059fc8ec23a2041917859549327" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.7.0/podium-linux-arm64.tar.gz"
      sha256 "4c329f52405e7bbc486e4eff15366edde9ad78886a8c8b52c86db13197678f80" # linux-arm64
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
