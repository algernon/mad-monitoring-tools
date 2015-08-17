(import [dbus]
        [dbus.mainloop.glib]
        [mad-monitoring-tools.source.interface [MMTSource]])

(defclass SystemdJobSource [MMTSource]
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
                          "JobNew" (.make-callback self on-new)))
    (when on-removed
      (.connect-to-signal self.--iface--
                          "JobRemoved" (.make-callback self on-removed)))
    nil)

  (defn to-event [self job-id job unit &rest args]
    (setv event (.to-event (super SystemdJobSource self)))
    (.update event {:service (+ "systemd/" unit)
                    :metric 1
                    :state nil
                    :description nil})
    event))
