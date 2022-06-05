# TODO: update or remove this file

from pytest import raises
from pypkg import cli


def test_main():
    cli.main([])

    with raises(SystemExit):
        cli.main(["-h"])


def test_schema():
    with raises(SystemExit, match="input file not found"):
        cli.main(["nosuchfile"])


def test_exception(mocker):
    mocker.patch("pypkg.cli.run", side_effect=NotImplementedError)

    with raises(SystemExit):
        cli.main([])

    with raises(NotImplementedError):
        cli.main(["--trace"])
