$pkg     = "github.com/kenshaw/iv"

class Iv < Formula
  desc "a command-line image viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/iv/archive/v0.8.0.tar.gz"
  sha256 "4bb291d1611c50b0b9291a453f3181db0c9c73672fb1d2e9826bef0456f5e603"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{$pkg}").install buildpath.children

    cd "src/#{$pkg}" do
      system "go", "mod", "download"
      system "go", "build",
        "-trimpath",
        "-ldflags", "-s -w -X main.version=#{self.version}",
        "-o",       bin/"iv"
    end
  end

  test do
    output = shell_output("#{bin}/iv --version")
    assert_match "iv #{self.version}", output
  end
end
