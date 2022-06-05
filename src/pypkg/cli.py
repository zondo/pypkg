# TODO: update or delete this

"""
Usage: {prog} [options] [FILE]

Description:
    TODO: WRITE ME

Arguments:
    FILE           Input file

Output options:
    -o FILE        Write to specified file instead of stdout

Other options:
    --version      Print program version
    --trace        Print traceback on error
    --debug        Print debugging info
"""

import sys

from schema import Or, Use

from . import __program__, __version__

from .config import init_config
from .docopts import docopts
from .logger import init_log, log

schema = {
    "FILE": Or(None, Use(open, error="input file not found")),
    "-o": Use(lambda f: open(f, "w") if f else sys.stdout),
}


def main(args=sys.argv[1:]):
    usage = __doc__.format(prog=__program__)
    opts = docopts(usage, argv=args, schema=schema,
                   program=__program__, version=__version__)

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
