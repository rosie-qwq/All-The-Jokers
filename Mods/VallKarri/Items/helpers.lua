function credit(artist)
    return ('{C:dark_edition,s:0.6,E:2}Art by : ' .. artist .. '{}')
end

function shadercredit(shader_artist)
    return ('{C:dark_edition,s:0.6,E:2}Shader by : ' .. shader_artist .. '{}')
end

function catby(cat_owner)
    return ('{C:dark_edition,s:0.6,E:2}Cat by : ' .. cat_owner .. '{}')
end

function concept(creator)
    -- return ('{C:dark_edition,s:0.6,E:2}Idea by : ' .. creator .. '{}')
    return ""
end

short_sprites = {
    placeholder = { x = 0, y = 0 },

    halo = { x = 2, y = 2 }
}

function days_since(year, month, day)
    local now = os.date("*t")
    local then_time = os.time({ year = year, month = month, day = day, hour = 0 })
    local diff = os.difftime(os.time(now), then_time)
    return math.floor(diff / (60 * 60 * 24))
end

local old_indiv_effect = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local result_main = old_indiv_effect(effect, scored_card, key, amount, from_edition)

    if (key == 'taubp_extras') and amount and (#amount > 0) then
        local result = nil
        for i = 1, #amount do
            local part = SMODS.calculate_effect(amount[i], scored_card)
            if part == true then
                result = true
            end
        end
        return result
    end

    return result_main
end

table.insert(SMODS.calculation_keys, 'taubp_extras')
function quote(character)
    -- assume character is in quotes because i'm not a fucking idiot
    local quotes = {
        lily = "thank you. that feels much better.",
        lily2 = "i'm flattered you think i'm powerful",
        illena = "i'm here to help, nothing better to do.",
        quilla = "My name is pronounced \"Key-uh\"",
        quilla2 = "seriously, stop getting it wrong.",
        niko = "sorry im not wearing the twink bowtie :c",
        orivander = "Behold, the absolute force of gravity",
        raxd = "NUCLEAR BOMB!??!?!?",
        femtanyl = "we r online. we r online.",
        lilac = "A medium iced cappuccino, p-please.",
        ovilidoth = "",
        dormant = "I'm missing something.",
        dormant2 = "Help me find it and I'll make it worth your time.",
        scraptake = "good kitty",
        hornet = "silksong OUT NOW!!!",
        valklua = "Thank you for playing <3",
        phicer = "Who would've known I'd be cursed to see these cards again?"
    }

    return ('{C:enhanced,s:0.7,E:1}' .. quotes[character] .. '{}')
end

function chardesc(text)
    return ('{C:inactive,s:0.7,E:1}' .. text .. '{}')
end

function times_used(key)
    for name, card in pairs(G.GAME.consumeable_usage) do
        if name == key then return card.count end
    end
    return 0
end

-- simplified code from jenlib

function basic_text_announce(txt, duration, size, col, snd, sndpitch, sndvol)
    G.E_MANAGER:add_event(Event({
        func = (function()
            if snd then play_sound(snd, sndpitch, sndvol) end
            attention_text({
                scale = size or 1.4, text = txt, hold = duration or 2, colour = col or G.C.WHITE, align = 'cm', offset = { x = 0, y = -2.7 }, major =
            G.play
            })
            return true
        end)
    }))
end

function vallkarri.quick_hand_text(name, chip, mul, lv, notif, snd, vol, pit, de)
    update_hand_text(
    { sound = type(snd) == 'string' and snd or type(snd) == 'nil' and 'button', volume = vol or 0.7, pitch = pit or 0.8, delay =
    de or 0.3 }, { handname = name or '????', chips = chip or '?', mult = mul or '?', level = lv or '?', StatusText =
    notif })
end

function vallkarri.simple_hand_text(hand, notify)
    if hand == 'all' or hand == 'allhands' or hand == 'all_hands' then
        vallkarri.quick_hand_text(localize('k_all_hands'), '...', '...', '', notify)
    elseif G.GAME.hands[hand] then
        vallkarri.quick_hand_text(localize(hand, 'poker_hands'), G.GAME.hands[hand].chips, G.GAME.hands[hand].mult,
            G.GAME.hands[hand].level, notify)
    end
end

function ratiocalc(a, b, c, d)
    local larger = math.max(a, b)
    local smaller = math.min(a, b)

    return ((smaller / larger) ^ c) * d
end

function vallkarri.get_most_played_hand()
    local name = nil
    local timesplayed = -1

    for i, hand in pairs(G.GAME.hands) do
        if hand.played > timesplayed then
            name = i
            timesplayed = hand.played
        end
    end

    return name
end

function self_annihilate(card)
    -- this makes sense

    G.GAME.cry_banished_keys[card.config.center.key] = true
    card:quick_dissolve()
end

function random_suit(seed)
    local n = { "Spades", "Hearts", "Clubs", "Diamonds" }
    return n[pseudorandom(seed or "valk_random_suit", 1, #n)]
end

function random_rank(seed)
    local n = { "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace" }
    return n[pseudorandom(seed or "valk_random_rank", 1, #n)]
end

function random_enhancement(seed)
    local choices = {}
    for i, e in ipairs(G.P_CENTER_POOLS.Enhanced) do
        choices[#choices + 1] = e.key
    end
    return choices[pseudorandom(seed or "valk_random_enhance", 1, #choices)]
end

function random_edition(seed)
    local choices = {}
    for i, e in ipairs(G.P_CENTER_POOLS.Edition) do
        if e.key ~= "e_negative" then
            choices[#choices + 1] = e.key
        end
    end
    return choices[pseudorandom(seed or "valk_random_edition", 1, #choices)]
end

function math.map(v, imi, ima, omi, oma)
    return (v - imi) * (oma - omi) / (ima - imi) + omi
end

function mspl(amt)
    for i, hand in pairs(G.GAME.hands) do
        G.GAME.hands[i].l_chips = G.GAME.hands[i].l_chips * amt
        G.GAME.hands[i].l_mult = G.GAME.hands[i].l_mult * amt
    end
end

function table:vcontains(table, value)
    for i, j in ipairs(table) do
        if (j == value) then return true end
    end
    return false
end

function table:superset(t_a, t_b)
    local valid = true

    for i, j in ipairs(t_b) do
        valid = valid and table:vcontains(t_a, j)
    end
    return valid
end

function destroy_first_instance(key)
    local found = SMODS.find_card(key)
    if #found > 0 then
        (select(2, next(found))):quick_dissolve()
    end
end

function joker_owned(key)
    if (G.jokers and G.jokers.cards) then
        for i, card in ipairs(G.jokers.cards) do
            if (card.config.center.key == key) then return true end
        end
    end

    return false
end

function immutable_chance_roll(source, percent_chance)
    return pseudorandom(source) * 100 <= percent_chance
end

function quick_card_speak(card, text, wait)
    card_eval_status_text(card, 'extra', nil, nil, nil, { message = text, delay = wait })
end

function pause_event(time)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        timer = 'REAL',
        delay = time or 1,
        func = function()
            return true
        end
    }))
end

function get_first_instance(key)
    local found = SMODS.find_card(key)
    if #found > 0 then
        return select(2, next(found))
    end
    return nil
end

function Card:quick_dissolve()
    self.ability.eternal = nil
    self.true_dissolve = true
    self:start_dissolve(nil, nil, nil, nil)
end

function simple_create(type, area, key)
    local card = create_card(type, area, nil, nil, nil, nil, key, "simple_create")
    card:add_to_deck()
    area:emplace(card)
end

function debug_print_antes()
    local ante = 1
    local i = 1
    local i2 = 1
    while ante < 1e300 do
        local blind_amount = tostring(get_blind_amount(ante) or "nil")
        print("Ante " .. ante .. ": " .. blind_amount)

        if (ante > 15) then
            ante = ante * 1e10
        else
            ante = ante + i
        end
    end
end

function corrupt_text(text, amount, available_chars)
    local chars = (available_chars or "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[];:',.<>/?|")
    -- amount is a 0-1 being a chance to replace each character with a rnd one

    for i = 1, #text do
        if math.random() < amount then
            local rand_index = math.random(1, #chars)
            local random_char = chars:sub(rand_index, rand_index)
            text = text:sub(1, i - 1) .. random_char .. text:sub(i + 1)
        end
    end
    return text
end

function jokercount()
    if (G.jokers) then
        return #G.jokers.cards
    else
        return 0
    end
end

-- i take no credit for these functions, theyre just slightly modified
-- versions of jenlib functions, as i don't like the text color which jenlib uses
function expochips(txt)
    return "{X:dark_edition,C:white}^" .. txt .. "{}"
end

function expomult(txt)
    return "{X:dark_edition,C:white}^" .. txt .. "{}"
end

-- chips and mult are identical since it uses x:dark
function tetrvalue(txt)
    return "{X:dark_edition,C:white}^^" .. txt .. "{}"
end

function reptlog(base, lim, num)
    for i = 1, lim do
        num = math.log(num, base)
    end

    return num
end

function get_first(area)
    return select(2, next(area))
end

function run_debug()
    assert(SMODS.load_file("debug.lua", "vallkarri"))()
end

function valk_additions()
    local total = 0
    for _, entry in pairs(G.P_CENTERS) do
        if string.find(entry.key, "valk") then
            total = total + 1
        end
    end

    return total
end

function level_all_hands(source, amount, mul)
    if amount == nil then
        amount = 1
    end

    if mul == nil then
        mul = 0
    end

    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
        { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound('tarot1')
            if source then source:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true
        end
    }))

    update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if source then source:juice_up(0.8, 0.5) end
            return true
        end
    }))
    update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if source then source:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true
        end
    }))
    local text = amount > 0 and "+" .. amount or amount
    if mul ~= 0 then
        text = "x" .. (mul + 1)
    end

    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = text })

    delay(1.3)
    for k, v in pairs(G.GAME.hands) do
        level_up_hand(source, k, true, amount + (v.level * mul))
    end
    update_hand_text({ delay = 0 }, { mult = 0, chips = 0, handname = '', level = '' })
