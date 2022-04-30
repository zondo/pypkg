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
from .docopts import docopts
from .logger import log, log_init


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
    """Run a command.
    """

    log_init()

    if opts.debug:
        print(opts)

    # TODO: add commands here
    log.info("write me")


if __name__ == "__main__":
    main()
