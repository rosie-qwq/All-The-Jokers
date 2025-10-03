SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_swatch',
	set = 'art',
	name = 'Swatch',
    config = {
    },
	pos = { x = 3, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, card)
    return {
      vars = {
        G.GAME.probabilities.normal,
      }
    }
    end,

    use = function(self, card, area)
      local types = {}
      for _, v in pairs(SMODS.ConsumableTypes) do
        if v.key~="collectable" and v.key~="Cine" then
           types[#types + 1] = v
        end
      end
     G.E_MANAGER:add_event(Event({
              trigger = 'before',
              func = function()
                SMODS.add_card {
                  set = pseudorandom_element(types, pseudoseed('Swatch')).key,
                  area = G.consumables,
                  edition = 'e_negative',
                  soulable = true,
                  key_append = 'Swatch',
                }

                return true
              end
            }))
    end

    
})