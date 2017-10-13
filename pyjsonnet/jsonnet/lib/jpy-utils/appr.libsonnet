{

        login(server, user, password):: [
            "appr login -u %s -p %s %s" % [user, password, server],
        ],

        push(name, channel=null, force=false):: [
            std.join(" ",
                     ["appr push %s" % name] +
                     if channel != null then ["--channel %s" % channel] else [] +
                                                                             if force == true then ["-f"] else []),
        ],

    }
