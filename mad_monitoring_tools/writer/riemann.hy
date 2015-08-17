(import [riemann-client.client])

(defclass RiemannWriter [object]
  (defn --init-- [self]
    (setv self.--writer-- (.Client riemann-client.client))
    (.connect self.--writer--.transport)
    nil)

  (defn write [self event]
    (.event self.--writer--
            :service (:service event)
            :metric_sint64 (:metric event)
            :description (:description event)
            :host (:host event)
            :state (:state event))))
