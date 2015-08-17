(defclass MMTWriter [object]
  (defn create-handler [self]
    (fn [event]
      (.write self event))))
