#! /usr/bin/env hy
(import [mad-monitoring-tools.core [*]]
        [sys])
(require mad-monitoring-tools.core)

(defn arg->writer [arg]
  (cond
   [(or (= arg ":stdout")
        (= arg "stdout")) StdOutWriter]
   [(or (= arg ":riemann")
        (= arg "riemann")) RiemannWriter]
   [true StdOutWriter]))

(mmt/connect-> SystemdJobSource [:on-new]
               (arg->writer (second sys.argv)))

(mmt/run!)
