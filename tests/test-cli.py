# TODO: update or remove this file

from pypkg import cli
from pytest import raises


def test_main():
    cli.main([])

    with raises(SystemExit):
        cli.main(["-h"])


def test_exception(monkeypatch):
    def mock_run(opts):
        raise NotImplementedError

    monkeypatch.setattr(cli, "run", mock_run)

    with raises(SystemExit):
        cli.main([])

    with raises(NotImplementedError):
        cli.main(["--trace"])
