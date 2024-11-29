{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "pdf-toc";
  version = "1.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "HareInWeed";
    repo = "pdf-toc";
    rev = "v${version}";
    hash = "sha256-1GQcP7LQ+tbM1k6LnjxaTGQGFJNkNlV7E++fw1XdhMs=";
  };

  build-system = with python3Packages; [
    setuptools
    wheel
    pymupdf
  ];

  propagatedBuildInputs = [ python3Packages.pymupdf ];

  nativeCheckInputs = with python3Packages; [
    # tox
    pymupdf
    pytest
    pytest-console-scripts
    pytest-datadir
    pytestCheckHook
  ];

  disabledTests = [
    "tests"
    # touches network
    "test_toc_pipe"
    "test_toc_show"
    "test_toc_write"
  ];

  # pythonImportsCheck = [ "pdf_toc" ];

  meta = with lib; {
    description = "A CLI tool to easily extract / edit ToC(Table of Content, or bookmark) of pdf file";
    homepage = "https://github.com/HareInWeed/pdf-toc";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dansbandit ];
    mainProgram = "pdf-toc";
  };
}
