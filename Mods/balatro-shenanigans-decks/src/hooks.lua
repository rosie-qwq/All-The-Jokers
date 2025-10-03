local ref_showman = SMODS.showman
function SMODS.showman(card_key)
    if G.GAME.starting_params.showmandeck then
        return true
    end
    return ref_showman(card_key)
end

local ref_discard_cards_from_highlighted = G.FUNCS.discard_cards_from_highlighted
function G.FUNCS.discard_cards_from_highlighted(e, hook)
    if G.GAME.starting_params.yorickdeck then
        for i = 1, #G.hand.highlighted do
            for j = 1, #G.hand.cards do
                if G.hand.cards[j] == G.hand.highlighted[i] then
                    G.hand.cards[j].trigger_yorick_effect_card = true
                end
            end
        end
        SMODS.calculate_end_of_round_effects({ trigger_yorick_effect = true, cardarea = G.hand, end_of_round = true })
        for j = 1, #G.hand.cards do
            if G.hand.cards[j].trigger_yorick_effect_card == true then
                G.hand.cards[j].trigger_yorick_effect_card = nil
            end
        end
    end
    local r_val = ref_discard_cards_from_highlighted(e, hook)
    return r_val
end

local ref_eval_card = eval_card
function eval_card(card, context)
    if G.GAME.starting_params.yorickdeck and context.trigger_yorick_effect then
        if (card.trigger_yorick_effect_card == nil and card.playing_card)
            or
            (context.other_card and -- https://www.youtube.com/watch?v=9dOEUErDOG8&
                context.other_card.playing_card and
                context.other_card.trigger_yorick_effect_card == nil)
        then
            return {}, {}
        end
    end
    return ref_eval_card(card, context)
end

local ref_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local r_val = ref_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.GAME.starting_params.freakydeck then
        if _type == "Joker" then
            if G.GAME.starting_params.freakysleeve then
                local n = pseudorandom('freaky', 0, 9)
                r_val.ability.freaky_effect = n
            else
                if pseudorandom('freaky') < 1 / 2 then
                    r_val.ability.freaky_effect = 6
                else
                    r_val.ability.freaky_effect = 9
                end
            end
        end
    end
    if G.GAME.starting_params.perkeodeck then
        if _type == 'Tarot' or _type == 'Planet' or _type == 'Spectral' or _type == 'Tarot_Planet' then
            local eval = function(card) return (G.GAME.starting_params.consumables_used + 1) % 4 == 0 end
            juice_card_until(r_val, eval, true)
        end
    end
    return r_val
end

local ref_card_add_to_deck = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local r_val = ref_card_add_to_deck(self, from_debuff)
    if G.GAME.starting_params.cartomancersleeve then
        if self.ability.set == 'Tarot' then
            if SMODS.pseudorandom_probability(self, pseudoseed('cartomancersleeve'), 1, 3, 'cartomancersleeve') then
                self:set_edition({ negative = true }, true)
            end
        end
    end
    return r_val
end

local freak_keys = {
    ["1"] = 'freaky_one',
    ["2"] = 'freaky_two',
    ["3"] = 'freaky_three',
    ["4"] = 'freaky_four',
    ["5"] = 'freaky_five',
    ["6"] = 'freaky_six',
    ["7"] = 'freaky_seven',
    ["8"] = 'freaky_eight',
    ["9"] = 'freaky_nine',
    ["0"] = 'freaky_zero',
}

local ref_card_from_control = card_from_control
function card_from_control(control)
    if G.GAME.starting_params.diplopiadeck then
        ref_card_from_control(control)
    end
    return ref_card_from_control(control)
end

local ref_generate_card_ui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local r_val = ref_generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start,
        main_end, card)
    if r_val.card_type ~= nil and r_val.card_type == "Joker" then
        if G.GAME.starting_params.freaky_ui then
            local k = freak_keys[G.GAME.starting_params.freaky_ui]
            G.GAME.starting_params.freaky_ui = nil
            ref_generate_card_ui({ key = k, set = 'Other' }, r_val)
        end
    end
    return r_val
end

local ref_generate_UIBox_ability_table = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table(vars_only, ...)
    if self.ability.freaky_effect then
        G.GAME.starting_params.freaky_ui = tostring(self.ability.freaky_effect)
    else
        G.GAME.starting_params.freaky_ui = nil
    end
    return ref_generate_UIBox_ability_table(self, vars_only, ...)
end

local ref_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
    local r_val = ref_calculate_joker(self, context)
    if G.GAME.starting_params.chicotdeck == true then
        if context.retrigger_joker_check and context.other_card == self and G.GAME.blind.boss and G.jokers.cards and self == G.jokers.cards[#G.jokers.cards] then
            return {
                message = localize("k_again_ex"),
                repetitions = 1,
                message_card = self,
                was_blueprinted = context.blueprint,
            }
        end
    end
    return r_val
end

local ref_back_trigger_effect = Back.trigger_effect
function Back:trigger_effect(args)
    local r_val = ref_back_trigger_effect(self, args)
    if G.GAME.temple_score_balance and args.context == 'final_scoring_step' then
        local tot = args.chips + args.mult
        args.chips = math.floor(tot * .64)
        args.mult = math.floor(tot * .48)
        update_hand_text({ delay = 0 }, { mult = args.mult, chips = args.chips })

        G.E_MANAGER:add_event(Event({
            func = (function()
                local text = localize('k_balanced')
                play_sound('shen_temple', 1, 1)
                ease_colour(G.C.UI_CHIPS, G.C.CYAN)
                ease_colour(G.C.UI_MULT, G.C.CYAN)
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = { x = 0, y = -2.7 }, major = G.play
                })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    delay = 4.3,
                    func = (function()
                        ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                        ease_colour(G.C.UI_MULT, G.C.RED, 2)
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    no_delete = true,
                    delay = 6.3,
                    func = (function()
                        G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2],
                            G.C.BLUE[3], G.C.BLUE[4]
                        G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2],
                            G.C.RED[3], G.C.RED[4]
                        return true
                    end)
                }))
                return true
            end)
        }))

        delay(0.6)
        return args.chips, args.mult
    end
    return r_val
end
