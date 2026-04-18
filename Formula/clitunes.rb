class Clitunes < Formula
  desc "Terminal music player with internet radio, Spotify, and real-time visualisers"
  homepage "https://github.com/vxcozy/clitunes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.0/clitunes-v1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "c746c07e08a8045c35d7c57f425a4f3623d71462a55ae28c7a91c74979b260e0"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.0/clitunes-v1.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "98829afd1ca820b3786934de9b4aabf2decb6c77bc5daa27305d1c8e0495bba5"
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    depends_on "alsa-lib" # libasound.so.2 runtime dep

    on_arm do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.0/clitunes-v1.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa9df8e29307a1fb925ab8feeb14d16acb311e4dc1ae284a8bac21e3737f31fe"
    end
    on_intel do
      url "https://github.com/vxcozy/clitunes/releases/download/v1.2.0/clitunes-v1.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08da4140d5498096d2f6487b61001ba9b1a03d6699c45d76209559337b03a00f"
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
