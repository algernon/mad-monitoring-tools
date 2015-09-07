(import [mad-monitoring-tools.writer.interface [MMTWriter]]
        [json]
        [hy [HyKeyword]])

(defclass StdOutWriter [MMTWriter]
  (defn hy->python [self e]
    (setv new-event {})
    (for [(, k v) (.iteritems e)]
      (assoc new-event (+ ":" (name k)) v))
    new-event)

  (defn write [self event]
    (print (.dumps json (.hy->python self event)))))
