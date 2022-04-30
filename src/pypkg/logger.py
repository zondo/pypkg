"""
Logging stuff.
"""

import logging

from . import __program__

# The logging object.
log = logging.getLogger(__program__)

# Add a null handler.
log.addHandler(logging.NullHandler())


def log_init(loglevel=None):
    # Add a stderr handler.
    handler = logging.StreamHandler()
    log.addHandler(handler)

    # Set the log message format.
    fmt = '%(name)s: %(levelname)s: %(message)s'
    formatter = logging.Formatter(fmt)
    handler.setFormatter(formatter)

    # Set log level.
    if loglevel is None:
        loglevel = logging.INFO

    log.setLevel(loglevel)
