﻿--- A collection of re-usable functions used across Mistigris.
local mistiutils = {}

--- Detailed Debug messages callable from anywhere that uses mistiutils. (Based on Pokermon)
--- @param message string|table Text of the message you would like to print.
--- @param logger string? Name of the logger this message will be attributed to.
--- @param printType "trace"|"debug"|"info"|"warn"|"error"|"fatal"|nil What type of function should be used? Defaults to Info.
function mistiutils.print_line(message, logger, printType)
    local functions = {
        ["trace"] = sendTraceMessage,
        ["debug"] = sendDebugMessage,
        ["info"] = sendInfoMessage,
        ["warn"] = sendWarnMessage,
        ["error"] = sendErrorMessage,
        ["fatal"] = sendFatalMessage,
    }
    local printFunc = functions[printType] or sendInfoMessage
    local log = logger or "MistigrisLogger"

    if verbose then
        printFunc("The type of the message variable is [" .. type(message) .. "]", log)
    end
    if type(message) == "table" then
        if depth then
            printFunc(inspectDepth(message), log)
        else
            printFunc(inspect(message), log)
        end
    else
        printFunc(message, log)
    end
end

--- Grabs a random Table element that is not numerically indexed. (Based on JenLib)
--- @param table table The table of elements to select from.
--- @return any: The retrieved element.
--- Note: It's recommended to do table[math.random(#table)] instead for numerically-indexed tables, as it's more efficient
function mistiutils.random_element(table)
    local index = {}
    for k, v in pairs(table) do
        index[#index + 1] = k
    end
    return table[index[math.random(#index)]]
end

--- Checks how many times a specific rank occurs in played hand.
--- @param hand table The hand to select from.
--- @param rank string The rank to search for.
--- @return integer: How many times does this rank occur during the played hand?
function mistiutils.rank_count(hand, rank)
    local rank_counter = 0
    for i = 1, #hand do
        if hand[i].base.value == rank and not SMODS.has_no_rank(hand[i]) then
            rank_counter = rank_counter + 1
        end
    end
    return rank_counter
end

--- Checks how many times a specific set of ranks occurs in played hand.
--- @param hand table The hand to select from.
--- @param ranks table The ranks to search for.
--- @return integer: How many times does this collection of ranks occur during the played hand?
function mistiutils.ranks_count(hand, ranks)
    local rank_counter = 0
    for hand_index = 1, #hand do
        for rank_index = 1, #ranks do
            if hand[hand_index].base.value == ranks[rank_index] and not SMODS.has_no_rank(hand[hand_index]) then
                rank_counter = rank_counter + 1
            end
        end
    end
    return rank_counter
end

--- Checks if a card's rank is included in a specified table of ranks.
--- @param card Card The card that is being tested against this table of ranks.
--- @param ranks table The ranks to search for.
--- @return boolean: Does this card fit in the table of ranks?
function mistiutils.matches_rank(card, ranks)
    for i = 1, #ranks do
        if card.base.value == ranks[i] and not SMODS.has_no_rank(card) then
            return true
        end
    end
    return false
end

--- Chance rolls, used for things like Wheel of Fortune and Gros Michel. (Based on JenLib)
--- @param name string The named seed to use for this roll.
--- @param probability integer The odds of this event occurring, in odds.
--- @param absolute boolean? If set to true, the chance of this event occurring cannot be affected by G.GAME.probabilities.normal.
--- @return boolean: Make this event happen?
function mistiutils.chance(name, probability, absolute)
    return pseudorandom(name) < (absolute and 1 or G.GAME.probabilities.normal) / probability
end

--- Gets the most played hand of the run. (Based on JenLib)
--- @return string: The name of the hand.
function mistiutils.fav_hand()
    if not G.GAME or not G.GAME.current_round then
        return "High Card"
    end
    local chosen_hand = "High Card"
    local _handname, _played, _order = "High Card", -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end
    chosen_hand = _handname
    return chosen_hand
end

--- Gets the second most played hand of the run. (Based on JenLib)
--- @return string: The name of the hand.
function mistiutils.second_fav_hand()
    if not G.GAME or not G.GAME.current_round then
        return "High Card"
    end
    local chosen_hand = "High Card"
    local firstmost = fav_hand()
    local _handname, _played, _order = "High Card", -1, 100
    for k, v in pairs(G.GAME.hands) do
        if k ~= firstmost and v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            _handname = k
        end
    end
    chosen_hand = _handname
    return chosen_hand
end

--- Used for The Birch. Checks if the current hand counts as the lesat played hand of the run.
--- @return boolean: Isn't least played?
function mistiutils.is_not_least_fav_hand(hand)
    local played_count = G.GAME.hands[hand].played
    if G.STATE == G.STATES.HAND_PLAYED then played_count = played_count - 1 end
    for k, v in pairs(G.GAME.hands) do
        if v.played < played_count then return true end
    end
    return false
end

--- Gets the ranking of a hand based on how often it has been used during the current run. (Based on JenLib)
--- @param hand string The selected hand.
--- @return integer: The hand's ranking.
function mistiutils.hand_pos(hand)
    local pos = -1
    for i = 1, #G.handlist do
        if G.handlist[i] == hand then
            pos = i
            break
        end
    end
    return pos
end

--- Gets the "adjacent" hands of a hand (a.k.a. the hands above and below the hand you specify according to the poker hand list) (Based on JenLib)
--- @param hand string The selected hand.
--- @return table: The hands directly above and below the selected one in terms of usage.
function mistiutils.adjacent_hands(hand)
    local hands = {}
    if not G.GAME or not G.GAME.hands then
        return hands
    end
    local pos = -1
    for k, v in ipairs(G.handlist) do
        if v == hand then
            pos = k
        end
    end
    if pos == -1 then
        return hands
    end
    hands.forehand = G.handlist[pos + 1]
    hands.backhand = G.handlist[pos - 1]
    return hands
end

--- Gets the hand with the lowest level. Less-used hands are prioritized. (Based on JenLib)
--- @return string: The name of the hand.
function mistiutils.lowest_lvl_hand()
    local chosen_hand = "High Card"
    local lowest_level = math.huge
    for _, v in ipairs(G.handlist) do
        if G.GAME.hands[v].level <= lowest_level then
            chosen_hand = v
            lowest_level = G.GAME.hands[v].level
        end
    end
    return chosen_hand
end

--- Gets the hand with the highest level. More used hands are prioritized. (Based on JenLib)
--- @return string: The name of the hand.
function mistiutils.highest_lvl_hand()
    local chosen_hand = "High Card"
    local highest_level = -math.huge
    for _, v in ipairs(G.handlist) do
        if G.GAME.hands[v].level >= highest_level then
            chosen_hand = v
            highest_level = G.GAME.hands[v].level
        end
    end
    return chosen_hand
end

--- Selects a random hand. (Based on JenLib)
--- @param ignore string|table|nil The hands that are to be ignored in the selection process.
--- @param seed string? The seed to use when selecting hands.
--- @param allowhidden boolean? Whether or not this search should include hands not yet discovered by the player.
--- @return table|nil: A randomly selected hand, considering the above criteria.
function mistiutils.random_hand(ignore, seed, allowhidden)
    local chosen_hand
    ignore = ignore or {}
    seed = seed or "randomhand"
    if type(ignore) ~= "table" then
        ignore = { ignore }
    end
    while true do
        chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
        if G.GAME.hands[chosen_hand].visible or allowhidden then
            local safe = true
            for _, v in pairs(ignore) do
                if v == chosen_hand then
                    safe = false
                end
            end
            if safe then
                break
            end
        end
    end
    return chosen_hand
end

--- Selects what cards can be killed by items like Madness and Ceremonial Dagger.
--- @param self Card The card that is calling this function.
--- @return table: The cards that can be killed.
function mistiutils.killable(self, area)
    local t = {}
    for i = 1, #area.cards do
        local j = area.cards[i]
        if j ~= self and not j.ability["eternal"] and not j.getting_sliced then
            table.insert(t, j)
        end
    end
    return t
end

--- Makes a Joker self-destruct. Mostly used for Food-based Jokers, like Gros Michel and Turtle Bean.
--- @param card Card The card that is being destroyed.
--- @param after function? The function that should be run after this Joker is destroyed.
function mistiutils.destroy_joker(card, after)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound("tarot1")
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    if after and type(after) == "function" then
                        after()
                    end
                    return true
                end,
                delay = 0.3,
                blockable = false,
                trigger = "after"
            }))
            return true
        end
    }))
