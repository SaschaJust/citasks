# -*- coding: utf-8 -*-

from setuptools import setup

TEST_REQUIREMENTS = [
    'nose>=1.3',
    'coverage'
]

setup(tests_require=TEST_REQUIREMENTS,
      extras_require={
          'test': TEST_REQUIREMENTS
      },
      test_suite='nose.collector')
