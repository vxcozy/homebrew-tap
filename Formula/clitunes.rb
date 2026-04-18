class Clitunes < Formula
  desc "Terminal music player with internet radio, Spotify, and real-time visualisers"
  homepage "https://github.com/vxcozy/clitunes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.1.0/clitunes-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "ce96f37b82609e4bfe735069e7801d3ec1a5e5eccc777b48c618fc2a87da3f24"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.1.0/clitunes-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0f7b16d59a0b507f8b910a268f55ec4461db63df99bdf68d586953fe96c7766d"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib" # libasound.so.2 runtime dep

    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.1.0/clitunes-v1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8540e2efc7f0ebbd53186fbe62c2d6385869c3bcd6c8bb4622d29eb440f33c57"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.1.0/clitunes-v1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cfb020731827d3bb65c86b33aa7cd12ba36d277568ad3ac0f218b7116731e96d"
    end
  end

  def install
    bin.install "clitunes", "clitunesd"

    # The Linux binaries are built on GitHub Actions without Homebrew's
    # linker setup, so they don't know about Homebrew's alsa-lib location.
    # patchelf rewrites RPATH so the dynamic linker finds libasound.so.2
    # under HOMEBREW_PREFIX/lib at runtime.
    if OS.linux?
      system Formula["patchelf"].opt_bin/"patchelf",
             "--set-rpath", HOMEBREW_PREFIX/"lib",
             bin/"clitunesd"
      system Formula["patchelf"].opt_bin/"patchelf",
             "--set-rpath", HOMEBREW_PREFIX/"lib",
             bin/"clitunes"
    end
  end

  test do
    assert_path_exists bin/"clitunes"
    assert_path_exists bin/"clitunesd"
    assert_match version.to_s, shell_output("#{bin}/clitunes --version")
    assert_match version.to_s, shell_output("#{bin}/clitunesd --version")
  end
end
