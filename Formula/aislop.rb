class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.13.0.tgz"
  sha256 "c3982cbaecd98f6f0c63e95561e18eb66beb62b197b1aac28990651b1ce230bd"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aislop --version")
    assert_match "aislop scan", shell_output("#{bin}/aislop --help")
  end
end
