# Generated by requirements.py -- do not edit!

requirements-dev.txt: requirements-dev.in requirements-test.txt
requirements-test.txt: requirements-test.in constraints.txt
requirements.txt: requirements.in requirements-test.txt
