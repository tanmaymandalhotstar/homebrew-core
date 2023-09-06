class Pmd < Formula
  desc "Source code analyzer for Java, JavaScript, and more"
  homepage "https://pmd.github.io"
  url "https://github.com/pmd/pmd/releases/download/pmd_releases%2F7.0.0-rc3/pmd-dist-7.0.0-rc3-bin.zip"
  sha256 "e24b12c48582446a63b12d75a4e4ae4eb3c6e4b8f523ffa3226ccd33579c4229"
  license "BSD-4-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "836acbfe2da9e6da7e6319b9c614062758a797c866fa7c675d5867ff5799e091"
  end

  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"]
    libexec.install Dir["*"]
    (bin/"pmd").write_env_script libexec/"bin/pmd", Language::Java.overridable_java_home_env
  end

  def caveats
    <<~EOS
      Run with `pmd` (instead of `run.sh` as described in the documentation). [Deprecated: Newer version has a pmd binary]
    EOS
  end

  test do
    (testpath/"java/testClass.java").write <<~EOS
      public class BrewTestClass {
        // dummy constant
        public String SOME_CONST = "foo";

        public boolean doTest () {
          return true;
        }
      }
    EOS

    system "#{bin}/pmd", "pmd", "-d", "#{testpath}/java", "-R",
      "rulesets/java/basic.xml", "-f", "textcolor", "-l", "java"
  end
end
