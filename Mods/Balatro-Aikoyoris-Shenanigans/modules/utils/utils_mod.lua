

AKYRS.game_areas = function(area)
    return area == G.play or area == G.hand or area == G.deck or area == G.discard or area == G.jokers or area == G.consumeables or nil
end
AKYRS.sigmaable_areas = function(area)
    return area == G.hand or area == G.deck or area == G.discard or area == G.jokers or area == G.consumeables or nil
end
AKYRS.non_removing_play_state = function()
    return G.STATE == G.STATES.DRAW_TO_HAND or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.ROUND_EVAL
end
AKYRS.is_card_not_sigma = function(card) 
    return card.ability.consumeable or card.ability.set == "Booster" or card.ability.set == "Voucher" or nil
end

AKYRS.nope_buzzer = function(major, text, colour, rotate, scale, hold)
    play_sound("akyrs_loud_incorrect_buzzer",1,0.2)
    attention_text({
        text = text or localize("k_nope_ex"),
        scale = scale or 1, 
        hold = hold or 1.0,
        rotate = rotate or math.pi / 8,
        backdrop_colour = colour or G.GAME.blind.boss_colour,
        align = "cm",
        major = major or G.GAME.blind,
        offset = {x = 0, y = 0.1}
    })
end


function AKYRS.get_p_card_ranks(not_r)
    not_r = not_r or {}
    local ranks = {}
    if not G.playing_cards then return {} end
    for i,j in ipairs(G.playing_cards) do
        --print(j.base.value)
        if j and not SMODS.has_no_rank(j) and j.base.value and SMODS.Ranks[j.base.value] and not not_r[j.base.value] and not AKYRS.find_index(ranks,SMODS.Ranks[j.base.value]) then
            table.insert(ranks,SMODS.Ranks[j.base.value])
        end
    end
    return ranks
end

AKYRS.sort_top = function(a, b)
    return (a.akyrs_stay_on_top or 0) < (b.akyrs_stay_on_top or 0)
end

AKYRS.should_hide_ui = function()
    return next(SMODS.find_card("j_akyrs_no_hints_here")) or G.GAME.akyrs_no_hints or nil
end


AKYRS.blacklist_mod = {
    ["cry_prob"] = true,
    ["akyrs_cycler"] = true,
    ["immutable"] = true,
    ["pos"] = true,
    ["atlas"] = true,
    ["soul_pos"] = true,
}

AKYRS.edition_extend_card_limit = function(card)
    if card then
        if card.edition then
            if card.edition.key == "e_negative" then
                return 1
            end
            if card.edition.key == "e_akyrs_noire" then
                return 2
            end
        end
    end
    return 0
end

AKYRS.card_any_drag = function()
    return G and G.GAME and ((G.GAME.akyrs_any_drag and not G.OVERLAY_MENU) or G.GAME.akyrs_ultimate_freedom)
end

AKYRS.construct_case_base = function(suit, rank)
    
    local _suit = SMODS.Suits[suit]
    local _rank = SMODS.Ranks[rank]
    if not _suit or not _rank then
        return nil, ('Tried to call SMODS.change_base with invalid arguments: suit="%s", rank="%s"'):format(suit, rank)
    end
    return G.P_CARDS[('%s_%s'):format(_suit.card_key, _rank.card_key)]
end


AKYRS.bal = function(balance)
    if balance then
        return G.PROFILES[G.SETTINGS.profile].akyrs_balance == balance
    end
    return G.PROFILES[G.SETTINGS.profile].akyrs_balance
end

AKYRS.set_bal = function(balance)
    G.PROFILES[G.SETTINGS.profile].akyrs_balance = balance
end

AKYRS.toggle_bal = function(balance)
    G.PROFILES[G.SETTINGS.profile].akyrs_balance = G.PROFILES[G.SETTINGS.profile].akyrs_balance == "adequate" and "absurd" or "adequate"
end

AKYRS.bal_overridable = function(balance, override)
    return override and AKYRS.bal(override) or AKYRS.bal(balance)
end

AKYRS.bal_val = function(adeq,absu)
    if AKYRS.bal("adequate") then return adeq end
    if AKYRS.bal("absurd") then return absu end