end

function disable_mult_ui()
    G.GAME.mult_disabled = true
    if G.HUD:get_UIE_by_ID("chipmult_op") then G.HUD:get_UIE_by_ID("chipmult_op").UIT = 0 end
    G.HUD:get_UIE_by_ID("hand_mult_area").UIT = 0
    G.HUD:get_UIE_by_ID("hand_mult").UIT = 0
    G.HUD:get_UIE_by_ID("flame_mult").UIT = 0
    G.HUD:get_UIE_by_ID("hand_chip_area").config.minw = 4
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minw = 0
    G.HUD:get_UIE_by_ID("hand_mult_area").config.minh = 0
    if G.HUD:get_UIE_by_ID("chipmult_op") then G.HUD:get_UIE_by_ID("chipmult_op").scale = 0 end

    G.HUD:recalculate()
end

function qdvi(val, growth, arrows)
    for i, card in ipairs(G.jokers.cards) do
        Cryptid.manipulate(card, { value = val } )
    end
end

function find_index(card, list)
    if not list then --extremely niche case
        return false
    end
    for i, c in ipairs(list) do
        if c == card then
            return i
        end
    end
    return false
end

function draw_to_hand(cardlist)
    for i, card in ipairs(cardlist) do
        draw_card(card.area, G.hand, nil, nil, nil, card)
    end
