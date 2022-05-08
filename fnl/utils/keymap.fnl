(local set-key! vim.keymap.set)

(lambda doc-key! [lhs desc]
  (let [{: register} (require "which-key")]
    (register {lhs desc})))

{: set-key!
 : doc-key!}