end

AKYRS.bal_val_overridable = function(adeq,absu,override)
    if AKYRS.bal_overridable("adequate",override) then return adeq end
    if AKYRS.bal_overridable("absurd",override) then return absu end
end


function AKYRS.bulk_level_up(center, card, area, copier, number, silent)
	local used_consumable = copier or card
	if not number then
		number = 1
	end
	for _, v in pairs(card.config.center.config.akyrs_hand_types) do
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(v, "poker_hands"),
			chips = G.GAME.hands[v].chips,
			mult = G.GAME.hands[v].mult,
			level = G.GAME.hands[v].level,
		})
		level_up_hand(used_consumable, v, silent, number)
	end
	update_hand_text(
		{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
		{ mult = 0, chips = 0, handname = "", level = "" }
	)
end

function AKYRS.silent_bulk_level_up(center, card, area, copier, number)
	local used_consumable = copier or card
	if not number then
		number = 1
	end

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_words_long'),chips = '...', mult = '...', level=''})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        play_sound('tarot1')
        card:juice_up(0.8, 0.5)
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))
    update_hand_text({delay = 0}, {mult = '+', StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        card:juice_up(0.8, 0.5)
        return true end }))
    update_hand_text({delay = 0}, {chips = '+', StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        card:juice_up(0.8, 0.5)
        G.TAROT_INTERRUPT_PULSE = nil
        return true end }))
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
    delay(1.3)
    for k, v in pairs(card.config.center.config.akyrs_hand_types) do
		level_up_hand(used_consumable, v, true, number)
    end
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
end

function AKYRS.blk_lvl_up(hands, card, number)
	local used_consumable = card
	if not number then
		number = 1
	end

    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_akyrs_multiple_hands'),chips = '...', mult = '...', level=''})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        play_sound('tarot1')
        if card then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))
    update_hand_text({delay = 0}, {mult = '+', StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        if card then card:juice_up(0.8, 0.5) end
        return true end }))
    update_hand_text({delay = 0}, {chips = '+', StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        if card then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = nil
        return true end }))
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
    delay(1.3)
    for k, v in pairs(hands) do
		level_up_hand(used_consumable, k, true, number)
    end
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
end


AKYRS.shallow_indexed_table_copy = function(t)
    local t2 = {}
    for i,k in ipairs(t) do
        table.insert(t2,k)
    end
    return t2
end

AKYRS.get_current_blind_config = function()
    return G.P_BLINDS[G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]]
end

function AKYRS.search_UIT_for_id(uit, id)
    if not id or not uit then return nil end
    for _, node in ipairs(uit.nodes or {}) do
        if node.config and node.config.id == id then
            return node
        elseif node.nodes then
            local result = AKYRS.search_UIT_for_id(node, id)
            if result then
                return result
            end
        end
    end
    return nil
end


AKYRS.icon_sprites = {}

AKYRS.remove_formatting = function(string_in)
    return string.gsub(string_in, "{.-}", "")
end
AKYRS.full_ui_add = function(nodes, key, scale)
    local m = G.localization.descriptions["DescriptionDummy"][key]
    if not m then assert("You forgot the localization!") end
    local l = {
        {
            n = G.UIT.R,
            nodes = {
                { n = G.UIT.T, config = { text = m.name, colour = G.C.UI.TEXT_LIGHT, scale = scale*1.2 }},
            }
        }
    }
    if m.text and false then
        for i, tx in ipairs(m.text) do
            table.insert(l, 
                {
                    n = G.UIT.R,
                    nodes = {
                        { n = G.UIT.T, config = { text = AKYRS.remove_formatting(tx), colour = G.C.UI.TEXT_LIGHT, scale = scale }},
                    }
                }
            )
        end
    end
    
    local x = {
        n = G.UIT.C,
        config = { align = "lm", padding = 0.1 },
        nodes = {
            { n = G.UIT.R, config = {}, nodes = l },
            
        }
    }
    table.insert(nodes, x)
end

AKYRS.hand_sort_function = function (a,b)
    if G.GAME and G.GAME.words_reversed then
        return a.T.x > b.T.x
    end
    return a.T.x < b.T.x    
end

