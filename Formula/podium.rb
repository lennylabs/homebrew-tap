class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.5.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.2/podium-darwin-arm64.tar.gz"
      sha256 "f0e5cca6764e71278a5c64c8abfc16a2da0bcc7e6b6155ec754e08f415806afb" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.2/podium-linux-amd64.tar.gz"
      sha256 "50097561cac08384bb17bde85ccb7e288cdfc6fd68262b32af7f039f2e87b5dd" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.2/podium-linux-arm64.tar.gz"
      sha256 "a420e0a0b882a841ce36994070531e2d687201a28682840148fc95826ab4aa6b" # linux-arm64
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
