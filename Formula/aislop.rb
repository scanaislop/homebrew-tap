class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.22.2.tgz"
  sha256 "85e4159929d37fc02c7d85460eb4f76900d09bbc37579a67df887e39dfa163b3"
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