end

function enhanced_in_deck(enhancement)
    if not G.playing_cards then
        return 0
    end
    local count = 0
    for i, card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(card, enhancement) then
            count = count + 1
        end
    end

    return count
end

function get_handtype(handtype)
    local a, b, c, d, e = G.FUNCS.get_poker_hand_info(G.deck.cards)

    local selected_hand = handtype

    local intentional_length = 0

    if not (G.GAME.hands[selected_hand]) then
        return false
    end

    for _, ca in ipairs(G.GAME.hands[selected_hand].example) do
        if ca[2] then
            intentional_length = intentional_length + 1
        end
    end

    if c[selected_hand] and #c[selected_hand] > 0 then
        local valid_cards = {}
        for i, card in ipairs(c[selected_hand][1]) do
            if i > intentional_length then
                break
            end
            table.insert(valid_cards, card)
        end
        return valid_cards
    else
        return false
    end
end

function Card:deselect()
    self.area:remove_from_highlighted(self)
end

function do_while_flipped(cards, func) --mostly borrowed from entropy, thank you ruby <3
    if not Talisman or (Talisman and not Talisman.config_file.disable_anims) then
        for i, _ in ipairs(cards) do
            local card = cards[i]
            if card then
                G.E_MANAGER:add_event(
                    Event(
                        {
                            trigger = "after",
                            delay = 0.1,
                            func = function()
                                if card.flip then
                                    card:flip()
                                end
                                return true
                            end
                        }
                    )
                )
            end
        end
    end
    for i, _ in ipairs(cards) do
        local card = cards[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            func(card, cards, i)
                            return true
                        end
                    }
                )
            )
        end
    end
    if not Talisman or (Talisman and not Talisman.config_file.disable_anims) then
        for i, _ in ipairs(cards) do
            local card = cards[i]
            if card then
                G.E_MANAGER:add_event(
                    Event(
                        {
                            trigger = "after",
                            delay = 0.1,
                            func = function()
                                if card.flip then
                                    card:flip()
                                end
                                return true
                            end
                        }
                    )
                )
            end
        end
    end
