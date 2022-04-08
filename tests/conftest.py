"""
Common test stuff.
"""

# TODO: customize this file

import os
from pytest import fixture
from pypkg import __version__


def pytest_report_header(config):
    return "package: pypkg, version %s" % __version__


@fixture(autouse=True)
def setup(monkeypatch):
    "Global test setup."

    # Run tests from this directory.
    path = os.path.dirname(__file__)
    monkeypatch.chdir(path)
