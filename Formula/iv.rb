$pkg     = "github.com/kenshaw/iv"

class Iv < Formula
  desc "a command-line image viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/iv/archive/v0.9.0.tar.gz"
  sha256 "ec8fe1fd4cb4d9927141ab6618512cb38d5b5850e9bc37a514efa7640d8f6821"

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
