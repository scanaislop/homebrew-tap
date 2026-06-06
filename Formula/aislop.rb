class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.11.0.tgz"
  sha256 "dd8a9bd24d60548cdce63e06de6f790a9a361b805862ac39bc02f3ded3126954"
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
