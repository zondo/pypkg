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
        # Get option schema.
        schema = kw.pop("schema", {})

        # Pass rest of args to docopt.
        opts = docopt(*args, **kw)

        # Validate options.
        try:
            s = Schema(schema, ignore_extra_keys=True)
            validopts = s.validate(opts)
        except SchemaError as exc:
            sys.exit("Error: " + str(exc))

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
