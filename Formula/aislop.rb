class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.12.0.tgz"
  sha256 "6a762e064260e3cbc55368479cd715054c25b48922cd8cac2d1443b9c09a9811"
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
