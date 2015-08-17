(import [dbus]
        [dbus.mainloop.glib])

(defclass SystemdJobSource [object]
  "A DBus source, that monitors systemd jobs."
  (defn --init-- [self &optional on-new on-removed]
    "Sets up a new subscriber to systemd job events. `on-new` and
  `on-removed` get called when a new job gets added or removed,
  respectively. Both callbacks are optional."

    (setv self.--bus--   (.SystemBus dbus)
          self.--proxy-- (.get-object self.--bus--
                                      "org.freedesktop.systemd1"
                                      "/org/freedesktop/systemd1")
          self.--iface-- (.Interface dbus
                                     self.--proxy--
                                     "org.freedesktop.systemd1.Manager"))
    (.Subscribe self.--iface--)
    (when on-new
      (.connect-to-signal self.--iface--
                          "JobNew" on-new))
    (when on-removed
      (.connect-to-signal self.--iface--
                          "JobRemoved" on-removed))
    nil))