AKYRS.hand_sort_function_immute = function (a,b)
    return a.T.x < b.T.x    
end


G.FUNCS.go_to_aikoyori_discord_server = function(e)
    love.system.openURL( "https://discord.gg/JVg8Bynm7k" )
end


AKYRS.get_letter_freq_from_cards = function(listofcards)
    
    local wordArray = {}
    for i,v in ipairs(listofcards) do
        local w = string.lower(v:get_letter_with_pretend())
        wordArray[w] = wordArray[w] and wordArray[w] + 1 or 1
    end
    return wordArray
end
AKYRS.get_ranks_freq_from_cards = function(listofcards)
    
    local wordArray = {}
    for i,v in ipairs(listofcards) do
        if not SMODS.has_no_rank(v) then
            local w = v:get_id()
            wordArray[w] = wordArray[w] and wordArray[w] + 1 or 1
        end
    end
    return wordArray
end

AKYRS.get_suit_freq_from_cards = function(listofcards, no_count_wild)
    
    local wordArray = {}
    for i,v in ipairs(listofcards) do
        if not SMODS.has_no_suit(v) then
            if no_count_wild and v.base and v.base.suit then
                wordArray[v.base.suit] = wordArray[v.base.suit] and wordArray[v.base.suit] + 1 or 1
            else
                for j,st in pairs(SMODS.Suits) do
                    if v:is_suit(j) then
                        wordArray[j] = wordArray[j] and wordArray[j] + 1 or 1
                    end
                end
            end
        end
    end
    return wordArray
end

function AKYRS.is_valid_enhancement(name)
    for _, v in pairs(G.P_CENTER_POOLS.Enhanced) do
        local first_part = string.split(v.name," ")[1]
        if first_part == name then
            return true
        end
    end
    return false
end

function AKYRS.is_valid_edition(name)
    for _, v in pairs(G.P_CENTER_POOLS.Edition) do
        if v.name == name then
            return true
        end
    end
    return false
end

function AKYRS.recalculate_cardarea_bundler(cardarea, func, reset)
    local logic = func or function(x) return x.states.drag.is or x.states.click.is end
    for k, card in ipairs(cardarea.cards) do -- G.CONTROLLER.hovering.target.area.cards
        if logic(card) then
            
            card.following_cards = reset and {} or (card.following_cards or {})
            for ke, card2 in ipairs(cardarea.cards) do
                if ke > k and not AKYRS.is_in_table(card.following_cards,card2) and not card2.is_being_pulled then
                    table.insert(card.following_cards, card2)
                    --print(AKYRS.C2S(card2))
                    --print("CARDS IN THE THING - "..AKYRS.TBL_C2S(card.following_cards))
                    
                end
            end
        end

    end
    cardarea.last_card_amnt = #cardarea.cards
end
function AKYRS.reset_cardarea_bundler(cardarea)
    for k, card in ipairs(cardarea.cards) do -- G.CONTROLLER.hovering.target.area.cards
        card.following_cards = nil

    end
end

AKYRS.crypternity = function (e)
    e.akyrs_sigma = true
    return e
end


AKYRS.word_to_cards = function(word)
    
    local wordArray = AKYRS.word_splitter(word)
    local cards = {}
    for i, k in ipairs(wordArray) do
        local new_c = AKYRS.create_random_card("maxwellui")
        new_c.is_null = true
        new_c:set_letters(k)
        new_c.ability.forced_letter_render = true
        table.insert(cards, new_c)
    end
    return cards
end

AKYRS.w2hand = function( word )
    local t = AKYRS.word_to_cards( word )
    for _,c in ipairs(t) do table.insert(G.playing_cards,c) G.hand:emplace(c) end
end

