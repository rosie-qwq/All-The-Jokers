mxfj_mod = SMODS.current_mod
mxfj_config = mxfj_mod.config

SMODS.Atlas {
    key = "modicon",
    path = "mxfj_modicon.png",
    px = 34,
    py = 34,
}

--mxfj_mod.optional_features = {
--    retrigger_joker = true,
--    cardareas = {
--        unscored = true
--    }
--}

--mxfj_mod.config_tab = function()
--    return {n = G.UIT.ROOT, config = {align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6}, nodes = {
--        {n = G.UIT.R, config = {align = "cl", padding = 0, minh = 0.1}, nodes = {}},
--
--        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
--            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
--                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = mxfj_config, ref_value = "patch_pos" },
--            }},
--            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
--                { n = G.UIT.T, config = { text = "Patchwork Joker: Patch behind suit*", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
--            }},
--        }},
--
--        {n = G.UIT.R, config = {align = "cm", padding = 0.5}, nodes = {
--            {n = G.UIT.T, config = {text = "*Must restart to apply changes", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
--        }},
--    }}
--end

-- Talisman Stuff
SMODS.load_file("utils.lua")()

SMODS.Atlas {
    key = "mxfj_sprites",
    path = "mxfj_sprites.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mxfj_match_box",
    path = "mxfj_match_box.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "mxfj_decks",
    path = "mxfj_decks.png",
    px = 71,
    py = 95
}

if Partner_API then
    SMODS.Atlas {
        key = "mxfj_partners",
        path = "mxfj_partners.png",
        px = 46,
        py = 58,
    }
end

-- Initialize Food Pool if another mod hasn't made it

vanilla_food = {
    j_gros_michel = true,
    j_egg = true,
    j_ice_cream = true,
    j_cavendish = true,
    j_turtle_bean = true,
    j_diet_cola = true,
    j_popcorn = true,
    j_ramen = true,
    j_selzer = true,
}

if not SMODS.ObjectTypes.Food then
    SMODS.ObjectType {
        key = 'Food',
        default = 'j_egg',
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            -- Insert base game food jokers
            for k, _ in pairs(vanilla_food) do
                self:inject_card(G.P_CENTERS[k])
            end
        end
    }
end

-- Medusa --

SMODS.Joker {
    key = "medusa",
    name = "Medusa",
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and no_bp_retrigger(context) then
            local faces = {}
            for _, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    faces[#faces + 1] = v
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:set_ability(G.P_CENTERS.m_stone)
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if #faces > 0 then
                return {
                    message = localize('k_mxfj_stone'),
                    colour = G.C.GREY,
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Grave Robber --

SMODS.Joker {
    key = "grave_robber",
    name = "Grave Robber",
    rarity = 2,
    pos = { x = 1, y = 0 },
    cost = 6,
    config = { extra = { dollars = 0, dollar_mod = 2 } },
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollar_mod, card.ability.extra.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.dollars ~= 0 then
            return card.ability.extra.dollars
        end
    end,
    calculate = function(self, card, context)
        if (context.cards_destroyed and (context.glass_shattered and #context.glass_shattered > 0))
            or (context.remove_playing_cards and (context.removed and #context.removed > 0)) and no_bp_retrigger(context) then
            local _dollars = 0
            if context.removed then
                _dollars = _dollars + (card.ability.extra.dollar_mod * #context.removed)
            end
            if context.glass_shattered then
                _dollars = _dollars + (card.ability.extra.dollar_mod * #context.glass_shattered)
            end
            card.ability.extra.dollars = card.ability.extra.dollars + _dollars
            G.E_MANAGER:add_event(Event({
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+$" .. _dollars,
                        colour = G.C.MONEY
                    })
                    return true
                end
            }))
        end
        if context.end_of_round and not (context.individual or context.repetition) and no_bp_retrigger(context) then
            if G.GAME.blind and G.GAME.blind.boss and card.ability.extra.dollars > 0 then
                card.ability.extra.dollars = math.ceil(card.ability.extra.dollars / 2)
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_mxfj_halved'),
                    colour = G.C.RED
                })
            end
        end
    end,
    atlas = "mxfj_sprites"
}

if Partner_API then
    -- Dig --

    Partner_API.Partner {
        key = "grave_robber",
        name = "Grave Robber Partner",
        unlocked = false,
        discovered = true,
        pos = { x = 1, y = 0 },
        atlas = "mxfj_partners",
        config = { extra = { dollars = 2 } },
        link_config = { j_mxfj_grave_robber = 1 },
        loc_vars = function(self, info_queue, card)
            local benefits = ((next(SMODS.find_card("j_mxfj_grave_robber")) and 2) or 0)
            local dollar_mod = card.ability.extra.dollars + benefits
            return { vars = { dollar_mod } }
        end,
        calculate = function(self, card, context)
            if context.remove_playing_cards then
                local _dollars = 0
                local benefits = ((next(SMODS.find_card("j_mxfj_grave_robber")) and 2) or 0)
                if context.removed then
                    _dollars = (card.ability.extra.dollars + benefits) * #context.removed
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_dollars(_dollars)
                            card_eval_status_text(card, 'extra', nil, nil, nil,
                                { message = localize('$') .. _dollars, colour = G.C.MONEY, delay = 0.45 })
                            return true
                        end
                    }))
                end
            end
        end,
        check_for_unlock = function(self, args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == "j_mxfj_grave_robber" then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }
end

-- Dungeon Jester --

SMODS.Joker {
    key = "dungeon_jester",
    name = "Dungeon Jester",
    rarity = 3,
    pos = { x = 2, y = 0 },
    cost = 8,
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra * 100 } }
    end,
    atlas = "mxfj_sprites"
}

-- Crusader --

SMODS.Joker {
    key = "crusader",
    name = "Crusader",
    rarity = 2,
    pos = { x = 3, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { localize("Straight Flush", "poker_hands") } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and context.scoring_hand and context.poker_hands and no_bp_retrigger(context) then
            if next(context.poker_hands["Straight Flush"]) then
                local has_face = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_face() then
                        has_face = true
                        break
                    end
                end
                if has_face then
                    for _, v in ipairs(context.scoring_hand) do
                        v:set_ability(G.P_CENTERS.m_steel)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        }))
                    end
                    return {
                        message = localize('k_mxfj_steel'),
                        colour = G.C.UI.TEXT_INACTIVE,
                    }
                end
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Zombie Clown --

