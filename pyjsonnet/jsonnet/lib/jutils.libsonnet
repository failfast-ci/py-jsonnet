{
    local this = self,
    // NativeExt works only with the jsonnetpy client
    // Extensions are developped in python
    nativeExt: import "jpy-utils/native_extensions.libsonnet",

    // General purpose methods
    extStd: import "jpy-utils/extended_std.libsonnet",

    // K8s provides helpers wrapping kubectl commands (k8s.io)
    k8s: import "jpy-utils/k8s.libsonnet",

    // Wrapping docker commands
    docker: import "jpy-utils/docker.libsonnet",

    // Helpers to generate a .gitlab-ci.yml (gitlab.com)
    gitlabCi: import "jpy-utils/gitlab-ci.libsonnet",

    // Helm wrapper (github.com/kubernetes/helm)
    helm: import "jpy-utils/helm.libsonnet",

    // App-registry wrapper (github.com/app-registry/appr
    appr: import "jpy-utils/appr.libsonnet",

    testUtils: import "jpy-utils/tests_utils.libsonnet",

    __tests__: self.testUtils.runTests(this),
}
