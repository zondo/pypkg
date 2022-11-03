# pypkg -- a bare-bones python package

This is an outline of the kind of python package I usually make. Use it
as a starting point, replacing `pypkg`{.verbatim} throughout, or just
steal the bits you like. Summary of features:

-   A `README`{.verbatim} in [Org](https://orgmode.org/) format, with
    auto-conversion to reStructuredText and Markdown.

-   Prepopulated `setup.cfg`{.verbatim} with the most common entries.

-   Requirement pinning in the `conf`{.verbatim} directory.

-   A `Makefile`{.verbatim} for handling common targets (development,
    testing, upload to PyPI), with cute self-documenting help gimmick.

For best results, you\'ll need to install several python packages
(pip-tools, build, twine, flake8, mypy).

A doctest to see if python is working:

``` example
>>> 2 + 2
4
```
