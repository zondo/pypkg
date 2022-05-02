"""
Configuration stuff.
"""

# TODO: use or remove this

import configparser as cp
from pathlib import Path

from . import __program__


def init_config(*files, suffix="cfg"):
    """
    Return package configuration settings.
    """

    filenames = []
    configname = f"{__program__}.{suffix}"

    # Add internal config file.
    dirname = Path(__file__).parent
    filenames.append(dirname / f"config.{suffix}")

    # Add config file in user home directory.
    filenames.append(Path.home() / f".{configname}")

    # Add package config file in current directory.
    filenames.append(configname)

    # Add other specific files.
    filenames.extend(files)

    # Create parser.
    parser = cp.ConfigParser()
    parser.read(filenames)

    # Make it case-sensitive.
    parser.optionxform = str

    return parser
