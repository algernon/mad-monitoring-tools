(import [dbus.mainloop.glib]
        [gobject]

        [mad-monitoring-tools.source.systemd-jobs [SystemdJobSource]]
        [mad-monitoring-tools.writer.riemann [RiemannWriter]])

(.DBusGMainLoop dbus.mainloop.glib :set-as-default true)

(defn mmt-run []
  (.run (.MainLoop gobject)))

(defmacro mmt/connect-> [source signals writer]
  (setv kwargs [])
  (for [signal signals]
    (.extend kwargs `[~signal handler]))
  (setv src `(~source ~@kwargs))
  `(let [[writer (~writer)]
         [handler (.create-handler writer)]]
     ~src))
