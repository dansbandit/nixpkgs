{ lib
, fetchFromGitHub
, buildPythonApplication
, pymupdf
, pytest
, pytest-console-scripts
, pytest-datadir
, pytest-subprocess
, pytestCheckHook
, setuptools
, tox
, wheel
}:

buildPythonApplication rec {
  pname = "pdf-toc";
  version = "1.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "HareInWeed";
    repo = "pdf-toc";
    rev = "v${version}";
    hash = "sha256-1GQcP7LQ+tbM1k6LnjxaTGQGFJNkNlV7E++fw1XdhMs=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
    pymupdf
  ];

  propagatedBuildInputs = [
    pymupdf
  ];

  nativeCheckInputs = [
    tox
    pymupdf
    pytest
    pytest-console-scripts
    pytest-datadir
    pytestCheckHook
  ];

  pythonImportsCheck = [ "pdf-toc" ];

  meta = with lib; {
    description = "A CLI tool to easily extract / edit ToC(Table of Content, or bookmark) of pdf file";
    homepage = "https://github.com/HareInWeed/pdf-toc";
    license = licenses.mit;
    maintainers = with maintainers; [ dansbandit ];
    mainProgram = "pdf-toc";
  };
}
