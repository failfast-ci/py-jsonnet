#!/usr/bin/env python
from __future__ import print_function
import argparse
import os
import sys

from pyjsonnet.commands.command_base import CommandBase
from pyjsonnet.commands.jsonnet import JsonnetCmd
from pyjsonnet.commands.version import VersionCmd


def set_default_subparser(self, name, args=None):
    """default subparser selection. Call after setup, just before parse_args()
    name: is the name of the subparser to call by default
    args: if set is the argument list handed to parse_args()

    , tested with 2.7, 3.2, 3.3, 3.4
    it works with 2.6 assuming argparse is installed
    """
    subparser_found = False
    for arg in sys.argv[1:]:
        if arg in ['-h', '--help']:  # global help if no subparser
            break
    else:
        for x in self._subparsers._actions:
            if not isinstance(x, argparse._SubParsersAction):
                continue
            for sp_name in x._name_parser_map.keys():
                if sp_name in sys.argv[1:]:
                    subparser_found = True
        if not subparser_found:
            # insert default in first position, this implies no
            # global options without a sub_parsers specified
            if args is None:
                sys.argv.insert(1, name)
            else:
                args.insert(0, name)


argparse.ArgumentParser.set_default_subparser = set_default_subparser


def all_commands():
    base_cmd = {}
    for cmd in base_cmd.values():
        cmd.__bases__ = (CommandBase, )

    base_cmd.update({
        VersionCmd: VersionCmd,
        JsonnetCmd.name: JsonnetCmd,
    })
    return base_cmd


def get_parser(commands):
    parser = argparse.ArgumentParser()

    subparsers = parser.add_subparsers(help='command help')
    for command_class in commands.values():
        command_class.add_parser(subparsers)
    parser.set_default_subparser('jsonnet')
    return parser


def cli():
    try:
        parser = get_parser(all_commands())
        unknown = None
        args, unknown = parser.parse_known_args()
        if args.parse_unknown:
            args.func(args, unknown)
        else:
            args = parser.parse_args()
            args.func(args)

    except (argparse.ArgumentTypeError, argparse.ArgumentError) as exc:
        if os.getenv("JSONNETCLI_DEBUG", "false") == "true":
            raise
        else:
            print(exc.message)
