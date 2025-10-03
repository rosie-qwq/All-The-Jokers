
  SMODS.Back {
    key = 'handmade',
    atlas = 'enhancers_atlas',
    pos = { x = 3, y = 0 },
    config = {
      vouchers = {
        'v_artb_pen_holder'
      },
    },

    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'v_artb_pen_holder', set = 'Voucher' },
        }
      }
    end,

    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
			func = function()

        local edition = poll_edition('handmade', nil, true, true)
        ArtBox.create_collectable(edition)

        local valid_keys = {}
        for _, seal_center in pairs(G.P_CENTER_POOLS["Seal"]) do
            valid_keys[#valid_keys + 1] = seal_center.key
        end
		ArtBox.create_collectable(pseudorandom_element(valid_keys, pseudoseed("handmade")))

        local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'handmade'})
        ArtBox.create_collectable(new_enhancement)

			return true
		end
		}))
        
    end
  }

  SMODS.Back {
    key = 'box',
    atlas = 'enhancers_atlas',
    pos = { x = 4, y = 0 },
    config = {
      vouchers = {
        'v_artb_booster_stack'
      },
      consumables = {
        'c_artb_joker_collectable'
      }
    },

    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'v_artb_booster_stack', set = 'Voucher' },
          localize { type = 'name_text', key = 'c_artb_joker_collectable', set = 'collectable' },
        }
      }
    end
  }