AKYRS.mod_card_values = function(table_in, config)
    if not config then config = {} end
    local add = config.add or 0
    local multiply = config.multiply or 1
    local keywords = config.keywords or {}
    local unkeyword = config.unkeywords or {}
    local reference = config.reference or table_in
    local randomize = config.random

    local function modify_values(table_in, ref, depth)
        if depth > 2 then return end
        for k, v in pairs(table_in) do 
            local rand = 1
            if randomize then
                local val = pseudorandom("akyrs_mod_val")
                local val2 = pseudorandom("akyrs_mod_val_2",randomize.digits_min, randomize.digits_max)
                rand = val * 10 ^ val2
            end
            
            if type(v) == "number" then
                if (keywords[k] or #keywords < 1) and not unkeyword[k] then
                    if ref and ref[k] then
                        table_in[k] = (ref[k] + add) * multiply * rand
                    end
                end
            elseif Talisman and type(v) == "table" and v.to_number and (to_number(v) == v) then
                if (keywords[k] or #keywords < 1) and not unkeyword[k] then
                    if ref and ref[k] then
                        table_in[k] = (to_big(ref[k]) + to_big(add)) * to_big(multiply) * to_big(rand)
                    end
                end
            elseif type(v) == "table" and ref and k and not unkeyword[k] then
                modify_values(v, ref[k], depth + 1)
            end
        end
    end
    if table_in == nil then
        return
    end
    if type(reference) == 'table' then
        modify_values(table_in, reference, 0)
    end
end

AKYRS.mod_card_values_misprint = function(table_in, config)
    if not config then config = {} end
    local add = config.add or 0
    local multiply = config.multiply or 1
    local randomize = config.random or {digits_min = 1, digits_max = 1, min = 1, max = 1,scale = 1 }
    local random_seed = config.randomseed or "modcardvalue"
    random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. " - " .. random_seed
    local keywords = config.keywords or {}
    local unkeyword = config.unkeywords or AKYRS.blacklist_mod or {}
    local function_check = config.func or function(name, value) return true end
    local reference = config.reference or table_in
    local function modify_values(table_in, ref)
        for k, v in pairs(table_in) do
            if type(v) == "number" then
                if (keywords[k] or #keywords < 1) and not unkeyword[k] then
                    if ref and ref[k] and function_check(k,ref[k]) then
                        local numberstr = randomize.can_negate and pseudorandom_element({"","-",pseudoseed(random_seed.."a")}) or ""
                        local digits = pseudorandom(pseudoseed(random_seed.."ab"),randomize.digits_min,randomize.digits_max)
                        for i = 1,digits do
                            numberstr = numberstr .. pseudorandom(pseudoseed(random_seed.."b"),0,9)
                        end
                        if numberstr == "" or numberstr == "-" then
                            numberstr = "0"
                        end
                        local number = tonumber(numberstr) * (10 ^ randomize.scale)
                        number = math.fmod(number,randomize.max - randomize.min) + randomize.min
                        table_in[k] = (ref[k] + add) * multiply * number
                    end
                end
            elseif type(v) == "table" and ref and k then
                modify_values(v, ref[k])
            end
        end
    end
    if table_in == nil then
        return
    end
    modify_values(table_in, reference)
end

AKYRS.get_suits = function(tbl_o_cards) 
    local s = {}
    local st = {}
    for _,card in ipairs(tbl_o_cards) do
        for suit,_ in pairs(SMODS.Suits) do
            if card:is_suit(suit) and not st[suit] then
                table.insert(s,suit)
                st[suit] = true
            end
        end
    end
    return s,st
end

AKYRS.mod_debug_info_set = function ()
    AKYRS.debug_info = {
        ["Balance"] = AKYRS.bal() or "BALANCE NOT SET."
    }
end
AKYRS.mod_debug_info_set()

AKYRS.should_draw_letter = function(card)
    return G.GAME.akyrs_character_stickers_enabled or (card.ability and card.ability.forced_letter_render) or AKYRS.word_blind()
end
AKYRS.should_calculate_word = function(card)
    return (G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled) or AKYRS.word_blind()
end


AKYRS.force_check_win = function (config)
    config = config or {}
    if not G.GAME.blind or G.GAME.akyrs_win_checked then return end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        delay = 0,
        func = function()
            local new_round
            if G.GAME.akyrs_win_checked then return true end
            if not G.GAME.akyrs_mathematics_enabled and not G.GAME.current_round.advanced_blind then
                if AKYRS.compare(G.GAME.chips,">=",G.GAME.blind.chips) or AKYRS.compare(G.GAME.current_round.hands_left,"<",1) then
                    new_round = true
                end
            end
            if G.GAME.current_round.advanced_blind and G.GAME.aiko_puzzle_win or G.GAME.current_round.hands_left < 1 then
                if G.GAME.aiko_puzzle_win or G.GAME.current_round.hands_left < 1 then
                    new_round = true
                end
            elseif G.GAME.akyrs_mathematics_enabled and G.GAME.akyrs_character_stickers_enabled then
                if (G.GAME.blind and AKYRS.is_value_within_threshold(G.GAME.blind.chips, G.GAME.chips, G.GAME.akyrs_math_threshold)) or AKYRS.compare(G.GAME.current_round.hands_left,"<",1) or AKYRS.does_hand_only_contain_symbols(G.hand) then
                    new_round = true
                end
            end
            if new_round then
                G.GAME.akyrs_win_checked = true
            end
            if new_round and not config.no_winnage then
                G.STATE = G.STATES.NEW_ROUND
                G.STATE_COMPLETE = false
            elseif not new_round then
                G.STATE = config.state_to_go or G.STATES.SELECTING_HAND
                if config.force_draw then
                    G.FUNCS.draw_from_deck_to_hand()
                end
            end
            G.STATE_COMPLETE = false
            return true
        end
    }))
