(import [socket])

(defclass MMTSource [object]
  (defn to-event [&rest args]
    {:host (.gethostname socket)})

  (defn make-callback [self cb]
    (fn [&rest args]
      (setv event (apply self.to-event args))
      (cb event))))


