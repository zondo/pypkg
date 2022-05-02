# TODO: update or remove this file

from pypkg.cli import main
from pytest import raises


def test_main():
    main([])

    with raises(SystemExit):
        main(["-h"])
