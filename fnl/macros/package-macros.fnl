(local {: format} string)
(local {: insert} table)

(global pkgs [])

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= nil x))

(fn lazy-require [module]
  "Load a module when it's needed"
  `(let [meta# {:__index #(. (require ,module) $2)}
         ret# {}]
     (setmetatable ret# meta#)
     ret#))

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  (format "expected nil or table for options: identifier=|%s|, options=|%s|"
                          identifier ?options))
  (let [options (collect [k v (pairs (or ?options {}))]
                  (if (= k :config-file)
                      (values :config (format "require('pack.%s')" v))
                      (= k :setup)
                      (values :config (format "require('%s').setup()" v))
                      (values k v)))]
    (doto options
      (tset 1 identifier))))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global compile-time variable pkgs"
  (insert pkgs (pack identifier ?options)))

(fn unpack! []
  "Initializes packer with the previously declared plugins"
  (let [packer   (require :packer)
        packages (icollect [_ v (ipairs pkgs)]
                   `(packer.use ,v))]
    `(packer.startup #(do
                                        ,(unpack (icollect [_ v (ipairs packages)]
                                                   v))))))

{: pack
 : unpack!
 : use-package!
 : lazy-require}
