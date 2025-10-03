return {
 CardSleeves.Sleeve {
        key = "tangerine",
        atlas = "GarbSleeves",  -- you will need to create an atlas yourself
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_garb_garbdeck" then
                key = self.key .. "_alt"
            end
            return { key = key }
        end,    
        unlocked = false,
        unlock_condition = {deck = "b_garb_garbdeck", stake = "stake_black"},

    },

    }