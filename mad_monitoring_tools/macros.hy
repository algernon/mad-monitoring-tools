(defmacro mmt/connect-> [source signals writer]
  (setv kwargs [])
  (for [signal signals]
    (.extend kwargs `[~signal handler]))
  (setv src `(~source ~@kwargs))
  `(let [[writer (~writer)]
         [handler (.create-handler writer)]]
     ~src))
