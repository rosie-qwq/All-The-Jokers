-- steamodded wtf why was i not told about this

SMODS.current_mod.ui_config = {
    colour = G.C.AKYRS_HAIR_DARK, -- Main UI box
    bg_colour = G.C.AKYRS_AIKOYORI_BG, -- Background
    back_colour = G.C.AKYRS_AIKOYORI_CARDIGAN, -- Back button
    tab_button_colour = G.C.AKYRS_AIKOYORI_BOW_SHADE, -- Tabs buttons
    outline_colour = G.C.AKYRS_AIKOYORI_HAIR, -- Main UI box outline
    author_colour = G.C.AKYRS_AIKOYORI_HAIR, -- Author text
    author_bg_colour = G.C.AKYRS_HAIR_DARKER, -- Author box background
    author_outline_colour = G.C.AKYRS_AIKOYORI_BOW, -- Author box outline
    collection_bg_colour = G.C.AKYRS_AIKOYORI_BG,
    collection_back_colour = G.C.AKYRS_AIKOYORI_CARDIGAN, -- Collection background (Defaults to back_colour)
    collection_outline_colour = G.C.AKYRS_AIKOYORI_HAIR, -- Collection background (Defaults to outline_colour)
    collection_option_cycle_colour = G.C.AKYRS_AIKOYORI_BOW_SHADE, -- Collection option cycle button
}

SMODS.current_mod.extra_tabs = function()
  return {
    --[[
    {
      label = localize("k_akyrs_credits"),
    },
    ]]
    {
      label = localize("k_akyrs_solitaire"),
      tab_definition_function = AKYRS.SOL.get_UI_definition
    },
  }
end

AKYRS.create_credits = function(sprite_atlas, name, width)
  local cards_print = AKYRS.word_to_cards(name)

  return {
    n = G.UIT.R,
    config = {minw = 1, maxw = 1, minh = 1, maxh = 1, },
    nodes = {
      {
        n = G.UIT.C,
        config = { minw = 1, maxw = 1, minh = 1, maxh = 1, align = "cm" },
        nodes = {
          AKYRS.embedded_ui_sprite(sprite_atlas, { x = 0, y = 0 }, nil, {
            w = 200,
            h = 200,
            manual_scale = 180,
            fxh = 1,
            fxw = 1,
            padding = 0,
            rounded = 0.5
          }),
        }
      },
      {
        n = G.UIT.C,
        config = { w = 4, minh = 1.4, align = "tl" },
        nodes = {
          AKYRS.card_area_preview(G.creditCardArea, nil, {
            cards = cards_print,
            h = 0.3,
            w = width,
            ml = 0,
            override = true,
            scale = 0.5,
            type = "akyrs_credits",
          }),
        }
      },
    }
  }
end

SMODS.current_mod.custom_ui = function (mod_nodes)
  mod_nodes = EMPTY(mod_nodes)
  local tg = G.ROOM
  ---@type Card
  local aikocard = Card(tg.T.x,tg.T.y,G.CARD_W,G.CARD_H,nil,G.P_CENTERS['j_akyrs_aikoyori'], { bypass_discovery_center = true, bypass_discovery_ui = true })
  aikocard.ambient_tilt = 0
  local cards1 = {
    aikocard
  }
  local node1 = {
    n = G.UIT.C,
    config = { w = 8, align = "tm", r = 0.1 , h = 6, padding = 0.2, colour = G.C.AKYRS_HAIR_DARKER},
    nodes = {
      {
        n = G.UIT.R,
        config = { align = "tm" },
        nodes = {
          { n = G.UIT.O, config = { object = 
          DynaText{
            string = localize("k_akyrs_title"), 
            scale = 1, 
            colours = {SMODS.Gradients["akyrs_mod_title"]},
            pop_in = 0.1,
            float = 1,
            bump_rate = 10,
            text_effect = 'akyrs_rainbow_wiggle',
            bump_amount = 5,
          }
          } }
        }
      },
      {
        n = G.UIT.R,
        config = { align = "tm" },
        nodes = {
          {
            n = G.UIT.C,
            config = {padding = 0.2},
            nodes = {
              {
                n = G.UIT.R,
                config = {},
                nodes = {
                  { n = G.UIT.T, config = { text = localize("k_akyrs_created_by"), scale = 0.5, colour = G.C.WHITE } }
                }
              },
              {
                n = G.UIT.R,
                config = { w = 4, align = "cm" },
                nodes = {
                  {
                    n = G.UIT.C,
                    config = { w = 4, align = "rm" },
                    nodes = {
                      AKYRS.card_area_preview(G.creditCardArea, nil, {
                        cards = cards1,
                        h = 1.6,
                        w = 1.0,
                        override = true,
                        scale = 1.5,
                        type = "akyrs_credits",
                      }),
                    }
                  },
                }
              },
              {
                n = G.UIT.R,
                config = {},
                nodes = {
                  UIBox_button({
                    colour = HEX('5865F2'), minw = 3.5, minh = 1, padding = 0.1, emboss = 0.2, button = "go_to_aikoyori_discord_server", label = {localize("k_akyrs_join_akyrs_discord")}
                  })
                }
              },
            }
          },
          {
            n = G.UIT.C,
            config = {padding = 0.05},
            nodes = {
              {
                n = G.UIT.R,
                config = {},
                nodes = {
                  { n = G.UIT.T, config = { text = localize("k_akyrs_additional_art_by"), scale = 0.5, colour = G.C.WHITE } }
                }
              },
              AKYRS.create_credits("akyrs_larantula_l_credits", "@larantula_l", 3.5),
              AKYRS.create_credits("akyrs_mystery", "@eggymari", 3.2),
            }
          }
        }
      },
    }
  }
  table.insert(mod_nodes, node1)
