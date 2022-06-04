"""
Docopt wrapper.
"""

import re
import sys

from docopt import docopt
from schema import Schema, SchemaError


class docopts(object):
    """Improved docopt front end.

    - Allow access via attributes as well
    - Apply schema validation
    """

    def __init__(self, *args, **kw):
        # Get program name and version.
        program = kw.pop("program")
        version = kw.pop("version")

        # Get option schema.
        schema = kw.pop("schema", {})

        # Pass rest of args to docopt.
        opts = docopt(*args, version=f"{program} {version}", **kw)

        # Validate options.
        try:
            s = Schema(schema, ignore_extra_keys=True)
            validopts = s.validate(opts)
        except SchemaError as exc:
            errlist = [e for e in exc.errors if e]
            err = "; ".join(errlist) if errlist else str(exc)
            sys.exit(f"{program}: error: {err}")

        # Merge validated options back in.
        opts.update(validopts)

        # Convert options to attributes.
        self._opts = {}
        for opt, value in opts.items():
            attr = re.sub(r"^-+", "", opt).replace("-", "_")
            self._opts[attr] = value

    def __getattr__(self, attr):
        return self._opts[attr]

    def __repr__(self):
        args = ["%s=%r" % elt for elt in sorted(self._opts.items())]
        return "<docopts: %s>" % " ".join(args)
