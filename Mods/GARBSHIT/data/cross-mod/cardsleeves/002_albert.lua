return {
 CardSleeves.Sleeve {
        key = "albert",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 1, y = 0 },
        config = { ante_scaling = 1.5, hands = -1},
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_albert" then
                key = self.key .. "_alt"
                self.config.hands = -1
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
            else
                self.config.hands = 0
                G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.ante_scaling
            end
            vars = {self.config.ante_scaling, self.config.hands}
            return { key = key, vars = vars }
        end,   
        unlocked = false,
        unlock_condition = {deck = "b_garb_albert", stake = "stake_black"},
 
        apply = function(self, back)
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        local card = create_card("Joker", G.jokers, true, 4, nil, nil, nil, "ALBERT")
                        card:add_to_deck()
                        card:start_materialize()
                        G.jokers:emplace(card)
                        return true
                    end
                end,
            }))
        end,
    },

    }