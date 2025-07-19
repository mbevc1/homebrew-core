class AwsSsm < Formula
  desc "CLI utility for managing YAML ↔ AWS SSM Parameter Store"
  homepage "https://github.com/mbevc1/aws-ssm"
  url "https://github.com/mbevc1/aws-ssm/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "acb9604487088432842b7b9b01407b0822d1a19f7c8277259de9751c13ae9a68"
  license "MPL-2.0"
  head "https://github.com/mbevc1/aws-ssm.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    system "make", "build", "VERSION=#{version}-#{tap.user}"
    mkdir bin
    cp "aws-ssm", bin
  end

  test do
    assert_match("Error: --prefix is required",
      shell_output("#{bin}/aws-ssm save 2>&1", 1))

    assert_match version.to_s, shell_output("#{bin}/aws-ssm --version 2>&1")
  end
end
