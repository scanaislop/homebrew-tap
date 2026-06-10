class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.12.0.tgz"
  sha256 "565415f5fac26e670d9022d606e20163b9fef69ebccc77eab35b95a6985d450f"
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
