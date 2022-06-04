# TODO: update or remove this file

from pypkg import cli
from pytest import raises


def test_main():
    cli.main([])

    with raises(SystemExit):
        cli.main(["-h"])


def test_exception(mocker):
    mocker.patch("pypkg.cli.run", side_effect=NotImplementedError)

    with raises(SystemExit):
        cli.main([])

    with raises(NotImplementedError):
        cli.main(["--trace"])
