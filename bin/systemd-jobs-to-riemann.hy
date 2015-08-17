#! /usr/bin/env hy
(import [mad-monitoring-tools.source.systemd-jobs [SystemdJobSource]]
        [mad-monitoring-tools.writer.riemann [RiemannWriter]]
        [mad-monitoring-tools.core [*]])
(require mad-monitoring-tools.macros)

(mmt/connect-> SystemdJobSource [:on-new]
               RiemannWriter)

(mmt-run)
