{
        createNamespace(name):: [
            "kubectl create ns %s" % name + " || true",
        ],

        createPullSecret(name, namespace, server, user, password):: [
            std.join(" ",
                     [
                         "kubectl create secret docker-registry %s" % name,
                         "--docker-server %s" % server,
                         "--docker-username %s" % user,
                         "--docker-password %s" % password,
                         "--docker-email ignored@example.com",
                         "--namespace=%s" % namespace,
                         "|| true",
                     ]),
        ],

        get(type, name, namespace, extra_opts=[]):: [
            "kubectl get %s %s -n %s %s" % [
                type,
                name,
                namespace,
                std.join(" ", extra_opts),
            ],
        ],

        apply(filepath, namespace=null, extra_opts=[]):: [
            std.join(
                " ",
                ["kubectl apply -f %s" % filepath] +
                if namespace != null then ["--namespace %s" % namespace] else [] +
                                                                              extra_opts
            ),
        ],

}
