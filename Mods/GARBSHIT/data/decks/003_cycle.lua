return {
 SMODS.Back {
        key = 'cycle',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 0, y = 1 },    
        unlocked = false,
        discovered = true,
        config = {
            money = 75,
            ante = 1
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {self.config.money}}
        end,
        check_for_unlock = function(self, args)
            if args.type == "cycle_deck" then
              return true
            end
          end,    

        apply = function(self, back)
            self.config.ante = 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('garb_snap', 1)
                    ease_dollars(self.config.money-G.GAME.dollars, true)
                    return true
                end
            }))
        end,

        calculate = function(self, card, context)
            if G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop then
                    play_sound('garb_snap', 1)
                    local deletable_jokers = {}
                    ease_dollars(self.config.money-G.GAME.dollars, true)

                    for k, v in pairs(G.jokers.cards) do
                        if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
                    end

                    for k, v in pairs(G.consumeables.cards) do
                        v:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    
                    for k, v in pairs(deletable_jokers) do
                        if v ~= chosen_joker then 
                            v:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true
                        end
                    end

                    self.config.ante = G.GAME.round_resets.ante
            end     
        end,
    },

    }