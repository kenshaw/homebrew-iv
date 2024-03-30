$pkg     = "github.com/kenshaw/iv"

class Iv < Formula
  desc "a command-line image viewer using terminal graphics (Sixel, iTerm, Kitty)"
  homepage "https://#{$pkg}"
  head "https://#{$pkg}.git"
  url "https://github.com/kenshaw/iv/archive/v0.1.5.tar.gz"
  sha256 "ca2e5ae0531c09054abf39ce75ab08d454e604b3be6e6f90938005085b167b2e"

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
