#! /usr/bin/env hy
(import [dbus.mainloop.glib]
        [gobject]
        [mad-monitoring-tools.source.systemd-jobs [SystemdJobSource]]
        [mad-monitoring-tools.writer.riemann [RiemannWriter]])

(.DBusGMainLoop dbus.mainloop.glib :set-as-default true)

(defn sd-job-to-event [jid job unit]
  {:host "localhost"
   :metric 1
   :service (+ "systemd/" unit)
   :description nil
   :state nil})

(defn sd-job-to-riemann [writer jid job unit]
  (.write writer (sd-job-to-event jid job unit)))

(defn create-cb [writer]
  (fn [jid job unit]
    (sd-job-to-riemann writer jid job unit)))

(def writer (RiemannWriter))
(def source (SystemdJobSource :on-new (create-cb writer)))

(.run (.MainLoop gobject))
