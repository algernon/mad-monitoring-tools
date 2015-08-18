#! /usr/bin/env hy
(import [mad-monitoring-tools.core [*]])
(require mad-monitoring-tools.core)

(mmt/connect-> SystemdJobSource [:on-new]
               RiemannWriter)

(mmt/run!)
