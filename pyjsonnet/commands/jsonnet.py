from pyjsonnet.commands.command_base import CommandBase, LoadVariables


class JsonnetCmd(CommandBase):
    output_default = 'json'
    name = 'jsonnet'
    help_message = "Compile the jsonnet source"

    def __init__(self, options):
        super(JsonnetCmd, self).__init__(options)
        self.variables = options.variables
        if isinstance(options.filepath, list):
            self.filepath = options.filepath[0]
        else:
            self.filepath = options.filepath
        self.result = {}

    @classmethod
    def _add_arguments(cls, parser):
        parser.add_argument(
            "-x",
            "--variables",
            help="variables",
            default={},
            action=LoadVariables)
        parser.add_argument('filepath', nargs=1, help="file to render")
        parser.add_argument(
            '-J',
            '--lib-dir',
            action='append',
            default=[],
            help="Specify additionals library search dir")

    def _call(self):
        from pyjsonnet.render_jsonnet import RenderJsonnet
        r = RenderJsonnet(manifestpath=self.filepath)
        tla_codes = self.variables
        p = open(self.filepath).read()
        self.result = r.render_jsonnet(p, tla_codes=tla_codes)

    def _render_dict(self):
        return self.result

    def _render_console(self):
        return self.result
