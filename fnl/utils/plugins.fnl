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

(λ pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (if (not (str? identifier))
      (format "expected string for identifier=||" identifier))

  (if (not (and (nil? ?options) (tbl? ?options)))
      (format "expected nil or table for options: identifier=|%s|, options=|%s|"
              identifier ?options))

  (doto (or ?options {})
    (tset 1 identifier)))

(λ use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global variable pkgs"
  (insert _G.pkgs (pack identifier ?options)))

(fn unpack! []
  "Initializes packer with the previously declared plugins"
  (let [packer (require :packer)]
     (packer.startup (lambda [use] (unpack (icollect [_ v (ipairs pkgs)]
                                                     (use v)))))))

{: pack
 : unpack!
 : use-package!}