end

--- Makes one Joker kill another Joker in the same style that Ceremonial Dagger does.
--- @param card Card The card that is calling this function.
--- @param sliced_card Card The card that is being destroyed.
--- @param during function? Function to call while the Joker is slicing.
function mistiutils.slice_joker(card, sliced_card, during)
    sliced_card.getting_sliced = true
    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.joker_buffer = 0
            if during and type(during) == "function" then
                during()
            end
            card:juice_up(0.8, 0.8)
            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            play_sound('slice1', 0.96 + math.random() * 0.08)
            return true
        end
    }))
end

--- Replaces a Joker in the shop at the specified index.
--- @param key string The Joker's key.
--- @param index integer The one-based index of the shop item that should be replaced.
function mistiutils.replace_joker_in_shop(key, index)
    if G.shop_jokers then
        local kill = G.shop_jokers.cards[index]
        G.shop_jokers:remove_card(kill)
        kill:remove()
        local sold_card = SMODS.add_card({ set = "Joker", area = G.shop_jokers, key = key })
        create_shop_card_ui(sold_card, "Joker", G.shop_jokers)
        sold_card:start_materialize()
        sold_card:set_cost()
    end
end

--- Linearly interpolates between two variables
--- @param a integer The starting variable.
--- @param b integer The ending variable.
--- @param t integer From 0 to 1, how far along the variable should be interpolated.
function mistiutils.lerp(a, b, t)
    return t >= 1 and b or a + (b - a) * t