SMODS.Joker {
    key = "zombie_clown",
    name = "Zombie Clown",
    rarity = 2,
    pos = { x = 4, y = 0 },
    cost = 6,
    config = { extra = 3 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_death
        return { vars = { (G.GAME and G.GAME.probabilities.normal .. '') or 1, card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and no_bp_retrigger(context) then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('zombclown' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card({ key = 'c_death', key_append = 'zmbclw' })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_mxfj_brains'), colour = HEX("feb1fb") })
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Dweller Joker --

SMODS.Joker {
    key = "dweller",
    name = "Dweller Joker",
    rarity = 1,
    pos = { x = 5, y = 0 },
    cost = 4,
    config = { extra = { min = 0, max = 100 } },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local r_chips = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_chips[#r_chips + 1] = tostring(i)
        end
        local loc_chips = ' ' .. (localize('k_mxfj_chips')) .. ' '
        local _main_start = {
            { n = G.UIT.T, config = { text = '  +', colour = G.C.CHIPS, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_chips, colours = { G.C.BLUE }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.id or 2) .. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.suit:sub(1, 1) or 'C'), colour = G.C.BLUE },
                            loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips,
                            loc_chips, loc_chips, loc_chips, loc_chips, loc_chips },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { vars = { card.ability.extra.min, card.ability.extra.max }, main_start = _main_start }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = pseudorandom(pseudoseed('dweller'), card.ability.extra.min, card.ability.extra.max)
            }
        end
    end,
    atlas = "mxfj_sprites"
}

-- Patchwork Joker --

SMODS.Atlas {
    key = "mxfj_patch",
    path = "mxfj_patch.png",
    px = 71,
    py = 95
}

SMODS.DrawStep {
    key = 'mxfj_patch',
    order = 21,
    func = function(self)
        if self.ability and self.ability.mxfj_patchwork_sprite then
            if not mxfj_mod.mxfj_patch then
                mxfj_mod.mxfj_patch = Sprite(0, 0, G.CARD_W, G.CARD_H,
                    G.ASSET_ATLAS["mxfj_patch"], { x = 0, y = 0 })
            end
            mxfj_mod.mxfj_patch.role.draw_major = self
            mxfj_mod.mxfj_patch:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.edition then
                mxfj_mod.mxfj_patch:draw_shader(G.P_CENTERS[self.edition.key].shader, nil, self.ARGS.send_to_shader, nil,
                    self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}

SMODS.Joker {
    key = "patchwork",
    name = "Patchwork Joker",
    rarity = 2,
    pos = { x = 6, y = 0 },
    cost = 6,
    config = { extra = 0 },
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.end_of_round and no_bp_retrigger(context) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED,
                }
            end
            if not context.other_card.ability.mxfj_patchwork then
                local _chips = math.ceil(context.other_card.base.nominal / 2)
                card.ability.extra = card.ability.extra + _chips
                local _card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card.ability.mxfj_patchwork_sprite = true
                        return true
                    end
                }))
                card_eval_status_text(context.other_card, 'extra', nil, nil, nil,
                    { message = localize("k_mxfj_patched") })
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize { type = 'variable', key = 'a_chips', vars = { _chips } }, colour = G.C.CHIPS })
                context.other_card.ability.mxfj_patchwork = true
            end
        end
        if context.joker_main and card.ability.extra ~= 0 then
            return {
                chips = card.ability.extra
            }
        end
    end,
    atlas = "mxfj_sprites"
}

-- Cryptozoologist --

