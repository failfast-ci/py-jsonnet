{
        local Docker = self,

       containerName(repo, tag):: "%s:%s" % [repo, tag],

        login(server, user, password):: [
            "docker login -u %s -p %s %s" % [user, password, server],
        ],

        cp(image, src, dest):: [
            "docker create %s | xargs -I{} docker cp {}:%s %s" % [image, src, dest],
        ],

        run(image, cmd, opts=[]):: [
            local optstr = std.join(" ", opts);
            'docker run %s %s %s' % [optstr, image, cmd],
        ],

        build_and_push(image, cache=true, args={}, extra_opts=[]):: (
            Docker.build(image, cache, args, extra_opts) +
            Docker.push(image)
        ),

        build(image, cache=true, args={}, extra_opts=[]):: [
            local cache_opt = if cache == false
            then '--no-cache'
            else if std.type(cache) == 'boolean'
            then '--no-cache'
            else '--cache-from=%s' % cache;
            local buildargs_opt = std.join(" ", [
                "--build-arg %s=%s" % [key, args[key]]
                for key in std.objectFields(args)
            ]);
            local opts = std.join(" ", [buildargs_opt, cache_opt] + extra_opts);
            'docker build %s -t %s . ' % [opts, image],
        ],

        push(image):: [
            'docker push %s' % image,
        ],

        rename(src, dest):: [
            'docker pull %s' % src,
            'docker tag %s %s' % [src, dest],
            'docker push %s' % [dest],
        ],

    }
