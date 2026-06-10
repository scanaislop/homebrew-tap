class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.12.0.tgz"
  sha256 "0063a3187d0d77a949ba32beed67d6c4f967526fe358ccffd62c4b5a9ca2619e"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aislop --version")
    assert_match "Usage:", shell_output("#{bin}/aislop --help")
  end
end
