{ buildPythonPackage, fetchPypi, lib, orjson, pandas, poetry-core
, pytestCheckHook, pytest-mock, pythonOlder, python-dateutil, requests, typer
, websocket-client }:

buildPythonPackage rec {
  pname = "coinmetrics-api-client";
  version = "2022.11.14.16";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-2x8S9Jj/1bBnhXS/x0lQ8YUQkCvfpgGcDSQU2dGbAn0=";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
    orjson python-dateutil requests typer websocket-client
  ];

  checkInputs = [
    pandas
    pytestCheckHook
    pytest-mock
  ];

  pythonImportsCheck = [ "coinmetrics.api_client" ];

  passthru = {
    optional-dependencies = {
      pandas = [ pandas ];
    };
  };

  meta = with lib; {
    homepage = "https://coinmetrics.github.io/api-client-python/site/index.html";
    description = "Coin Metrics API v4 client library (Python)";
    license = licenses.mit;
    maintainers = with maintainers; [ centromere ];
  };
}
