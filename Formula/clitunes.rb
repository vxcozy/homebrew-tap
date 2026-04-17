class Clitunes < Formula
  desc "Terminal music player with internet radio, Spotify, and real-time visualisers"
  homepage "https://github.com/vxcozy/clitunes"
  version "1.0.0"
  license "MIT"

  depends_on "alsa-lib" => :linux

  on_macos do
    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.0.0/clitunes-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "97aa05ca2169ff44e3a3252630f3203a7ee5dc2c1fb8df150e2f02fbcae49539"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.0.0/clitunes-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "2d20ce9a32029e905088911b088373fc19bec001f5f2f8f77dc8540203ed2ce7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.0.0/clitunes-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "65896e8a92be437269c5810687ae5c875343f769b46e2548b9820feda68bac25"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.0.0/clitunes-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a49f72729b0f4ff4dc7c80067b8031d3ec27d974ff1b36dfdead99d5e6755d4d"
    end
  end

  def install
    bin.install "clitunes", "clitunesd"
  end

  test do
    assert_path_exists bin/"clitunes"
    assert_path_exists bin/"clitunesd"
    assert_match version.to_s, shell_output("#{bin}/clitunes --version")
    assert_match version.to_s, shell_output("#{bin}/clitunesd --version")
  end
end
