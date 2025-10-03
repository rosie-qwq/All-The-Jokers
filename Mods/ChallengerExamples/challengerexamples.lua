SMODS.Challenge{ -- Three-Body Problem
    loc_txt = "Three-Body Problem",
    key = 'three_body_1',
    rules = {
        custom = {
            {id = 'blind_scaling', value = 1.2},
            {id = 'no_negative_jokers'},
            {id = 'hand_per_joker'},
            {id = 'minus_discard_per_joker'},
            {id = 'enable_eternal_jokers'}
    },
        modifiers = {
            {id = 'joker_slots', value = 3},
            {id = 'hands', value = 0},
            {id = 'discards', value = 6}
        },
    },
    jokers = {
        {id = 'j_space', eternal = true}
    },
    restrictions = {
        banned_cards = {
            {id = 'v_grabber'},
            {id = 'v_nacho_tong'},
            {id = 'j_burglar'},
            {id = 'v_wasteful'},
            {id = 'v_recyclomancy'},
            {id = 'v_antimatter'},
            {id = 'v_blank'}},
        banned_tags = {
            {id = 'tag_negative'}
        },
        banned_other = {}
    },
}

SMODS.Challenge{ -- Nepo Baby
    loc_txt = "Nepo Baby",
    key = 'nepo_1',
    rules = {
        custom = {
            {id = 'minus_jokers_per_dollar', value = 6},
            {id = 'overflow_perishable'},
            {id = 'anaglyph', value = localize{type = 'name_text', set = 'Tag', key = 'tag_investment', nodes = {}}, tag = 'investment'}
    },
        modifiers = {
        },
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.Challenge{ -- Double Trouble
    loc_txt = "Double Trouble",
    key = 'double_1',
    rules = {
        custom = {
            {id = 'second_boss'}
    },
        modifiers = {
        },
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.Challenge{ -- The Pinch
    loc_txt = "The Pinch",
    key = 'pinch_1',
    rules = {
        custom = {
            {id = 'disable_small_ante', value = 2},
            {id = 'disable_big_ante', value = 4},
            {id = 'win_ante', value = 6},
            {id = 'blind_scaling', value = 1.5}
    },
        modifiers = {
            {id = 'joker_slots', value = 3}
        },
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.Challenge{ -- Forever Howlong
    loc_txt = "Forever Howlong",
    key = 'forever_howlong_1',
    rules = {
        custom = {
            {id = 'all_eternal'},
            {id = 'disable_skipping'}
    },
        modifiers = {
        },
    },
    jokers = {
        {id = 'j_raised_fist', eternal = true}
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.Challenge{ -- Chaos
    loc_txt = "Chaos",
    key = 'chaos_1',
    rules = {
        custom = {
            {id = 'chaos_engine'}
    },
        modifiers = {
        },
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.Challenge{ -- Chaos Incarnate
    loc_txt = "Chaos Incarnate",
    key = 'chaos_2',
    rules = {
        custom = {
            {id = 'chaos_engine_all'}
    },
        modifiers = {
        },
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
}

SMODS.load_file('demochallenges-vanilla.lua')()

--[[
if (SMODS.Mods["Bunco"] or {}).can_load then
    SMODS.load_file('demochallenges-bunco.lua')()
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
    SMODS.load_file('demochallenges-cryptid.lua')()
end
]]