end

-- copied from breeze https://discord.com/channels/1116389027176787968/1337300709602754611/1337705824859979817
AKYRS.save_config = function(e)
  local status, err = pcall(SMODS.save_mod_config,AKYRS)
  if status == false then
      sendErrorMessage("Failed to perform a manual mod config save.", 'Aikoyori\'s Shenanigans') -- sorry 
  end
end

G.FUNCS.akyrs_change_wildcard_behaviour = function (e)
  AKYRS.config.wildcard_behaviour = e.to_key
  AKYRS.save_config(e)
  AKYRS.config_dyna_desc_txt_1 = localize('k_akyrs_wildcard_behaviours_description')[AKYRS.config.wildcard_behaviour][1]
  AKYRS.config_dyna_desc_txt_2 = localize('k_akyrs_wildcard_behaviours_description')[AKYRS.config.wildcard_behaviour][2]
  AKYRS.config_wildcard_desc_dyna_1:update_text(true)
  AKYRS.config_wildcard_desc_dyna_1:update()
  AKYRS.config_wildcard_desc_dyna_2:update_text(true)
  AKYRS.config_wildcard_desc_dyna_2:update()
end

G.FUNCS.akyrs_change_balance_toggle = function (e)
  local text_col = G.C.UI.TEXT_LIGHT
  G.PROFILES[G.SETTINGS.profile].akyrs_balance = AKYRS.rev_balance_map[e.to_key]
  if G.PROFILES[G.SETTINGS.profile].akyrs_balance == "absurd" and not Talisman then
    G.PROFILES[G.SETTINGS.profile].akyrs_balance = "adequate"
    text_col = G.C.RED
  end
  G:save_settings()
  AKYRS.config_balance_text_txt = localize('k_akyrs_balance_descriptions')[AKYRS.balance_map[G.PROFILES[G.SETTINGS.profile].akyrs_balance]]
  AKYRS.config_balance_text.colours = {text_col}
  AKYRS.config_balance_text:update_text(true)
  AKYRS.config_balance_text:update()
end

G.FUNCS.akyrs_change_joker_preview_stuff = function (e)
  AKYRS.save_config(e)
end

G.FUNCS.akyrs_change_crt_toggle = function (e)
  AKYRS.save_config(e)
end

AKYRS.balance_map = {
  ["adequate"] = 1,
  ["absurd"] = 2,
}
AKYRS.rev_balance_map = {
  "adequate", "absurd"
}

