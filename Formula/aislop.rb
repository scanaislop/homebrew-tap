class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.13.0.tgz"
  sha256 "316bc4c45c6a04227a5c24f5e0bea336e80d336f158c36116a3bd3768d5423e5"
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
