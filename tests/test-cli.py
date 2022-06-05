# TODO: update or remove this file

from schema import SchemaError
from pytest import raises
from pypkg import cli


def test_main():
    cli.main([])

    with raises(SystemExit):
        cli.main(["-h"])


def test_schema():
    with raises(SystemExit) as exc:
        cli.main(["nosuchfile"])

    assert "input file not found" in str(exc.value)


def test_exception(mocker):
    mocker.patch("pypkg.cli.run", side_effect=NotImplementedError)

    with raises(SystemExit):
        cli.main([])

    with raises(NotImplementedError):
        cli.main(["--trace"])