end

--- Counts how many hands have never been played in the current run.
--- @return integer: The number of hands yet to be played.
function mistiutils.get_unplayed_hand_count_this_run()
    local hand_count = 0
    for name, handinfo in pairs(G.GAME.hands) do
        if handinfo.visible and handinfo.played <= 0 then
            hand_count = hand_count + 1
        end
    end
    return hand_count
end

--- Counts how many hands have been played in the current run.
--- @return integer: The number of hands played.
function mistiutils.get_played_hand_count_this_run()
    local hand_count = 0
    for name, handinfo in pairs(G.GAME.hands) do
        if handinfo.played > 0 then
            hand_count = hand_count + 1
        end
    end
    return hand_count
end

--- Gets the suits included within a specific set of cards.
--- @param cards table The set of cards to test against.
--- @return table: The suits that are included in this card set.
function mistiutils.get_suits(cards)
    local suits = {}
    for _, v in ipairs(cards) do
        if not suits[v.base.suit] then suits[#suits + 1] = v.base.suit end
    end
    return suits
end

--- Checks a card against a table of suits
--- @param card Card The card to be tested against.
--- @param suits table The table of suits we're looking for.
--- @return boolean: Does this card match any of the listed suits?
function mistiutils.is_any_of_these_suits(card, suits)
    for _, v in pairs(suits) do
        if card:is_suit(v) then return true end
    end
    return false
end

--- Gets a random card in the deck that is of a specified suit.
--- @param suit string The suit to look for
--- @return table: The card that's been selected (as a card)
--- @return table: The card that's been selected (as a center)
function mistiutils.get_random_card_in_deck_of_suit(suit)
    while true do
        local card = pseudorandom_element(G.playing_cards, pseudoseed("get_random_card_in_deck_of_suit"))
        if card:is_suit(suit) then
            local new_code = SMODS.Suits[suit].card_key
            local new_val = SMODS.Ranks[card.base.value].card_key
            local new_card = G.P_CARDS[new_code .. '_' .. new_val]

            return card, new_card
        end
    end
end

--- Gets a random rank that is present in the deck.
--- @return string: The rank that has been selected
function mistiutils.get_random_rank_thats_in_deck()
    while true do
        if G.playing_cards then
            local card = pseudorandom_element(G.playing_cards, pseudoseed("get_random_rank_thats_in_deck")) or nil
            if card then
                if not SMODS.has_no_rank(card) then
                    return card.base.value
                end
            else
                return "Ace"
            end
        else
            return "Ace"
        end
    end
end

--- Checks a certain cardarea for any cards that have a chosen enhancement.
function mistiutils.tally_enhancement(enhancement, area)
    local tally = 0
    for k, v in pairs(area) do
        if SMODS.has_enhancement(v, enhancement) then tally = tally + 1 end
    end
    return tally
end

--- Creates a new card that retains the basic center information of another card. Use SMODS.add_card() to properly utilize this function.
--- @param card Card The card that sources the information
--- @param key string The string of the new card.
function mistiutils.new_card_with_other_cards_values(card, key)
    local stickers = {}
    for k, v in pairs(SMODS.Stickers) do
        if card.ability[k] then table.insert(stickers, k) end
    end

    local c = {
        set = "Joker",
        key = key,
        edition = card.edition and card.edition.key or nil,
        stickers =
            stickers
    }

    return c
end

return mistiutils
