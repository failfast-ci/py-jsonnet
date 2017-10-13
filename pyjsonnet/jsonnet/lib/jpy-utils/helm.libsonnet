{

        // uses app-registry
        upgrade(name, appname, namespace="default", vars={}, extra_opts=[]):: [
            local set_opts = [
                "--set %s=%s" % [key, vars[key]]
                for key in std.objectFields(vars)
            ];

            std.join(" ", [
                              "helm registry upgrade %s -- --install %s" % [name, appname],
                              "--namespace=%s" % namespace,
                          ] +
                          set_opts +
                          extra_opts),
        ],
}
