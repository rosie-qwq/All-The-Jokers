local function get_loc_vars(center, infoq)
  if center.name == "Negative Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.e_negative
  elseif center.name == "Foil Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.e_foil
  elseif center.name == "Holographic Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.e_holo
  elseif center.name == "Polychrome Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.e_polychrome
  elseif center.name == "Charm Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.p_arcana_mega_1
  elseif center.name == "Meteor Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.p_celestial_mega_1
  elseif center.name == "Ethereal Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.p_spectral_normal_1
  elseif center.name == "Standard Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.p_standard_mega_1
  elseif center.name == "Buffoon Tag" then
    infoq[#infoq + 1] = G.P_CENTERS.p_buffoon_mega_1
  end

  if center.loc_vars then
    return center:loc_vars(infoq, { name = center.name, config = center.config, ability = {} }).vars
  else
    return Tag.get_uibox_table({
      name = center.name,
      config = center.config,
      ability = { orbital_hand = "[" .. localize("k_poker_hand") .. "]" },
    }, nil, true)
  end
end

return {
  loc_vars = function(_, infoq)
    local last_tag = G.P_TAGS[G.GAME.tag_bplus_recycle_last_tag]
    local colour = last_tag and G.C.GREEN or G.C.RED
    local last_tag_name = last_tag and localize { type = "name_text", key = last_tag.key, set = "Tag" } or localize("k_none")

    if last_tag then
      local last_tag_infoq = {}
      local vars = get_loc_vars(last_tag, last_tag_infoq)
      infoq[#infoq + 1] = { key = last_tag.key, set = "Tag", specific_vars = vars or {} }
      for _, info in ipairs(last_tag_infoq) do
        infoq[#infoq + 1] = info
      end
    end

    return {
      main_end = {
        {
          n = G.UIT.C,
          config = { align = "bm", padding = 0.02 },
          nodes = {
            {
              n = G.UIT.C,
              config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
              nodes = {
                {
                  n = G.UIT.T,
                  config = {
                    text = " " .. last_tag_name .. " ",
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.3,
                    shadow = true,
                  },
                },
              },
            },
          },
        },
      },
    }
  end,

  apply = function(_, tag, ctx)
    if ctx.type == "immediate" then
      tag:yep("+", G.C.GREEN, function()
        local tag_key = G.GAME.tag_bplus_recycle_last_tag
        if tag_key then
          local last_tag = Tag(tag_key)
          add_tag(last_tag)
          last_tag:apply_to_run { type = "immediate" }
        end
        return true
      end)
      tag.triggered = true
      return true
    end
  end,
}
