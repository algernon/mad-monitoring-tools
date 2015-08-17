(import [dbus.mainloop.glib]
        [gobject])

(.DBusGMainLoop dbus.mainloop.glib :set-as-default true)

(defn mmt-run []
  (.run (.MainLoop gobject)))
