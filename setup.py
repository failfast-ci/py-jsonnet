#!/usr/bin/env python
# -*- coding: utf-8 -*-


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


with open('README.md') as readme_file:
    readme = readme_file.read()

requirements = [
    'futures',
    'pyyaml',
    'jsonnet',
    'jinja2>=2.8',
]

test_requirements = [
    "pytest",
    "coverage",
    "pytest-sugar",
    "pytest-cov",
    "pytest-ordering",
    "requests-mock"
]

setup(
    name='pyjsonnet',
    version='0.0.2',
    description="pyjsonnet",
    long_description=readme,
    author="Antoine Legrand",
    author_email='2t.antoine@gmail.com',
    url='https://github.com/ant31/pyjsonnet',
    packages=[
        'pyjsonnet',
        'pyjsonnet.commands',
    ],
    scripts=['bin/pyjsonnet'],
    package_dir={'pyjsonnet':
                 'pyjsonnet'},
    include_package_data=True,
    install_requires=requirements,
    license="Apache License version 2",
    zip_safe=False,
    keywords=['pyjsonnet'],
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.7',
    ],
    test_suite='tests',
    tests_require=test_requirements,
)