end

function fix_decimal_hand_levels()
    if not (G and G.GAME and G.GAME.hands) then
        return
    end
    for name, hand in pairs(G.GAME.hands) do
        local lvl = G.GAME.hands[name].level
        if math.floor(lvl) ~= lvl then
            G.GAME.hands[name].level = math.floor(lvl)
        end
    end
end

function area_by_key(key)
    local t = key:sub(1, 1)

    if t == "j" then
        return G.jokers
    elseif t == "c" then
        return G.consumeables
    elseif t == "m" then
        return G.hand
    end
    return nil
end

function create_letters(str)
    str = str:gsub(" ", "")
    for i = 1, #str do
        local char = str:sub(i, i)

        local card = create_card("Default", G.hand, nil, nil, nil, nil, nil, nil)
        card:set_letters(char)
        card:add_to_deck()
        G.hand:emplace(card)
        card:set_ability("c_base")
    end
end

function add_random_tag(seed)
    local tag_pool = get_current_pool('Tag')
    local selected_tag = pseudorandom_element(tag_pool, pseudoseed(seed))
    local it = 1
    while selected_tag == 'UNAVAILABLE' do
        it = it + 1
        selected_tag = pseudorandom_element(tag_pool, pseudoseed(seed .. it))
    end
    add_tag(Tag(selected_tag))
end

function Card:is_kitty()
    return Cryptid.safe_get(self.config.center, "pools", "Kitties") or self.count_as_kitty
end

function kitty_count(base)
    local c = base or 0
    for i,joker in ipairs((G.jokers and G.jokers.cards) or {}) do
        if joker:is_kitty() then
            c = c + 1
        end
    end
    return c
end

function vallkarri.count_kitty_tags()
    local c = 0
    for i,tag in ipairs(G.GAME.tags or {}) do
        if tag.key == "tag_valk_kitty" then
            c = c + 1
        end
    end 
    return c
end

function lerpcolour(c1, c2, percent)

    local new = { }

    if not lerp then
        return {(c1[1]+c2[1])/2, (c1[2]+c2[2])/2, (c1[3]+c2[3])/2, 1 }
    end

    new[1] = lerp(c1[1], c2[1], math.log10(percent/10)) --strange, i know.
    new[2] = lerp(c1[2], c2[2], math.log10(percent/10))
    new[3] = lerp(c1[3], c2[3], math.log10(percent/10))
    return {new[1], new[2], new[3], 1}
end

function CardArea:check_individual(func)

    for i,card in ipairs(self.cards) do
        if func(card) then
            return true
        end
    end
    return false

end

function vallkarri.create_all_jokers_from(mod)

    for i,joker in ipairs(G.P_CENTER_POOLS.Joker) do
        if joker.original_mod and joker.original_mod.id == mod then
            local jkr = SMODS.create_card({key = joker.key})
            jkr:add_to_deck()
            G.jokers:emplace(jkr)
        end
    end

end

