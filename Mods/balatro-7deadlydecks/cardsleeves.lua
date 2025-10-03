--- Card Sleeves Support for Seven Deadly Decks

SMODS.Atlas{
    key = "7DD_Sleeves",
    path = "7DD_Sleeves.png",
    px = 73,
    py = 95
}

-- Sleeve of Greed
CardSleeves.Sleeve{
    key = "greed",
    
    atlas = "7DD_Sleeves",
    pos = { x = 0, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_greed" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_greed" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            GREED_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Lust
CardSleeves.Sleeve{
    key = "lust",
    
    atlas = "7DD_Sleeves",
    pos = { x = 1, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_lust" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_lust" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            LUST_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Gluttony
CardSleeves.Sleeve{
    key = "gluttony",
    
    atlas = "7DD_Sleeves",
    pos = { x = 2, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_gluttony" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_gluttony" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            GLUTTONY_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Envy
CardSleeves.Sleeve{
    key = "envy",
    
    atlas = "7DD_Sleeves",
    pos = { x = 3, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_envy" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_envy" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            ENVY_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Wrath
CardSleeves.Sleeve{
    key = "wrath",
    
    atlas = "7DD_Sleeves",
    pos = { x = 4, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_wrath" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_wrath" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            WRATH_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Sloth
CardSleeves.Sleeve{
    key = "sloth",
    
    atlas = "7DD_Sleeves",
    pos = { x = 5, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_sloth" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,

    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_sloth" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            SLOTH_DECK.apply(self, sleeve)
        end
    end
}

-- Sleeve of Pride
CardSleeves.Sleeve{
    key = "pride",
    
    atlas = "7DD_Sleeves",
    pos = { x = 6, y = 0 },

    loc_vars = function(self)
    
        local key, vars

        -- Enable negative joker if sleeve is used on Greed Deck
        if self.get_current_deck_key() == "b_7dd_pride" then
            key = self.key .. "_alt"
            
            self.config = { is_negative = true }
            vars = { self.config.is_negative }

        else
            key = self.key
            self.config = { is_negative = false }
            vars = { self.config.is_negative }

        end

        return { key = key, vars = vars }

    end,
    
    apply = function (self, sleeve)
        if self.get_current_deck_key() == "b_7dd_pride" then
            G.E_MANAGER:add_event(Event({

                func = function ()

                    -- Set Greed Joker to negative
                    G.jokers.cards[1]:set_edition("e_negative")

                    return true
                end
            }))

        else
            PRIDE_DECK.apply(self, sleeve)
        end
    end
}