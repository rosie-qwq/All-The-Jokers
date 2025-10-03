
SMODS.Back{
    key = "letter_deck",
    name = "Letter Deck",
    atlas = 'deckBacks',
    pos = {x = 0, y = 0},
    loc_vars = function (self, info_queue, card)
        return { vars = {
            self.config.ante_scaling,
            self.config.discards,
            self.config.hand_size
        } }
    end,
    config = {
        akyrs_starting_letters = AKYRS.scrabble_letters,
        starting_deck_size = 100,
        akyrs_selection = 1e100,
        discards = 2,
        akyrs_start_with_no_cards = true,
        akyrs_letters_mult_enabled = true,
        akyrs_hide_normal_hands = true,
        ante_scaling = 2,
        hand_size = 2,
        vouchers = {'v_akyrs_alphabet_soup','v_akyrs_crossing_field'}
    },
}
SMODS.Back{
    key = "math_deck",
    name = "Math Deck",
    atlas = 'deckBacks',
    pos = {x = 4, y = 0},
    loc_vars = function (self, info_queue, card)
        return { vars = {
            self.config.akyrs_math_threshold,
            5 + self.config.akyrs_selection,
            self.config.akyrs_gain_selection_per_ante
        } }
    end,
    config = {
        akyrs_starting_letters = AKYRS.math_deck_characters,
        akyrs_start_with_no_cards = true,
        akyrs_mathematics_enabled = true,
        akyrs_character_stickers_enabled = true,
        akyrs_no_skips = true,
        akyrs_selection = 0,
        akyrs_gain_selection_per_ante = 1,
        discards = 1,
        --akyrs_always_skip_shops = true,
        akyrs_math_threshold = 1,
        hand_size = 6,
        akyrs_power_of_x_scaling = 13.69,
        akyrs_hide_normal_hands = true,
        akyrs_hide_high_card = true,
        akyrs_hand_to_not_hide = {["akyrs_expression"] = true,["akyrs_modification"] = true },
        akyrs_random_scale = {min = 0.5, max = 9.5},
    },
}

SMODS.Back{
    key = "split_deck",
    name = "Split Deck",
    atlas = 'deckBacks',
    pos = {x = 2, y = 1},
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                self.config.discards
            }
        }
    end,
    config = {
        akyrs_split_deck = true, discards = 2
    },
}


SMODS.Back{
    key = "hardcore_challenges",
    name = "Hardcore Challenge Deck",
    atlas = 'deckBacks',
    pos = {x = 3, y = 1},
    omit = true,
    draw = function (self, card, layer)
        
    end,
    config = {
    },
}


SMODS.Back{
    key = "scuffed_misprint",
    atlas = "deckBacks",
    pos = { x = 7, y = 0},
    config = { akyrs_misprint_min = 1e-4, akyrs_misprint_max = 1e4 },
    set_badges = function (self, card, badges)
    end,
    loc_vars = function (self, info_queue, card)
        --info_queue[#info_queue+1] = {set = "DescriptionDummy", key = "dd_akyrs_placeholder_art"}
        return {
            vars = {
                self.config.akyrs_misprint_min,
                self.config.akyrs_misprint_max
            }
        }
    end,
    apply = function(self)
        G.GAME.modifiers.akyrs_misprint = true
    end,

}

SMODS.Back{
    key = "freedom",
    atlas = "deckBacks",
    pos = { x = 8, y = 0},
    config = { akyrs_any_drag = true },
    set_badges = function (self, card, badges)
    end,
    loc_vars = function (self, info_queue, card)
    end,
}

SMODS.Back{
    key = "ultimate_freedom",
    atlas = "deckBacks",
    pos = { x = 9, y = 0},
    config = { akyrs_any_drag = true, akyrs_ultimate_freedom = true },
    set_badges = function (self, card, badges)
    end,
    loc_vars = function (self, info_queue, card)
    end,
}
