class Praisonai < Formula
    include Language::Python::Virtualenv
  
    desc "AI tools for various AI applications"
    homepage "https://github.com/MervinPraison/PraisonAI"
    url "https://github.com/MervinPraison/PraisonAI/archive/refs/tags/0.0.57.tar.gz"
    sha256 "1828fb9227d10f991522c3f24f061943a254b667196b40b1a3e4a54a8d30ce32"  # Replace with actual SHA256 checksum
    license "MIT"
  
    depends_on "python@3.10"
    depends_on "poetry"

    def install
        # Create a virtual environment
        venv = virtualenv_create(libexec, "python3.10")
    
        # Install poetry inside the virtual environment
        venv.pip_install "poetry"
    
        # Use poetry to install dependencies and the package
        system libexec/"bin/poetry", "install", "--no-dev", "--no-interaction", "--no-root"
    
        # Install the package itself
        system libexec/"bin/pip", "install", "."
    
        # Symlink the binaries
        bin.install Dir[libexec/"bin/*"]
        bin.env_script_all_files(libexec/"bin", PATH: "#{libexec}/bin:$PATH")
    end
    
    test do
        system "#{bin}/praisonai", "--version"
    end
end