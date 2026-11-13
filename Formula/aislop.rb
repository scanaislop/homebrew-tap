class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.21.0.tgz"
  sha256 "c9798dc038f6c6333c3c2a9cddc29a5e2b555c7aad2ec09f8f428fe0be4dbf65"
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
