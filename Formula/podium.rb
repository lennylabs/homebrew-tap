class Podium < Formula
  desc "Catalog and registry for reusable AI agent artifacts"
  homepage "https://github.com/lennylabs/podium"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.1/podium-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # darwin-arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.1/podium-linux-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # linux-amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/lennylabs/podium/releases/download/v0.1.1/podium-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # linux-arm64
    end
  end

  def install
    bin.install File.basename(stable.url) => "podium"
  end

  test do
    assert_match "podium #{version}", shell_output("#{bin}/podium version")
  end
end
