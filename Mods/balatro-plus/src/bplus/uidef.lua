function BPlus.mod.config_tab()
  local nodes = {}
  local w = 4
  local scale = 0.8
  for _, ui in ipairs(BPlus.config_ui) do
    if ui.type == "toggle" then
      nodes[#nodes + 1] = create_option_cycle {
        w = w,
        scale = scale,
        label = ui.label,
        options = { "On", "Off" },
        opt_callback = "bplus_mod_config_" .. ui.mod_config,
        current_option = BPlus.config[ui.mod_config] and 1 or 2,
      }
    end
  end
  return {
    n = G.UIT.ROOT,
    config = { padding = 0.05, align = "cm", colour = G.C.CLEAR },
    nodes = nodes,
  }
end
