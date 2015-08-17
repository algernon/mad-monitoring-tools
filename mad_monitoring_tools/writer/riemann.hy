(import [riemann-client.client]
        [mad-monitoring-tools.writer.interface [MMTWriter]])

(defclass RiemannWriter [MMTWriter]
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