SMODS.Joker {
    key = "cryptozoologist",
    name = "Cryptozoologist",
    rarity = 3,
    pos = { x = 7, y = 0 },
    cost = 8,
    config = { extra = { rare = 1.75, legendary = 2 } },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rare, card.ability.extra.legendary } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.config.center.key ~= "j_mxfj_cryptozoologist" then
            local _rarity = context.other_joker.config.center.rarity
            if _rarity == 3 or _rarity == 4 then
                return {
                    Xmult = (_rarity == 3 and card.ability.extra.rare) or card.ability.extra.legendary
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Cyclops Joker --

SMODS.Joker {
    key = "cyclops",
    name = "Cyclops Joker",
    rarity = 1,
    pos = { x = 8, y = 0 },
    cost = 4,
    config = { extra = { mult = 0, mult_mod = 7 } },
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card ~= card and context.scoring_hand and context.scoring_name and no_bp_retrigger(context) then
            if context.scoring_name == "High Card" then
                local aces = {}
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i]:get_id() == 14 then aces[#aces + 1] = context.scoring_hand[i] end
                end
                if aces[1] and #aces == 1 then
                    if context.destroy_card == aces[1] then
                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('k_upgrade_ex'),
                        })
                        return true
                    end
                end
            end
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    atlas = "mxfj_sprites"
}

-- Skibidi Jonkler --

SMODS.Joker {
    key = "skibidi",
    name = "Skibidi Jonkler",
    rarity = 2,
    pos = { x = 9, y = 0 },
    cost = 6,
    config = { extra = { chips = 0, mult = 0, chips_mod = 6, mult_mod = 9 } },
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.mult_mod, card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and context.poker_hands and no_bp_retrigger(context) then
            if next(context.poker_hands["Flush"]) then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_upgrade_ex'),
                })
            else
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_reset'),
                    colour = G.C.RED
                })
            end
        end
        if context.joker_main then
            if card.ability.extra.chips ~= 0 and card.ability.extra.mult ~= 0 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult
                }
            elseif card.ability.extra.chips ~= 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            elseif card.ability.extra.mult ~= 0 then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Waxwork Joker --

SMODS.Joker {
    key = "waxwork",
    name = "Waxwork Joker",
    rarity = 3,
    pos = { x = 0, y = 1 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if (context.cardarea == G.play or context.cardarea == G.hand) and context.repetition then
            if context.other_card and context.other_card.seal then
                return {
                    repetitions = 1
                }
            end
        end
    end,
    in_pool = function()
        for _, v in pairs(G.playing_cards) do
            if v.seal and v.seal ~= "Purple" then return true end
        end
        return false
    end,
    atlas = "mxfj_sprites"
}

-- Where's Jimbo --

SMODS.Joker {
    key = "wheres_jimbo",
    name = "Where's Jimbo",
    rarity = 1,
    pos = { x = 1, y = 1 },
    cost = 4,
    config = { extra = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "undefined_buffoon_pack", set = "Other" }
        return { vars = { card.ability.extra } }
    end,
    atlas = "mxfj_sprites"
}

function mxfj_wheres_jimbo_total()
    local total = 0
    for _, v in ipairs(SMODS.find_card("j_mxfj_wheres_jimbo")) do
        total = total + (v and v.ability and v.ability.extra)
    end
    return total
end

SMODS.Booster:take_ownership_by_kind('Buffoon', {
    update = function(self, card, dt)
        card.ability.extra_backup = card.ability.extra_backup or card.ability.extra
        card.ability.extra = card.ability.extra_backup + mxfj_wheres_jimbo_total()
    end
}, true)

-- Banned Card --

SMODS.Joker {
    key = "banned_card",
    name = "Banned Card",
    rarity = 2,
    pos = { x = 2, y = 1 },
    cost = 6,
    config = { extra = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.mxfj_hand_played = nil
            card.ability.mxfj_already_drew = nil
        end
        if context.mxfj_post_hand_space and card.ability.mxfj_hand_played and no_bp_retrigger(context) then
            if (not card.ability.mxfj_already_drew or card.ability.mxfj_already_drew == nil) then
                card.ability.mxfj_already_drew = true
                local hand_space = math.min(#G.deck.cards, card.ability.extra)
                if hand_space > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand(hand_space)
                            card.ability.mxfj_hand_played = nil
                            return true
                        end
                    }))
                end
            else
                card.ability.mxfj_already_drew = nil
            end
        end
        if context.joker_main and no_bp_retrigger(context) then
            card.ability.mxfj_hand_played = true
            card.ability.mxfj_already_drew = nil
        end
    end,
    atlas = "mxfj_sprites"
}

-- Virtual Joker --

mxfj_mod.light_suits = { 'Diamonds', 'Hearts' }
mxfj_mod.dark_suits = { 'Spades', 'Clubs' }

