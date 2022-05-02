# TODO: use or delete this

"""
Usage: {prog} [options]

Description:
    WRITE ME

Commands:
    WRITE ME

Arguments:
    WRITE ME

Options:
    WRITE ME

    --version      Print program version
    --trace        Print traceback on error
    --debug        Print debugging info
"""

import sys

from . import __program__, __version__
from .config import init_config
from .docopts import docopts
from .logger import init_log, log


def main(args=sys.argv[1:]):
    usage = __doc__.format(prog=__program__)
    version = f"{__program__} {__version__}"
    opts = docopts(usage, argv=args, version=version)

    try:
        run(opts)
    except Exception as exc:
        if opts.trace:
            raise
        else:
            sys.exit("%s: error: %s" % (__program__, str(exc)))


def run(opts):
    """
    Run a single command.
    """

    # Get configuration settings.
    config = init_config()

    # Set up logging.
    init_log()

    # TODO: add commands here
    log.info("write me")
    config.write(sys.stdout)


if __name__ == "__main__":
    main()
