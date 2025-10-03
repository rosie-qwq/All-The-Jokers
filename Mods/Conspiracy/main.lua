--#region Config
Conspiracy = SMODS.current_mod
Conspiracy_path = SMODS.current_mod.path
Conspiracy_config = SMODS.current_mod.config

-- Credits Tab - Derived from Joyous Spring credits tab
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = localize('b_cspy_credits'),
            tab_definition_function = function()
                local modNodes = {}

                modNodes[#modNodes + 1] = {}
                local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.4 }
                localize { type = 'descriptions', key = 'cspy_credits', set = 'Other', nodes = modNodes[#modNodes], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow }
                modNodes[#modNodes] = desc_from_rows(modNodes[#modNodes])
                modNodes[#modNodes].config.colour = loc_vars.background_colour or modNodes[#modNodes].config.colour

                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 6,
                        align = "tm",
                        padding = 0.2,
                        colour = G.C.BLACK
                    },
                    nodes = modNodes
                }
            end
        }
    }
end

--#endregion

--#region SMODS Optional Features ---------------------------------------------------------------------------

SMODS.current_mod.optional_features = { retrigger_joker = true, post_trigger = true, cardareas = { unscored = true } }

--#endregion

--#region Talisman compat

to_big = to_big or function(num)
    return num
end

--#endregion

--#region Misc Atlases -------------------------------------------------------------------------------------------

SMODS.Atlas { -- Placeholder Atlas
    key = 'Placeholder',
    path = "placeholders.png",
    px = 71,
    py = 95
}

--[[ SMODS.Atlas { -- Mod Icon
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
} ]]

--#endregion

--#region Function Hooks ------------------------------------------------------------------------------------

--[[ -- Menu stuff
if Conspiracy_config.menu then
    local oldfunc = Game.main_menu
    Game.main_menu = function(change_context)
        local ret = oldfunc(change_context)
        if G.P_CENTERS['j_cspy_normal'].discovered then
            -- adds a James to the main menu
            local newcard = create_card('Joker', G.title_top, nil, nil, nil, nil, 'j_cspy_normal', 'astra')
            -- recenter the title
            G.title_top.T.w = G.title_top.T.w * 1.7675
            G.title_top.T.x = G.title_top.T.x - 0.8
            newcard:start_materialize({ G.C.WHITE, G.C.cspy_SECONDARY }, true, 2.5)
            G.title_top:emplace(newcard)
            -- make the card look the same way as the title screen Ace of Spades
            newcard.T.w = newcard.T.w * 1.1 * 1.2
            newcard.T.h = newcard.T.h * 1.1 * 1.2
            newcard.no_ui = true
        end

        -- make the title screen use different background colors
        G.SPLASH_BACK:define_draw_steps({ {
            shader = 'splash',
            send = {
                { name = 'time',       ref_table = G.TIMERS, ref_value = 'REAL_SHADER' },
                { name = 'vort_speed', val = 0.4 },
                { name = 'colour_1',   ref_table = G.C,      ref_value = 'cspy_PRIMARY' },
                { name = 'colour_2',   ref_table = G.C,      ref_value = 'cspy_SECONDARY' },
            }
        } })

        return ret
    end
end ]]

--#endregion

--#region Achievements

--[[ assert(SMODS.load_file('items/achievements.lua'))()
sendDebugMessage("Loaded Achievements", 'Conspiracy') ]]

--#endregion

--#region Conspiracy -----------------------------------------------------------------------------------------

-- Conspiracy Type
SMODS.ConsumableType {
    key = 'Conspiracy',
    primary_colour = G.C.SET.Tarot,
    secondary_colour = G.C.SECONDARY_SET.Tarot,
    default = 'c_cspy_sighting',
    collection_rows = { 7, 7 },
    shop_rate = 1
}

local ENABLED_CONSPIRACIES = {
    'assassination',
    'sighting',
    'coverup',
    'hoax',
    'pyramid',
    'vaccine',
    'society',
    'corruption',
    'woke',
    'mib',
    'flat_earth',
    'landing',
    '5g',
    'tinfoil',
    'conspiracy_dummy',
}

