class Aislop < Formula
  desc "Scan your code for AI slop"
  homepage "https://scanaislop.com"
  url "https://registry.npmjs.org/aislop/-/aislop-0.23.0.tgz"
  sha256 "18171169b7ce7792fc2436f628f9b478c203071f07b6fe602d3e867c26050a70"
  license "MIT"

  depends_on "golangci-lint"
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aislop --version")
    assert_match "aislop scan", shell_output("#{bin}/aislop --help")
    assert_predicate formula_opt_bin("golangci-lint")/"golangci-lint", :executable?
    (testpath/"example.py").write("import os\n\nprint(42)\n")
    system bin/"aislop", "fix", testpath
    refute_match "import os", (testpath/"example.py").read
  end
end
