class Clitunes < Formula
  desc "Terminal music player with internet radio, Spotify, and real-time visualisers"
  homepage "https://github.com/vxcozy/clitunes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.1/clitunes-v1.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "b04dc451be20e962d3d2d9590a8d116dcbdb90e0ed0d7d50edfa6559f430db48"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.1/clitunes-v1.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "68fb4ded76de75b0193256b6ddc68efb2ec7e1d408fc3f8f673e12d56c96b196"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib" # libasound.so.2 runtime dep

    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.1/clitunes-v1.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "912b953b602dbfe38d9ae035ae67b3097363d55cfa462ab9c722c4ca5ad368de"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.1/clitunes-v1.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34cf4a572ab862dde1469cabeea314c784d1280db89edf233f1d8972184d0282"
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