if PB_UTIL and PB_UTIL.config and PB_UTIL.config.suits_enabled then
    table.insert(mxfj_mod.light_suits, 'paperback_Stars')
    table.insert(mxfj_mod.dark_suits, 'paperback_Crowns')
end

if (SMODS.Mods["Bunco"] or {}).can_load then
    local prefix = SMODS.Mods["Bunco"].prefix

    table.insert(mxfj_mod.light_suits, prefix .. '_Fleurons')
    table.insert(mxfj_mod.dark_suits, prefix .. '_Halberds')
end

SMODS.Joker {
    key = "virtual",
    name = "Virtual Joker",
    rarity = 2,
    pos = { x = 3, y = 1 },
    soul_pos = { x = 4, y = 1 },
    cost = 6,
    config = { extra = { chips = 0, mult = 0, chips_mod = 31, mult_mod = 4 } },
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.mult_mod, card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and no_bp_retrigger(context) then
            local light = 0
            local dark = 0
            for i = 1, #context.cards do
                if not SMODS.has_no_suit(context.cards[i]) then
                    local card_is_light = false
                    for j = 1, #mxfj_mod.light_suits do
                        if context.cards[i]:is_suit(mxfj_mod.light_suits[j]) then
                            light = light + 1
                            card_is_light = true
                            break
                        end
                    end
                    if not card_is_light then
                        for j = 1, #mxfj_mod.dark_suits do
                            if context.cards[i]:is_suit(mxfj_mod.dark_suits[j]) then
                                dark = dark + 1
                                break
                            end
                        end
                    end
                end
            end
            if light > 0 or dark > 0 then
                card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chips_mod * dark)
                card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_mod * light)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = (dark > 0 and light <= 0 and G.C.BLUE) or (light > 0 and dark <= 0 and G.C.RED) or
                        G.C.FILTER
                }
            end
        end
        if context.joker_main then
            if card.ability.extra.chips > 0 and card.ability.extra.mult > 0 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult
                }
            elseif card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips,
                }
            elseif card.ability.extra.mult > 0 then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Witch --

SMODS.Joker {
    key = "witch",
    name = "Witch",
    rarity = 2,
    pos = { x = 5, y = 1 },
    cost = 6,
    -- Witch effect in "lovely.toml"
    atlas = "mxfj_sprites"
}

--Code from Betmma's Vouchers
G.FUNCS.can_pick_card = function(e)
    if #G.consumeables.cards < G.consumeables.config.card_limit then
        e.config.colour = G.C.GREEN
        e.config.button = 'pick_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
G.FUNCS.pick_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            c1.area:remove_card(c1)
            c1:add_to_deck()
            if c1.children.price then c1.children.price:remove() end
            c1.children.price = nil
            if c1.children.buy_button then c1.children.buy_button:remove() end
            c1.children.buy_button = nil
            remove_nils(c1.children)
            G.consumeables:emplace(c1)
            G.GAME.pack_choices = G.GAME.pack_choices - 1
            if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
            end
            return true
        end
    }))
end

-- Transmodifly --