sendDebugMessage("Loading Conspiracies...", 'Conspiracy')
for i = 1, #ENABLED_CONSPIRACIES do
    assert(SMODS.load_file('items/conspiracy/' .. ENABLED_CONSPIRACIES[i] .. '.lua'))()
    sendDebugMessage("Loaded conspiracy: " .. ENABLED_CONSPIRACIES[i], 'Conspiracy')
end
sendDebugMessage("", 'Conspiracy')
--#endregion

--#region Boosters

--[[ SMODS.Atlas { -- Main Booster Atlas
    key = 'Boosters',
    path = "Boosters.png",
    px = 71,
    py = 95
} ]]

local ENABLED_BOOSTERS = {
    --'classified_jumbo_1',
    --'classified_mega_1',
    --'classified_normal_1',
    --'classified_normal_2',
}

sendDebugMessage("Loading Boosters...", 'Conspiracy')
for i = 1, #ENABLED_BOOSTERS do
    assert(SMODS.load_file('items/boosters/' .. ENABLED_BOOSTERS[i] .. '.lua'))()
    sendDebugMessage("Loaded booster: " .. ENABLED_BOOSTERS[i], 'Conspiracy')
end


sendDebugMessage("", 'Conspiracy')


--#endregion

--#region Jokers --------------------------------------------------------------------------------------------

--[[ SMODS.Atlas { -- Main Joker Atlas
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
} ]]

local ENABLED_JOKERS = { -- Comment out item to disable

    --Common
    'grifter',
    --'red_yarn',

    --Uncommon
    'cork_board',
    'illuminati',
    'ufo',
    'bigfool',

    --Rare
    'hush_money',
    'apophenia'

}

sendDebugMessage("Loading Jokers...", 'Conspiracy')
for i = 1, #ENABLED_JOKERS do
    assert(SMODS.load_file('items/jokers/' .. ENABLED_JOKERS[i] .. '.lua'))()
    sendDebugMessage("Loaded joker: " .. ENABLED_JOKERS[i], 'Conspiracy')
end
sendDebugMessage("", 'Conspiracy')

--#endregion

--#region Vouchers ------------------------------------------------------------------------------------------

--[[ SMODS.Atlas { -- Main Voucher Atlas
    key = 'Vouchers',
    path = "Vouchers.png",
    px = 71,
    py = 95
} ]]

--[[ local ENABLED_VOUCHERS = {
}

sendDebugMessage("Loading Vouchers...", 'Conspiracy')
for i = 1, #ENABLED_VOUCHERS do
    assert(SMODS.load_file('items/vouchers/' .. ENABLED_VOUCHERS[i] .. '.lua'))()
    sendDebugMessage("Loaded voucher: " .. ENABLED_VOUCHERS[i], 'Conspiracy')
end
sendDebugMessage("", 'Conspiracy') ]]

--#endregion

--#region Challenges ----------------------------------------------------------------------------------------

--[[ local ENABLED_CHALLENGES = {

}

sendDebugMessage("Loading Challenges...", 'Conspiracy')
for i = 1, #ENABLED_CHALLENGES do
    assert(SMODS.load_file('items/challenges/' .. ENABLED_CHALLENGES[i] .. '.lua'))()
    sendDebugMessage("Loaded challenge: " .. ENABLED_CHALLENGES[i], 'Conspiracy')
end
sendDebugMessage("", 'Conspiracy') ]]

--#endregion

--#region Tags ----------------------------------------------------------------------------------------------

--[[ SMODS.Atlas { -- Main Tag Atlas
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
} ]]

--[[ local ENABLED_TAGS = {
}
sendDebugMessage("Loading Tags...", 'Conspiracy')
for i = 1, #ENABLED_TAGS do
    assert(SMODS.load_file('items/tags/' .. ENABLED_TAGS[i] .. '.lua'))()
    sendDebugMessage("Loaded tag: " .. ENABLED_TAGS[i], 'Conspiracy')
end
sendDebugMessage("", 'Conspiracy') ]]


--#endregion
