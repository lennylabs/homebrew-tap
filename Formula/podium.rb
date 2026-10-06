class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.0/podium-darwin-arm64.tar.gz"
      sha256 "cc586228a18a8d3c0823836e88d8de9e96759062102d234f9209f0f7bd461101" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.0/podium-linux-amd64.tar.gz"
      sha256 "bcd2c330384456d091f1804de33eb3e76ab7ad6a78ac6e01480921e88078c19e" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.5.0/podium-linux-arm64.tar.gz"
      sha256 "89c21ba71bb3df23c36a971f6818f3db3e6bbdafcde4af1c7c5b9dce0ceee95c" # linux-arm64
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