SMODS.Joker {
    key = "transmodifly",
    name = "Transmodifly",
    rarity = 2,
    pos = { x = 6, y = 1 },
    cost = 6,
    calculate = function(self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.play and no_bp_retrigger(context) then
            if context.other_card.ability.effect == "Wild Card" then
                return {
                    mult = G.P_CENTERS.m_mult.config.mult,
                }
            end
        end
    end,
    in_pool = function()
        for _, v in pairs(G.playing_cards) do
            if v.config.center == G.P_CENTERS.m_mult or v.config.center == G.P_CENTERS.m_wild then return true end
        end
        return false
    end,
    atlas = "mxfj_sprites"
}

local is = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(SMODS.find_card('j_mxfj_transmodifly')) and self.ability.effect == 'Mult Card' then
        if not flush_calc or (flush_calc and not self.debuff) then
            return true
        end
    end
    return is(self, suit, bypass_debuff, flush_calc)
end

-- Eldritch Totem --

SMODS.Joker {
    key = "eldritch_totem",
    name = "Eldritch Totem",
    rarity = 2,
    pos = { x = 7, y = 1 },
    cost = 6,
    config = { extra = 2 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_mxfj_cultist
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local jokers_to_create = math.min(card.ability.extra,
                    G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, jokers_to_create do
                            SMODS.add_card({ key = 'j_mxfj_cultist' })
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                    {
                        message = localize { type = 'variable', key = (jokers_to_create == 1 and 'a_mxfj_plus_joker') or 'a_mxfj_plus_jokers', vars = { jokers_to_create } },
                        colour =
                            G.C.BLUE
                    })
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Cultist --

SMODS.Joker {
    key = "cultist",
    name = "Cultist",
    rarity = 1,
    pos = { x = 8, y = 1 },
    cost = 4,
    config = { extra = 0.5 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local Xmlt = math.max(1, 1 + card.ability.extra * (get_cultist_count() - 1))
        return { vars = { card.ability.extra, Xmlt } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local Xmlt = math.max(1, 1 + card.ability.extra * (get_cultist_count() - 1))
            if Xmlt ~= 1 then
                return {
                    Xmult = Xmlt
                }
            end
        end
    end,
    update = function(self, card, dt)
        if card.area and card.area == G.jokers and not next(SMODS.find_card('j_mxfj_eldritch_totem', true)) and not card.mxfj_being_dissolved then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if card and not card.mxfj_being_dissolved then
                        card.mxfj_being_dissolved = true
                        card:start_dissolve({ G.C.RED }, nil, 1.6)
                    end
                    return true
                end
            }))
        end
    end,
    in_pool = function()
        return false
    end,
    atlas = "mxfj_sprites"
}

-- Joker By Default --

SMODS.Joker {
    key = "joker_by_default",
    name = "Joker By Default",
    rarity = 1,
    pos = { x = 9, y = 1 },
    cost = 4,
    config = { extra = 54 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'blue_seal', set = 'Other' }
        local chps = 0
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                if v.seal and v.seal == 'Blue' then
                    chps = chps + card.ability.extra
                end
            end
        end
        return { vars = { card.ability.extra, chps } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local chps = 0
            for _, v in ipairs(G.playing_cards) do
                if v.seal and v.seal == 'Blue' then
                    chps = chps + card.ability.extra
                end
            end
            if chps ~= 0 then
                return {
                    chips = chps
                }
            end
        end
    end,
    in_pool = function()
        for _, v in pairs(G.playing_cards) do
            if v.seal and v.seal == 'Blue' then return true end
        end
        return false
    end,
    atlas = "mxfj_sprites"
}

-- Headless Horseman --

SMODS.DrawStep {
    key = 'mxfj_head',
    order = 41,
    func = function(self)
        if self.config and self.config.center.key == 'j_mxfj_headless_horseman' and self.ability and self.ability.mxfj_head_sprite and self.ability.mxfj_head_show_sprite then
            if not mxfj_mod.mxfj_head_king then
                mxfj_mod.mxfj_head_king = Sprite(0, 0, G.CARD_W, G.CARD_H,
                    G.ASSET_ATLAS["mxfj_sprites"], { x = 1, y = 2 })
            end
            if not mxfj_mod.mxfj_head_queen then
                mxfj_mod.mxfj_head_queen = Sprite(0, 0, G.CARD_W, G.CARD_H,
                    G.ASSET_ATLAS["mxfj_sprites"], { x = 2, y = 2 })
            end
            if not mxfj_mod.mxfj_head_jack then
                mxfj_mod.mxfj_head_jack = Sprite(0, 0, G.CARD_W, G.CARD_H,
                    G.ASSET_ATLAS["mxfj_sprites"], { x = 3, y = 2 })
            end
            if not mxfj_mod.mxfj_head_other then
                mxfj_mod.mxfj_head_other = Sprite(0, 0, G.CARD_W, G.CARD_H,
                    G.ASSET_ATLAS["mxfj_sprites"], { x = 4, y = 2 })
            end
            local face_value = {
                [11] = mxfj_mod.mxfj_head_jack,
                [12] = mxfj_mod.mxfj_head_queen,
                [13] = mxfj_mod.mxfj_head_king,
            }
            mxfj_mod.mxfj_head = face_value[self.ability.mxfj_head_sprite] or mxfj_mod.mxfj_head_other
            mxfj_mod.mxfj_head.role.draw_major = self
            mxfj_mod.mxfj_head:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.edition then
                mxfj_mod.mxfj_head:draw_shader(G.P_CENTERS[self.edition.key].shader, nil, self.ARGS.send_to_shader, nil,
                    self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}

SMODS.Joker {
    key = "headless_horseman",
    name = "Headless Horseman",
    rarity = 2,
    pos = { x = 0, y = 2 },
    cost = 6,
    config = { extra = { xmult = 1, xmult_mod = 0.25 } },
    blueprint_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and no_bp_retrigger(context) and context.scoring_hand and context.full_hand then
            local faces = {}
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_face() and SMODS.in_scoring(context.full_hand[i], context.scoring_hand) then
                    faces[#faces + 1] = context.full_hand[i]
                end
            end
            card.ability.mxfj_card_to_destroy = faces[#faces]
        end
        if context.destroy_card and context.destroy_card ~= card and card.ability.mxfj_card_to_destroy and no_bp_retrigger(context) then
            if context.destroy_card == card.ability.mxfj_card_to_destroy then
                card.ability.mxfj_card_to_destroy = nil
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                card.ability.mxfj_head_sprite = context.destroy_card:get_id()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.mxfj_head_show_sprite = true
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    colour = G.C.FILTER
                })
                return true
            end
        end
        if context.joker_main and card.ability.extra.xmult ~= 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    atlas = "mxfj_sprites"
}

-- Prepper --

SMODS.Joker {
    key = "prepper",
    name = "Prepper",
    rarity = 1,
    pos = { x = 5, y = 2 },
    cost = 4,
    config = { extra = { mult = 0, mult_mod = 10 } },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and no_bp_retrigger(context) then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and not (context.individual or context.repetition) and no_bp_retrigger(context) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.mult = 0
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    })
                    return true
                end
            }))
        end
    end,
    atlas = "mxfj_sprites"
}

