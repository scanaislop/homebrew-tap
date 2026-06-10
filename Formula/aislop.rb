class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.12.0.tgz"
  sha256 "ceb6bb564e7d66217d9e2aa805ad49030adebbbb76c8e2c04f185c8dfa1f8cff"
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
