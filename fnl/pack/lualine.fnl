{:url "https://github.com/nvim-lualine/lualine.nvim.git"
 :opts {:options {:icons_enabled true
                  :theme "catppuccin"
                  :component_separators {:left "" :right ""}
                  :section_separators   {:left "" :right ""}
                  :disabled_filetypes {}
                  :always_divide_middle true
                  :globalstatus true}
        :sections {:lualine_a ["branch"]
                   :lualine_b ["b:gitsigns_status" "diagnostics"]
                   :lualine_c ["filename"]
                   :lualine_x ["encoding" "fileformat" "filetype"]
                   :lualine_y ["progress"]
                   :lualine_z ["location"]}
        :inactive_sections {:lualine_a []
                            :lualine_b []
                            :lualine_c ["filename"]
                            :lualine_x ["location"]
                            :lualine_y []
                            :lualine_z []}
        :tabline {:lualine_a ["tabs"]
                  :lualine_b []
                  :lualine_c []
                  :lualine_x []
                  :lualine_y []
                  :lualine_z ["b:gitsigns_status_dict.root"]}
        :extensions ["fugitive" "toggleterm"]}}
