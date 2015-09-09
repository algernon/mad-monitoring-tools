Mad Monitoring Tools
====================

There are some parts of my systems that [collectd][collectd] does not
yet monitor, and where writing a collectd plugin would be more work
than doing it externally. This here, is a collection of tools that can
aid in keeping an eye on these parts of a system.

Components
----------

### SystemdJobSource

A `SystemdJobSource` triggers whenever a systemd job gets added or
removed from its task list. It is a very simple source, that generates
an event where the service name is the unit's name prefixed with
`systemd/`, and a metric of one.

The primary goal is to notice service restarts, and be able to have a
running count of them.

### RiemannWriter

Sends an event to Riemann. Simple as that.

### StdOutWriter

Writes the event - serialized to JSON - to standard output.

Usage
-----

```hy
(import [mad-monitoring-tools.core [*]])
(require mad-monitoring-tools.core)

(mmt/connect-> SystemdJobSource [:on-new]
               StdOutWriter)

(mmt/run!)
```

License
-------

Copyright (C) 2015 Gergely Nagy, released under the terms of the
[GNU General Public License][gpl], version 3+.

 [gpl]: http://www.gnu.org/licenses/gpl.html
