# TODO: update or remove this file

from pypkg.config import init_config


def test_config():
    config = init_config("test-config.cfg")
    assert config.getint("test", "value") == 47
