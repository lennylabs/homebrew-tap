class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.3/podium-darwin-arm64.tar.gz"
      sha256 "63b4cc0f1e44475599dc20ff147c1378d1e664034cde04d691b2ecd10884dd0e" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.3/podium-linux-amd64.tar.gz"
      sha256 "85a437fa4ddc9fb803bc6c1a8c182ff433c3bd7d29b869accd5d7b166e329b46" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.3/podium-linux-arm64.tar.gz"
      sha256 "0584ff2c9c625038c078f4bb8050b554fa12de427c88d02fb6a247dbb73c9903" # linux-arm64
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
