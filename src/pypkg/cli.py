# TODO: use or delete this

"""
Usage: {prog} [options]

Description:
    TODO: WRITE ME

Commands:
    TODO: WRITE ME

Arguments:
    TODO: WRITE ME

Options:
    TODO: WRITE ME

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
    opts = docopts(usage, argv=args, program=__program__, version=__version__)

    try:
        run(opts)
    except Exception as exc:
        if opts.trace:
            raise
        else:
            sys.exit(f"{__program__}: error: {str(exc)}")


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
