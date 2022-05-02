======================================
 pypkg -- a bare-bones python package
======================================

This is an outline of the kind of python package I usually make.  Use it as
a starting point, replacing ``pypkg`` throughout, or just steal the bits
you like.  Summary of features:

* A ``README`` in reStructuredText format, with auto-conversion to
  ``README.md`` for places that only handle markdown (e.g., github,
  sourcehut).

* Prepopulated ``setup.cfg`` with the most common entries.

* Requirement pinning in the ``conf`` directory.

* A ``Makefile`` for handling common targets (development, testing, upload
  to PyPI), with cute self-documenting help gimmick.

For best results, you'll need to install several python packages
(pip-tools, build, twine, flake8, mypy) and pandoc.

A doctest to see if python is working::

    >>> 2 + 2
    4