SMODS.current_mod.config_tab = function ()
  AKYRS.config_dyna_desc_txt_1 = localize('k_akyrs_wildcard_behaviours_description')[AKYRS.config.wildcard_behaviour][1]
  AKYRS.config_dyna_desc_txt_2 = localize('k_akyrs_wildcard_behaviours_description')[AKYRS.config.wildcard_behaviour][2]
  AKYRS.config_balance_text_txt = localize('k_akyrs_balance_descriptions')[AKYRS.balance_map[G.PROFILES[G.SETTINGS.profile].akyrs_balance]]
  AKYRS.config_wildcard_desc_dyna_1 = DynaText{
    scale = 0.4,
    colours = {G.C.UI.TEXT_LIGHT},
    string = {{ref_table = AKYRS ,ref_value = "config_dyna_desc_txt_1"}},
    shadow = true, float = false, silent = true
  }  
  AKYRS.config_wildcard_desc_dyna_2 = DynaText{
    scale = 0.4,
    colours = {G.C.UI.TEXT_LIGHT},
    string = {{ref_table = AKYRS ,ref_value = "config_dyna_desc_txt_2"}},
    shadow = true, float = false, silent = true
  }
  AKYRS.config_balance_text = DynaText{
    scale = 0.4,
    colours = {G.C.UI.TEXT_LIGHT},
    string = {{ref_table = AKYRS ,ref_value = "config_balance_text_txt"}},
    shadow = true, float = false, silent = true
  }
  return {
    n = G.UIT.ROOT, config = { minw = 18, minh = 8 ,align = "tm",colour = G.C.UI.TRANSPARENT_DARK, r = 0.1 },
    nodes = {
      { n = G.UIT.R, config = {align = "tm"}, nodes = {
          { n = G.UIT.C, config = {
            align = "cm", padding = 0.2,
          }, nodes = {
            {n = G.UIT.T, config = {
              text = localize("k_akyrs_wildcard_behaviour_txt"),
              scale = 0.5,
              colour = G.C.UI.TEXT_LIGHT
            }}
            }
          },          
          { n = G.UIT.C, config = {
            align = "cm", padding = 0.2,
            id = "akyrs_wildcard_behaviour_desc_dyna"
          }, nodes = {
              create_option_cycle({
                options = localize('k_akyrs_wildcard_behaviours'),
                scale = 0.7,
                w = 4.5,
                current_option = AKYRS.config.wildcard_behaviour,
                opt_callback = "akyrs_change_wildcard_behaviour",
                ref_table = AKYRS.config,
                ref_value = "wildcard_behaviour"

              })
            }
          },       
        } 
      },
      -- wildcard description
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.O,
            config = {
              align = "cm",
              object = AKYRS.config_wildcard_desc_dyna_1
            }
          }
        }
      },
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.O,
            config = {
              align = "cm",
              object = AKYRS.config_wildcard_desc_dyna_2
            }
          }
        }
      },
      -- balance
      { n = G.UIT.R, config = {align = "tm"}, nodes = {
          { n = G.UIT.C, config = {
            align = "cm", padding = 0.2,
          }, nodes = {
            {n = G.UIT.T, config = {
              text = localize("k_akyrs_config_balance_txt"),
              scale = 0.5,
              colour = G.C.UI.TEXT_LIGHT
            }}
            }
          },          
          { n = G.UIT.C, config = {
            align = "cm", padding = 0.2,
            id = "akyrs_wildcard_behaviour_desc_dyna"
          }, nodes = {
              create_option_cycle({
                options = localize('k_akyrs_balance_selects'),
                scale = 0.7,
                w = 4.5,
                current_option = AKYRS.balance_map[G.PROFILES[G.SETTINGS.profile].akyrs_balance],
                opt_callback = "akyrs_change_balance_toggle",
                ref_table = G.PROFILES[G.SETTINGS.profile],
                ref_value = "akyrs_balance"

              })
            }
          },       
        } 
      },
      -- wildcard description
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.O,
            config = {
              align = "cm",
              object = AKYRS.config_balance_text
            }
          }
        }
      },
      -- joker previews
      
      { n = G.UIT.R, config = { align = "tm"}, nodes = {
        { n = G.UIT.C, config = {
          align = "cm", padding = 0.2,
        }, nodes = {
          
          create_toggle({
            label = localize("k_akyrs_joker_preview"),
            ref_table = AKYRS.config,
            ref_value = "show_joker_preview",
            label_scale = 0.5,
            callback = G.FUNCS.akyrs_change_joker_preview_stuff
          })
          }
        },
        } 
      },
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("k_akyrs_joker_preview_description")[1],
              scale = 0.4,
              colour = G.C.UI.TEXT_LIGHT,
            }
          }
        }
      },
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("k_akyrs_joker_preview_description")[2],
              scale = 0.4,
              colour = G.C.UI.TEXT_LIGHT,
            }
          }
        }
      },
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("k_akyrs_joker_preview_description")[3],
              scale = 0.4,
              colour = G.C.UI.TEXT_LIGHT,
            }
          }
        }
      },

      { n = G.UIT.R, config = { align = "tm"}, nodes = {
        { n = G.UIT.C, config = {
          align = "cm", padding = 0.2,
        }, nodes = {
          
          create_toggle({
            label = localize("k_akyrs_toggle_crt"),
            ref_table = AKYRS.config,
            ref_value = "turn_on_crt",
            label_scale = 0.5,
            callback = G.FUNCS.akyrs_change_crt_toggle
          })
          }
        },
        } 
      },
      {
        n = G.UIT.R,{
          align = "cm", padding = 0.2,
        },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("k_akyrs_toggle_crt_description"),
              scale = 0.4,
              colour = G.C.UI.TEXT_LIGHT,
            }
          }
        }
      },
    }
  }
end
