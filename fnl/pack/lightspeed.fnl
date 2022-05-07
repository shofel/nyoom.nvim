((. (require :lightspeed) :setup)
 {:ignore_case false
  :exit_after_idle_msecs {:labeled nil
                          :unlabeled 1500}
  ; s/x
  :jump_to_unique_chars true
  :match_only_the_start_of_same_char_seqs true
  :substitute_chars { "\r" "¬" }
  ; Leaving the appropriate list empty effectively disables
  ; "smart" mode, and forces auto-jump to be on or off.
  :safe_labels nil
  :labels nil

  ; f/t
  :limit_ft_matches 4
  :repeat_ft_with_target_char false})