if Partner_API then
    -- Survive --

    Partner_API.Partner {
        key = "prepper",
        name = "Prepper Partner",
        unlocked = false,
        discovered = true,
        pos = { x = 0, y = 0 },
        atlas = "mxfj_partners",
        config = { extra = { mult = 0, mult_mod = 3, mult_extra = 3 } },
        link_config = { j_mxfj_prepper = 1 },
        loc_vars = function(self, info_queue, card)
            local benefits = ((next(SMODS.find_card("j_mxfj_prepper")) and card.ability.extra.mult_extra) or 0)
            local _mult_mod = card.ability.extra.mult_mod + benefits
            return { vars = { _mult_mod, card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
            if context.before then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod +
                    ((next(SMODS.find_card("j_mxfj_prepper")) and card.ability.extra.mult_extra) or 0)
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                }
            end
            if context.joker_main and card.ability.extra.mult > 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
            if context.end_of_round and not context.individual and not context.repetition then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.mult = 0
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        })
                        return true
                    end
                }))
            end
        end,
        check_for_unlock = function(self, args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == "j_mxfj_prepper" then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }
end

-- Odontophobia --

SMODS.Joker {
    key = "odontophobia",
    name = "Odontophobia",
    rarity = 2,
    pos = { x = 6, y = 2 },
    cost = 6,
    config = { extra = 1.32 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.end_of_round then
            if context.other_card:is_face() then
                return {
                    Xmult = card.ability.extra
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Pod Joker --

SMODS.Joker {
    key = "pod",
    name = "Pod Joker",
    rarity = 2,
    pos = { x = 7, y = 2 },
    cost = 6,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not card.getting_sliced and no_bp_retrigger(context) then
            local valid_jokers = {}
            if G.jokers and G.jokers.cards and #G.jokers.cards > 1 then
                for i = 1, #G.jokers.cards do
                    if not G.jokers.cards[i].debuff and G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center.key ~= "j_mxfj_pod" then
                        valid_jokers[#valid_jokers + 1] = G.jokers.cards[i]
                    end
                end
            end
            if #valid_jokers > 0 then
                local chosen_joker = pseudorandom_element(valid_jokers, pseudoseed('pod'))
                card.ability.mxfj_is_pod = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.3, 0.4)
                        card:set_ability(G.P_CENTERS[chosen_joker.config.center.key], true)
                        card:set_cost()
                        for k, v in pairs(chosen_joker.ability) do
                            if type(v) == 'table' then
                                card.ability[k] = copy_table(v)
                            elseif not SMODS.Stickers[k] then
                                card.ability[k] = v
                            end
                        end
                        return true
                    end
                }))
            end
        end
    end,
    in_pool = function()
        if G.jokers and G.jokers.cards then
            for _, v in ipairs(G.jokers.cards) do
                if v.ability and v.ability.mxfj_is_pod then return false end
            end
        end
        return true
    end,
    atlas = "mxfj_sprites"
}

local cj = Card.calculate_joker
function Card:calculate_joker(context)
    if self.ability and self.ability.mxfj_is_pod and not self.getting_sliced and no_bp_retrigger(context) then
        if context.cardarea == G.jokers and context.after then
            local valid_jokers = {}
            if G.jokers and G.jokers.cards and #G.jokers.cards > 1 then
                for i = 1, #G.jokers.cards do
                    if not G.jokers.cards[i].debuff and G.jokers.cards[i] ~= self and G.jokers.cards[i].config.center.key ~= "j_mxfj_pod" then
                        valid_jokers[#valid_jokers + 1] = G.jokers.cards[i]
                    end
                end
            end
            if #valid_jokers > 0 then
                local chosen_joker = pseudorandom_element(valid_jokers, pseudoseed('pod'))
                self.ability.mxfj_is_pod = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        self:juice_up(0.3, 0.4)
                        self:set_ability(G.P_CENTERS[chosen_joker.config.center.key], true)
                        self:set_cost()
                        for k, v in pairs(chosen_joker.ability) do
                            if type(v) == 'table' then
                                self.ability[k] = copy_table(v)
                            elseif not SMODS.Stickers[k] then
                                self.ability[k] = v
                            end
                        end
                        return true
                    end
                }))
            end
        elseif context.starting_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    self:juice_up(0.3, 0.5)
                    self:set_ability(G.P_CENTERS["j_mxfj_pod"], true)
                    self:set_cost()
                    self.ability.mxfj_is_pod = nil
                    return true
                end
            }))
        end
    end
    return cj(self, context)
end

-- The Twins --

