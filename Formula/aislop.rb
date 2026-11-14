class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.22.0.tgz"
  sha256 "1e6be608584ce5046f2df34cd99baaafaa8d82745c3de28aab2a574ef0b104f6"
  license "MIT"

  depends_on "golangci-lint"
  depends_on "node"
  depends_on "ruff"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aislop --version")
    assert_match "aislop scan", shell_output("#{bin}/aislop --help")
    assert_predicate formula_opt_bin("golangci-lint")/"golangci-lint", :executable?
    assert_predicate formula_opt_bin("ruff")/"ruff", :executable?
  end
end
