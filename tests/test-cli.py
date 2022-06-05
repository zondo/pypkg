# TODO: update or remove this file

from pytest import raises
from pypkg import cli


def test_main(capsys):
    cli.main([])
    captured = capsys.readouterr()
    assert "write me" in captured.err


def test_usage(capsys):
    with raises(SystemExit):
        cli.main(["-h"])
        captured = capsys.readouterr()
        assert "Usage:" in captured.out


def test_error():
    with raises(SystemExit, match="input file not found"):
        cli.main(["nosuchfile"])


def test_exception(mocker):
    mocker.patch("pypkg.cli.run", side_effect=NotImplementedError)

    with raises(SystemExit):
        cli.main([])

    with raises(NotImplementedError):
        cli.main(["--trace"])
