return {
 CardSleeves.Sleeve {
        key = "cycle",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 3, y = 0 },
        config = { money = 75, ante = 1 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_cycle" then
                key = self.key .. "_alt"
                self.config.money = 150
            else
                self.config.money = 75
            end
            vars = {self.config.money}
            return { key = key, vars = vars }
        end,  
        unlocked = false,
        unlock_condition = {deck = "b_garb_cycle", stake = "stake_black"},

        apply = function(self, back)
            self.config.ante = 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    if self.get_current_deck_key() ~= "b_garb_cycle" then
                        play_sound('garb_snap', 1)
                    end
                    ease_dollars(self.config.money-G.GAME.dollars, true)
                    return true
                end
            }))
        end,

        calculate = function(self, card, context)
            if G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop and self.get_current_deck_key() ~= "b_garb_cycle" then
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

            elseif G.GAME.round_resets.ante ~= self.config.ante and context.starting_shop and self.get_current_deck_key() == "b_garb_cycle" then
                for k, v in pairs(G.GAME.hands) do
                    if G.GAME.hands[k].level > 1 then
                        G.GAME.hands[k].level = 1
                    end
                end
                self.config.ante = G.GAME.round_resets.ante
                ease_dollars(self.config.money-G.GAME.dollars, true)
            end     
        end,
    },

    }