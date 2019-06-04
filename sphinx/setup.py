# -*- coding: utf-8 -*-

from setuptools import setup

DOC_REQUIREMENTS = [
    'sphinx',
    'recommonmark',
    'sphinx_rtd_theme',
    'doc8',
    'm2r'
]

setup(extras_require={
    'docs': DOC_REQUIREMENTS
})