SMODS.Joker {
    key = "twins",
    name = "The Twins",
    rarity = 3,
    pos = { x = 8, y = 2 },
    cost = 8,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_double
    end,
    calculate = function(self, card, context)
        if context.mfxfj_pre_skip and no_bp_retrigger(context) then
            add_tag(Tag('tag_double'))
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        end
    end,
    atlas = "mxfj_sprites"
}

-- Man-phibian --

SMODS.Joker {
    key = "manphibian",
    name = "Man-phibian",
    rarity = 1,
    pos = { x = 9, y = 2 },
    cost = 4,
    config = { extra = 8 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card and context.other_card.ability.effect ~= "Base" then
                return {
                    mult = card.ability.extra
                }
            end
        end
    end,
    atlas = "mxfj_sprites"
}

-- Delivery Boy --

SMODS.Joker {
    key = "delivery",
    name = "Delivery Boy",
    atlas = "mxfj_sprites",
    rarity = 2,
    pos = { x = 2, y = 3 },
    soul_pos = { x = 3, y = 3 },
    cost = 6,
    config = { extra = {} },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and
            context.main_eval and G.GAME.blind.boss and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Food',
                        key_append = 'jokedash'
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_mxfk_delivery'),
                colour = G.C.GREEN,
            }
        end
    end
}

-- Guitar Pick --

SMODS.Joker {
    key = "guitar_pick",
    blueprint_compat = true,
    atlas = "mxfj_sprites",
    rarity = 2,
    cost = 6,
    pos = { x = 4, y = 3 },
    config = { extra = { poker_hand = 'High Card', repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands'), card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.scoring_name == card.ability.extra.poker_hand then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'guitarDoIt')
            return {
                message = localize('k_reset')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible and k ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
            (card.area and card.area.config.type == 'title') and 'guitarNoDoIt' or 'guitarDoIt')
    end
}

-- Jokers96 --

SMODS.Joker {
    key = "jokers96",
    blueprint_compat = false,
    atlas = "mxfj_sprites",
    rarity = 3,
    cost = 7,
    pos = { x = 0, y = 3 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'red_seal', set = 'Other' }
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return {}
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local seals = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.seal == "Red" then
                    seals = seals + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:set_edition("e_polychrome", true)
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if seals > 0 then
                return {
                    message = localize('k_mxfj_aesthetic'),
                    colour = G.C.RED
                }
            end
        end
    end
}

-- Mariachi --
SMODS.Joker {
    key = "mariachi",
    config = {
        extra = {
            add_chips = 30,
            chips = 0,
            counter = 0
        }
    },
    rarity = 1,
    pos = { x = 5, y = 3 },
    atlas = "mxfj_sprites",
    cost = 3,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add_chips, card.ability.extra.chips, card.ability.extra.counter } }
    end,
    calculate = function(self, card, context)
        --if G.play and not context.blueprint then
        --    card.ability.extra.chips = card.ability.extra.chips - #context.scoring_hand * card.ability.extra.add_chips
        --end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.counter = card.ability.extra.counter + 1
            if card.ability.extra.counter > #context.scoring_hand then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add_chips
            end
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.after and not context.blueprint then
            card.ability.extra.chips = 0
            card.ability.extra.counter = 0
        end
    end,
}

-- Match Box --
SMODS.Joker {
    key = "match_box",
    config = {
        extra = {
            dollars = 10,
            dollars_mod = 2,
        }
    },
    rarity = 1,
    pos = { x = 0, y = 0 },
    atlas = "mxfj_match_box",
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod } }
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step and no_bp_retrigger(context) then
            if to_big(G.GAME.blind.chips) <= to_big(hand_chips) * to_big(mult) then
                local dollars = card.ability.extra.dollars
                card.ability.mxfj_matchbox_trigger = (card.ability.mxfj_matchbox_trigger or 0) + 1
                card.ability.extra.dollars = card.ability.extra.dollars - card.ability.extra.dollars_mod
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if not (card.ability.mxfj_matchbox_trigger > 4) then
                            card.children.center:set_sprite_pos { x = card.ability.mxfj_matchbox_trigger, y = 0 }
                        end
                        return true
                    end
                }))
                return {
                    dollars = dollars,
                    extra = {
                        message = localize { type = 'variable', key = 'a_mxfj_dollars_minus', vars = { card.ability.extra.dollars_mod } },
                        colour = G.C.MONEY
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.after and no_bp_retrigger(context) then
            if card.ability.extra.dollars <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_mxfk_match_box'),
                    colour = G.C.MONEY
                }
            end
        end
    end
}