end

AKYRS.set_special_card_type = function(card, type)
    if card and card.ability then card.ability.akyrs_special_card_type = type 
        card:set_sprites(card.config.center,card.config.card)
    end
end

AKYRS.initialise_deck_letter = function(letters)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.playing_cards = {}
            
            local deckloop = G.GAME.starting_params.deck_size_letter or 1
            local usedLetter = {}
            for loops = 1, deckloop do
                for i, letter in pairs(letters) do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local front = pseudorandom_element(G.P_CARDS, pseudoseed('aikoyori:akyrs_letter_randomer'))
                    local car = Card(G.deck.T.x, G.deck.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS['c_base'],
                        { playing_card = G.playing_card })
                    car.is_null = true

                    -- misprintize
                    if G.GAME.modifiers and G.GAME.modifiers.cry_misprint_min and G.GAME.modifiers.cry_misprint_max then
                        for k, v in pairs(G.playing_cards) do
                            Cryptid.misprintize(car)
                        end
                    end
                    if not G.GAME.starting_params.akyrs_letters_no_uppercase then
                        if not usedLetter[letter:lower()] then letter = letter:upper() usedLetter[letter:lower()]=true else letter = letter:lower() end
                    end
                    car:set_letters(letter)
                    G.deck:emplace(car)

                    table.insert(G.playing_cards, car)
                    -- for cryptid
                    if G.GAME.modifiers and G.GAME.modifiers.cry_ccd then
                        for k, v in pairs(G.playing_cards) do
                            v:set_ability(Cryptid.random_consumable('cry_ccd', { "no_doe", "no_grc" }, nil, nil, true),
                                true, nil)
                        end
                    end
                end
            end
            G.GAME.starting_deck_size = #G.playing_cards


            G.deck:shuffle('akyrsletterdeck')
            return true
        end
    }))
end

---@params config? table config
AKYRS.get_bomb_prompt = function(config)
    config = config or {}
    local seed = config.seed or "bullshit"
    local max_freq = math.min(config.max_freq or 1e10,1e10) -- max is er with this number
    local min_freq = math.max(config.min_freq or 1000,1) 
    local max_length = math.min(config.max_length or 5, 5)
    local min_length = math.max(config.min_length or 2, 2)
    local matching = table.akyrs_filter(AKYRS.pickable_bomb_prompts, 
        function(value) 
            local f = AKYRS.bomb_prompts[value] 
            return f >= min_freq and f <= max_freq and #value >= min_length and #value <= max_length
        end)
    local freq, word
    word = pseudorandom_element(matching, seed, {})
    freq = AKYRS.bomb_prompts[word]
    return word, freq
end


  G.FUNCS.akyrs_force_draw_from_discard_to_hand = function(e)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            local discard_count = #G.discard.cards
            for i=1, discard_count do --draw cards from deck
                draw_card(G.discard, G.hand, i*100/discard_count,'up', nil ,nil, 0.005, i%2==0, nil, math.max((21-i)/20,0.7))
            end
            return true
        end
      }))
  end