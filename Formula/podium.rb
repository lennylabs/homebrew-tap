class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.1/podium-darwin-arm64.tar.gz"
      sha256 "4f792c765350f513b2352a775ef3c4217f2a17810573027522b9385db1f7d3aa" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.1/podium-linux-amd64.tar.gz"
      sha256 "43b20adc927012cffc6d04f517ff79acc9fc09993bc51d9b6405b5f9944979d1" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.3.1/podium-linux-arm64.tar.gz"
      sha256 "b4f7b0cb185a6890bffac79de7413ebf27c97c3725f6da80917a993ac04d73b5" # linux-arm64
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
