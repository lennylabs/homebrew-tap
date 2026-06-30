class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.0/podium-darwin-arm64.tar.gz"
      sha256 "86670492e1d517c3f8c80fdf180848b0e33dbf0f27fe566207e473fb6e35c8f3" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.0/podium-linux-amd64.tar.gz"
      sha256 "ecf0c8d48e111eca06d15e711d206b8289b34818e48be2479f22e20117d8d64e" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.2.0/podium-linux-arm64.tar.gz"
      sha256 "cc24b09ee0a9feccc794fb3e1fc3fe44d613a384b0e24f0ed172bd846beb1bdc" # linux-arm64
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