-- Record Shop
SMODS.Joker {
    key = "record_shop",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 3 },
    atlas = "mxfj_sprites",
    config = { extra = { Xmult = 1, Xmult_mod = 0.1, card_index = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            local in_index = false
            for _, i in ipairs(card.ability.extra.card_index) do
                if i == context.consumeable.config.center.key then
                    in_index = true
                    break
                end
            end
            if not in_index then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                card.ability.extra.card_index[#card.ability.extra.card_index + 1] = context.consumeable.config.center
                    .key

                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
                }
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker {
    key = "strongman",
    blueprint_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 6, y = 3 },
    atlas = "mxfj_sprites",
    config = { extra = { type = 'Two Pair' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.type } }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint and next(context.poker_hands[card.ability.extra.type]) then
            --[[local rank_counts = {}
            for k, v in ipairs(context.scoring_hand) do
                rank_counts[v:get_id()] = (rank_counts[v:get_id()] or 0) + 1
            end

            local lowest_rank = nil
            for k, v in pairs(rank_counts) do
                if v == 2 and (lowest_rank == nil or k < lowest_rank) then
                    lowest_rank = k
                end
            end]] --

            local lowest_rank = nil
            for k, v in ipairs(context.scoring_hand) do
                if lowest_rank == nil or v:get_id() < lowest_rank then
                    lowest_rank = v:get_id()
                end
            end

            if lowest_rank then
                local lowest_cards = {}
                for k, v in ipairs(context.scoring_hand) do
                    if v:get_id() == lowest_rank then lowest_cards[#lowest_cards + 1] = v end
                end

                for i = 1, #lowest_cards do
                    local percent = 1.15 - (i - 0.999) / (#lowest_cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            lowest_cards[i]:flip()
                            play_sound('card1', percent)
                            lowest_cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                delay(0.2)
                for i = 1, #lowest_cards do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                            assert(SMODS.modify_rank(lowest_cards[i], 1))
                            return true
                        end
                    }))
                end
                for i = 1, #lowest_cards do
                    local percent = 0.85 + (i - 0.999) / (#lowest_cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            lowest_cards[i]:flip()
                            play_sound('tarot2', percent, 0.6)
                            lowest_cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
        end
    end
}

SMODS.Joker {
    key = "timbo_jruise",
    blueprint_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 9, y = 3 },
    atlas = "mxfj_sprites",
    config = { extra = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.seal then
            return { dollars = card.ability.extra }
        end
    end
}

SMODS.Joker {
    key = "key_card",
    blueprint_compat = false,
    perishable_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 7, y = 3 },
    atlas = "mxfj_sprites",
    calculate = function(self, card, context)
        if context.setting_blind then
            local me = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then me = i end
            end
            for i = 1, #G.jokers.cards do
                if i < me then
                    G.jokers.cards[i]:set_eternal(false)
                    G.jokers.cards[i]:juice_up()
                end
                if i > me and G.jokers.cards[i].config.center.eternal_compat then
                    G.jokers.cards[i]:set_eternal(true)
                    G.jokers.cards[i]:juice_up()
                end
            end
        end
    end
}

SMODS.Joker {
    key = "flesh_golem",
    blueprint_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 8, y = 3 },
    atlas = "mxfj_sprites",
    config = { extra = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local suits = 0
            for k, v in pairs(SMODS.Suits) do
                if (not v.in_pool or v:in_pool({})) and context.other_card:is_suit(k) then
                    suits = suits + 1
                end
            end
            if suits > 0 then return { mult = card.ability.extra * suits } end
        end
    end
}

SMODS.Joker {
    key = "pinup_joker",
    blueprint_compat = true,
    perishable_compat = true,
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 4 },
    atlas = "mxfj_sprites",
    config = { extra = { Xmult = 1.5, retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.retriggers, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 11 and SMODS.has_enhancement(context.other_card, "m_wild") then
            return { xmult = card.ability.extra.Xmult }
        end
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 11 and SMODS.has_enhancement(context.other_card, "m_wild") then
            return { repetitions = card.ability.extra.retriggers }
        end
    end
}









SMODS.Back {
    key = 'unicorn',
    atlas = 'mxfj_decks',
    pos = { x = 0, y = 0 },
    config = {
        jokers = {
            'j_mxfj_wheres_jimbo'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize { type = 'name_text', set = 'Joker', key = 'j_mxfj_wheres_jimbo' } } }
    end
}



























-- Friends of Jimbo

local suits = { 'hearts', 'clubs', 'diamonds', 'spades' }
local ranks = { 'Jack', 'Queen', "King" }

local descriptions = { 'Monster Prom', 'Dead Ahead', 'Castle Crashers', 'TheKiltedDungeoneer' }

SMODS.Atlas {
    key = 'mxfj_foj_lc',
    px = 71,
    py = 95,
    path = 'mxfj_foj_lc.png',
    prefix_config = { key = false }
}

SMODS.Atlas {
    key = 'mxfj_foj_hc',
    px = 71,
    py = 95,
    path = 'mxfj_foj_hc.png',
    prefix_config = { key = false }
}

for i, suit in ipairs(suits) do
    SMODS.DeckSkin {
        key = suit .. "_skin",
        suit = suit:gsub("^%l", string.upper),
        ranks = ranks,
        lc_atlas = 'mxfj_foj_lc',
        hc_atlas = 'mxfj_foj_hc',
        loc_txt = { ['en-us'] = descriptions[i] },
        posStyle = 'deck'
    }
end