function vallkarri.reset_hand_text()
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
end

function vallkarri.search(search_table, find)
    for name,value in pairs(search_table) do
        if string.find(name, find) then
            print(name .. ": " .. tostring(value))
        end
    end
end

function vallkarri.list_banned_keys()
    for key,is_banned in pairs(G.GAME.banned_keys) do
        if is_banned then
            print(key .. " is banned. Set: " .. G.P_CENTERS[key].set)
        end
    end
end

function vallkarri.get_ordered_highlighted(cardarea)
    local ordered = {}

    for _,card in pairs(cardarea.cards) do
        for _,highlighted_card in pairs(cardarea.highlighted) do
            if highlighted_card == card then
                ordered[#ordered+1] = card
            end
        end
    end

    return ordered
end

function vallkarri.get_adjacent_cards(card)
    local index = get_index(card.area.cards, card)

    return {card.area.cards[index-1], card.area.cards[index+1]}
end

function vallkarri.for_each(tab, func)
    local cards = tab.cards and tab.cards or tab

    for _,card in pairs(cards) do
        func(card)
    end
end

function vallkarri.hypercap(n, cap)
    local initial_cap = cap
    local initial_n = n
    local run = to_big(n) > to_big(cap)
    local i = 1
    local limit = 100
    while run and i < limit do
        local exponent = 0.95 ^ i
        local oldcap = cap
        if Talisman and i > (limit/10) then
            local arrows = math.floor(i^0.5)
            n = to_big(n):arrow(arrows, exponent)
            --talisman broken :wilted_rose: so it also does htis too
            n = n ^ (0.5^i)
            
        else
            n = n ^ exponent
        end
        cap = cap + (cap / 20)
        i = i + 1

        -- print(oldcap .. "->" .. cap)
        -- print(n .. "^" .. exponent .. ">" .. cap)

        run = to_big(n) > to_big(cap)

    end

    return math.max(n, math.min(initial_n, initial_cap))
end

function vallkarri.index(card)
    local area = card.area

    if not area then
        return false
    end
    for i,c in ipairs(area.cards) do 
        if c == card then
            return i
        end
    end
    return false
end

function vallkarri.adjacent_aesthetijoker(card)
    local left = card.area.cards[vallkarri.index(card)-1]
    local right = card.area.cards[vallkarri.index(card)+1]
    local ret_value = nil
    if left and Cryptid.safe_get(left.config.center, "pools", "aesthetijoker") then
        ret_value = left
    end

    if right and Cryptid.safe_get(right.config.center, "pools", "aesthetijoker") then
        ret_value = right
    end

    return ret_value

end

function Card:apply_aesthetijoker_edition()
    local aesthetijoker = vallkarri.adjacent_aesthetijoker(self)
    if aesthetijoker then
        local ed = aesthetijoker.ability.extra.edition
        local reset = ed == (self.edition and self.edition.key)
        self:set_edition(ed, reset, reset)
    else
        self:set_edition(nil, self.edition == nil, self.edition == nil)
    end
end

SMODS.DrawStep {
    key = "infinite_layers",
    func = function(card, layer)
        if not card.inf_layers then
            card.inf_layers = {}
        end

        local allowed = layer == "both" or layer == "card"
        if not (#card.inf_layers > 0 and allowed) then
            return
        end

        local scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) + 0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3

        local rotate_mod = 0.05 * math.sin(1.219 * G.TIMERS.REAL) + 0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

        for _,child in pairs(card.inf_layers) do
            if child.override_scale then
                child.T.h = child.T.h * child.override_scale
                child.T.w = child.T.w * child.override_scale
                child.override_scale = nil
            end
            if child.states.role then
                child.states.role.draw_major = card
            end
            child.states.hover.can = false
            child.states.click.can = false
            child:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            child:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end,
    order = 99299, --lily's 2nd favourite number!
}

function Card:valk_add_layer(atlas, position, scale)
    local next_index = #self.inf_layers+1
    self.inf_layers[next_index] = Sprite(self.T.x, self.T.y, self.T.w*scale, self.T.h*scale, G.ASSET_ATLAS[atlas], position)
    self.inf_layers[next_index].override_scale = scale
end