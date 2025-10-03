local aikoyori_mod_config = SMODS.current_mod.config

aikoyori_mod_config.wildcard_behaviour = aikoyori_mod_config.wildcard_behaviour or 1

function AKYRS.table_contains(tbl, x)
    local found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
        end
    end
    return found
end


AKYRS.aiko_pickRandomInTable = function(t)
    return t[math.random(1, #t)]
end

aiko_alphabets = {}
aiko_alphabets_no_wilds = {}
aiko_alphabets_to_num = {}
aiko_alphabets_to_num_no_wild = {}
for i = 97, 122 do
    table.insert(aiko_alphabets, string.char(i))
    table.insert(aiko_alphabets_no_wilds, string.char(i))
    aiko_alphabets_to_num[string.char(i)] = i - 96
    aiko_alphabets_to_num_no_wild[string.char(i)] = i - 96
end
table.insert(aiko_alphabets,"#")
aiko_alphabets_to_num["#"] = 27

function AKYRS.alphabet_delta(alpha, delta)
    local numero = string.byte(alpha) + delta
    while numero < string.byte(' ') do
        numero = numero + 95
    end
    if numero > string.byte('~') then
        numero = (numero - string.byte(' ')) % 95 + string.byte(' ')
    end
    return string.char(numero)
end

card_suits = {}
card_suits_with_meta = {}
card_ranks = {}
card_rank_numbers = {}
card_ranks_with_meta = {}

for k, v in pairs(SMODS.Ranks) do
    table.insert(card_ranks_with_meta,v)
end

table.sort(card_ranks_with_meta, function(s1,s2)
    --print("COMPARING "..s1.key.." and "..s2.key)
    return s1.sort_nominal < s2.sort_nominal
end)

for i, v in pairs(card_ranks_with_meta) do
    table.insert(card_ranks,v.key)
    card_rank_numbers[v.key] = i
    --print(v.key,i)
end


for k, v in pairs(SMODS.Suits) do
    table.insert(card_suits, k)
    table.insert(card_suits_with_meta, v)
end

function AKYRS.getNextIDs(id)
    nexts = {}
    if(card_ranks_with_meta[id]) then
            --print(table_to_string(card_ranks_with_meta[id]))
        for i, v in ipairs(card_ranks_with_meta[id].next) do
            table.insert(nexts,card_rank_numbers[v]) 
        end
    end
    --print(table_to_string(nexts))
    return nexts
end


function AKYRS.aiko_intersect_table(a,b)
    local ai = {}
    for _,v in ipairs(a) do
        ai[v] = true
    end
    local ret = {}
    for _,v in ipairs(b) do
        if ai[v] then
            ret[#ret + 1] = v
        end
    end
    return ret
end


function AKYRS.concat_table(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function AKYRS.getFirstElementOfTable(t)
    for k, v in pairs(t) do
        return v
    end
end

function AKYRS.getFirstKeyOfTable(t)
    for k, v in pairs(t) do
        return k
    end
end


AKYRS.pickableSuit = { "S", "H", "C", "D" }
AKYRS.pickableRank = { "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A" }
AKYRS.rankToNumber = { ["2"] = 2, ["3"] = 3, ["4"] = 4, ["5"] = 5, ["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9, ["T"] = 10,
   ["J"] = 11, ["Q"] = 12, ["K"] = 13, ["A"] = 14 }
function AKYRS.concat_table(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

AKYRS.allTarotExceptWheel = {}
-- symbols
AKYRS.non_letter_symbols = {
    "_", "-", "@", "!", "?", "+", "/", "\\", "*", ".", "'", '"', "&", " ", ":", ";", "=", ",", "(",")","[","]","{","}","$","%","^", "`", "~", "|", "<", ">"
}
AKYRS.non_letter_symbols_reverse = {}
for v, symbol in ipairs(AKYRS.non_letter_symbols) do
    AKYRS.non_letter_symbols_reverse[symbol] = v
end


function AKYRS.aiko_mod_startup(self)
    if not self then return end
    if not AKYRS.aikoyori_letters_stickers then
        AKYRS.aikoyori_letters_stickers = {}
    end
    AKYRS.aikoyori_letters_stickers["correct"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 0, y = 0 })
    AKYRS.aikoyori_letters_stickers["misalign"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 1, y = 0 })
    AKYRS.aikoyori_letters_stickers["incorrect"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 2, y = 0 })
    AKYRS.aikoyori_letters_stickers["correct_hc"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 3, y = 0 })
    AKYRS.aikoyori_letters_stickers["misalign_hc"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 4, y = 0 })
    AKYRS.aikoyori_letters_stickers["incorrect_hc"] = Sprite(0, 0, self.CARD_W, self.CARD_H,
        G.ASSET_ATLAS["akyrs_misc_overlay"], { x = 5, y = 0 })
end


function AKYRS.randomCard()
    local suit =AKYRS.aiko_pickRandomInTable(AKYRS.pickableSuit)
    local rank =AKYRS.aiko_pickRandomInTable(AKYRS.pickableRank)
    return suit .. "_" .. rank
end

function AKYRS.randomSameRank(cardCode)
    local suit = string.sub(cardCode, 1, 1)
    local rank = string.sub(cardCode, 3, 3)
    local newSuit =AKYRS.aiko_pickRandomInTable(AKYRS.pickableSuit)
    while newSuit == suit do
        newSuit =AKYRS.aiko_pickRandomInTable(AKYRS.pickableSuit)
    end
    return newSuit .. "_" .. rank
end

function AKYRS.randomSameSuit(cardCode)
    local suit = string.sub(cardCode, 1, 1)
    local rank = string.sub(cardCode, 3, 3)
    local newRank =AKYRS.aiko_pickRandomInTable(AKYRS.pickableRank)
    while newRank == rank do
        newRank = AKYRS.pickableRank[math.random(1, 13)]
    end
    return suit .. "_" .. newRank
end

function AKYRS.randomConsecutiveRank(cardCode, up, randomSuit)
    local suit = string.sub(cardCode, 1, 1)
    local rank = string.sub(cardCode, 3, 3)
    local newRank = rank
    newRank = AKYRS.pickableRank[math.fmod(AKYRS.rankToNumber[rank] - 1, #AKYRS.pickableRank) + 1]
    if randomSuit then
        local newSuit =AKYRS.aiko_pickRandomInTable(AKYRS.pickableSuit)
        while newSuit == suit do
            newSuit =AKYRS.aiko_pickRandomInTable(AKYRS.pickableSuit)
        end
        return newSuit .. "_" .. newRank
    else
        return suit .. "_" .. newRank
    end
end

function table_to_string(tables)
    if type(tables) == "nil" then
        return "nil"
    end
    local strRet = ""
    for k,v in pairs(tables) do
        local stra = v
        if type(stra) == "table" then
            strRet = strRet..k.." :( "..table_to_string(stra).." ), "
        else
            strRet = strRet..k.." : "..tostring(stra)..", "
        end
    end
    return strRet
end
function table_to_string_depth(tables, depth)
    if depth == 0 then
        local keys = ""
        for k, _ in pairs(tables) do
            keys= keys..k..":k , "
        end
        return "["..#tables.."]"
    end
    if type(tables) == "nil" then
        return "nil"
    end
    local strRet = ""
    for k,v in pairs(tables) do
        local stra = v
        if type(stra) == "table" then
            strRet = strRet..k.." :( "..table_to_string_depth(stra, depth - 1).." ), "
        else
            strRet = strRet..k.." : "..tostring(stra)..", "
        end
    end
    return strRet
end

function AKYRS.isBlindKeyAThing(inta)
    local comp = inta or G.GAME.blind
    return comp and comp.config and comp.config.blind and comp.config.blind.key and true or nil
end
function AKYRS.getBlindKeySafe(inta)
    local comp = inta or G.GAME.blind
    return comp and comp.config and comp.config.blind and comp.config.blind.key or ""
end

function AKYRS.checkBlindKey(blind_key)
    if AKYRS.isBlindKeyAThing() and blind_key == G.GAME.blind.config.blind.key then
        return true
    end
    return false
end

AKYRS.get_speed_mult = function(card)
    return ((card and (card.area == G.jokers or
        card.area == G.consumeables or
        card.area == G.hand or 
        card.area == G.play or
        card.area == G.shop_jokers or 
        card.area == G.shop_booster or
        card.area == G.load_shop_vouchers
    )) and G.SETTINGS.GAMESPEED) or 1
end

-- credit to nh6574 for helping with this bit
AKYRS.card_area_preview = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local original_card = config.original_card or AKYRS.current_hover_card or nil
    local speed_mul = config.speed or AKYRS.get_speed_mult(original_card)
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local func_after = config.func_after or nil
    local init_delay = config.init_delay or 1
    local func_list = config.func_list or nil
    local func_delay = config.func_delay or 0.2
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
            , width * G.CARD_W, height * G.CARD_H,
            {card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true,temporary = true}
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if(card.config.center) then
                -- this properly sets the sprite size <3
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = G.UIT.R,
        config = { align = alignment , padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {n = G.UIT.O, config = { object = cardArea }}
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes+1] = {
                uiEX
            }
        end
    end
    if func_after or func_list then 
        G.E_MANAGER:clear_queue("akyrs_desc")
    end
    if func_after then 
        G.E_MANAGER:add_event(Event{
            delay = init_delay * speed_mul,
            blockable = false,
            trigger = "after",
            func = function ()
                func_after(cardArea)
                return true
            end
        },"akyrs_desc")
    end
    
    if func_list then 
        for i, k in ipairs(func_list) do
            G.E_MANAGER:add_event(Event{
                delay = func_delay * i * speed_mul,
                blockable = false,
                trigger = "after",
                func = function ()
                    k(cardArea)
                    return true
                end
            },"akyrs_desc")
        end
    end
    return uiEX
end

AKYRS.temp_card_area = CardArea(
    -99990,-99990,0,0,
    {card_limit = 999999, type = 'title', highlight_limit = 0, collection = true}
)

AKYRS.create_random_card = function(seed)
    return Card(0,0, G.CARD_W, G.CARD_H, pseudorandom_element(G.P_CARDS,pseudoseed(seed)), G.P_CENTERS.c_base)
end


function AKYRS.change_base_skip(card, suit, rank)
    if not card then return false end
    local _suit = SMODS.Suits[suit or card.base.suit]
    local _rank = SMODS.Ranks[rank or card.base.value]
    if not _suit or not _rank then
        sendWarnMessage(('Tried to call SMODS.change_base with invalid arguments: suit="%s", rank="%s"'):format(suit, rank), 'Util')
        return false
    end
    card:set_base(G.P_CARDS[('%s_%s'):format(_suit.card_key, _rank.card_key)], true)
    return card
end

function AKYRS.embedded_ui_sprite( sprite_atlas, sprite_pos, desc_nodes, config )
    if not config then config = {} end
    local sprite_atli = G.ASSET_ATLAS[sprite_atlas]
    local height = config.h or sprite_atli.py
    local width = config.w or sprite_atli.px
    local manual_scale = config.manual_scale
    local fix_height = config.fxh
    local fix_width = config.fxw
    local scale = config.scale or 1
    local padding = config.padding or 0.07
    local rounded = config.rounded or 0.1
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local box_height = config.box_height or 0
    local aspect_ratio = sprite_atli.px / sprite_atli.py
    local longer_value = not manual_scale and math.max(sprite_atli.px, sprite_atli.py) or manual_scale
    local sprt = Sprite(
        G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
        ,width*scale/(aspect_ratio*longer_value), height*scale/(aspect_ratio*longer_value),
        sprite_atli, sprite_pos
    )
    local uiEX = 
    {
        n = G.UIT.R,
        config = { align = alignment , padding = padding, no_fill = true, r = rounded, minh = box_height or fix_height, maxh = fix_height, minw = fix_width, maxw = fix_width },
        nodes = {
            {n = G.UIT.O, config = { object = sprt }}
        }
    }
    if desc_nodes then
        desc_nodes[#desc_nodes+1] = {uiEX}
    end
    return uiEX
end

AKYRS.deep_copy = function(orig, seen)
    seen = seen or {}
    if type(orig) ~= 'table' then
        return orig
    end
    if seen[orig] then
        return seen[orig]
    end
    local copy = {}
    seen[orig] = copy
    for orig_key, orig_value in next, orig, nil do
        copy[AKYRS.deep_copy(orig_key, seen)] = AKYRS.deep_copy(orig_value, seen)
    end
    return copy
end

AKYRS.get_default_ability = function(key)
    return G.P_CENTERS[key] and G.P_CENTERS[key].config or {}
end

function AKYRS.find_stake_from_level(level)
    for i, k in pairs(G.P_STAKES) do 
        if k == level then
            return i, k
        end
        if k.key == level then
            return i, k
        end
        if k.stake_level == level then
            return i, k
        end
    end
    return nil, nil
end

AKYRS.swap_case = function (word)
    if not word then return nil end
    local swapped = ""
    for i = 1, #word do
        local c = word:sub(i, i)
        if c:match("%l") then
            swapped = swapped .. c:upper()
        elseif c:match("%u") then
            swapped = swapped .. c:lower()
        else
            swapped = swapped .. c
        end
    end
    return swapped
end

local uppercaser = {
    ["`"] = "~",
    ["1"] = "!",
    ["2"] = "@",
    ["3"] = "#",
    ["4"] = "$",
    ["5"] = "%",
    ["6"] = "^",
    ["7"] = "&",
    ["8"] = "*",
    ["9"] = "(",
    ["0"] = ")",
    ["-"] = "_",
    ["="] = "+",
    [";"] = ":",
    ["'"] = '"',
    [","] = "<",
    ["."] = ">",
    ["/"] = "?",
    ["\\"] = "|",
    ["["] = "{",
    ["]"] = "}",
}

function AKYRS.get_shifted_from_key(key)
    local k = key
    if key and uppercaser[key] then 
        k = uppercaser[key]
    elseif string.upper(key) ~= key then
        k = string.upper(key)
    end
    return k
end

function AKYRS.is_value_within_threshold(target, value, threshold_percent)
    local threshold = target * (threshold_percent / 100)
    if Talisman then
        return to_big(to_big(target) - to_big(value)):abs() <= to_big(threshold)
    end
    return math.abs(target - value) <= threshold
end

function AKYRS.adjust_rounding(num)
    return math.floor(num*10)/10
end

AKYRS.simple_event_add = function (func, delay, queue, config)
    config = config or {}
    G.E_MANAGER:add_event(Event{
        trigger = config.trigger or 'after',
        delay = delay or 0.1,
        func = func,
        blocking = config.blocking,
        blockable = config.blockable,
    }, queue, config.front)
end


AKYRS.check_type = function(d)
    local type_map = {
        {"Controller",Controller},
        {"Particles",Particles},
        {"DynaText",DynaText},
        {"Back",Back},
        {"Blind",Blind},
        {"Card",Card},
        {"Tag",Tag},
        {"CardArea",CardArea},
        {"UIElement",UIElement},
        {"UIBox",UIBox},
        {"AnimatedSprite",AnimatedSprite},
        {"Sprite",Sprite},
        {"Card_Character",Card_Character},
        {"Event",Event},
        {"EventManager",EventManager},
        {"Game",Game},
        {"Moveable",Moveable},
        {"Node",Node},
        {"Object",Object},
    }

    for i, class_ref in ipairs(type_map) do
        if d:is(class_ref[2]) then
            return class_ref[1]
        end
    end

    return type(d)
end

function AKYRS.is_in_table(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function AKYRS.find_index(table, value)
    for index, v in ipairs(table) do
        if v == value then
            return index
        end
    end
    return nil
end

function AKYRS.remove_value_from_table(tbl, value)
    local index = AKYRS.find_index(tbl, value)
    if index then
        table.remove(tbl, index)
        return true
    end
    return false
end

function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end


function AKYRS.capitalize(stringIn)
    return string.gsub(" " .. stringIn, "%W%l", string.upper):sub(2)
end


function AKYRS.remove_comma(string)
    return string.gsub(string, ",", "")
end


AKYRS.word_letter_count = function(word)
    
    local wordArray = {}
    for i = 1, #word do
        wordArray[word:sub(i, i)] = wordArray[word:sub(i, i)] and wordArray[word:sub(i, i)] + 1 or 1
    end
    return wordArray
end

function AKYRS.remove_all(t, predicate)
    for i=#t, 1, -1 do
        local v=t[i]
        table.remove(t, i)
        if v and predicate(v) and v.children then
            AKYRS.remove_all(v.children, predicate)
        end
        if v and predicate(v) then v:remove() end
        v = nil
    end
    for _, v in pairs(t) do
        if predicate(v) then
            if v.children then 
                AKYRS.remove_all(v.children, predicate)
            end
            v:remove()
            v = nil
        end
    end
end


function AKYRS.akyrs_remove(uibox,predicate)
    
    if uibox == G.OVERLAY_MENU then G.REFRESH_ALERTS = true end
    uibox.UIRoot:remove()
    for k, v in pairs(G.I[uibox.config.instance_type or 'UIBOX']) do
        if v == uibox then
            table.remove(G.I[uibox.config.instance_type or 'UIBOX'], k)
            break;
        end
    end
    AKYRS.remove_all(uibox.children, predicate)
    Moveable.remove(uibox)
end

AKYRS.word_splitter = function(word)
    
    local wordArray = {}
    for i = 1, #word do
        table.insert(wordArray, word:sub(i, i))
    end
    return wordArray
end

AKYRS.remove_objects_in_nodes = function(nodes)
    if #nodes <= 0 then return end
    for _, node in ipairs(nodes) do
        if node.config and node.config.object then 
            node.config.object:remove()
        end
        if node.nodes then
            AKYRS.remove_objects_in_nodes(node.nodes)
        end
    end
end

AKYRS.remove_dupes = function(tabled)
    if not tabled then return end
    local seen = {}
    for i = #tabled, 1, -1 do
        local card = tabled[i]
        if seen[card] then
            table.remove(tabled, i)
        else
            seen[card] = true
        end
    end
end

AKYRS.word_blind = function()
    return (G.GAME.blind and G.GAME.blind.debuff and G.GAME.blind.debuff.akyrs_is_word_blind)
end

AKYRS.pos_to_val = function(ind,targ)
    if not ind or not targ then return end
    local calc_ind = ind - (targ+1) / 2
    local v, v2 = pcall(function ()
        return Talisman and (to_big(1.1):pow(calc_ind)) or 1.1 ^ calc_ind
    end)
    return v and v2 or 1
end

function AKYRS.balala(joker, poker)
    AKYRS.simple_event_add(function()error("it's balala time!",4) return true end,0)
end


function AKYRS.score_catches_fire_or_not()
    if not G.GAME or not G.GAME.blind then return false end


    if type(G.GAME.blind.chips) == "string" then
        local stud = tonumber(AKYRS.remove_comma(G.GAME.blind.chips))
        if stud ~= stud then
            return false
        end
        G.GAME.blind.chips = Talisman and to_big(stud) or stud

    end
    if Talisman then
        G.GAME.current_round.current_hand.chips = to_big(G.GAME.current_round.current_hand.chips)
        G.GAME.current_round.current_hand.mult = to_big(G.GAME.current_round.current_hand.mult)
        G.GAME.blind.chips = to_big(G.GAME.blind.chips)
    end
    return G.GAME.current_round.current_hand.chips * G.GAME.current_round.current_hand.mult > G.GAME.blind.chips
end


function AKYRS.C2S(card)
    return (card.base.value .. " of " .. card.base.suit)
end


function AKYRS.TBL_C2S(table)
    local result = ""
    for _, card in ipairs(table) do
        if type(card) == "table" and card.base and card.base.value and card.base.suit then
            result = result .. AKYRS.C2S(card) .. ", "
        else
            return nil
        end
    end
    return result:sub(1, -3) -- Remove the trailing ", "
end


AKYRS.wrap_in_col = function(table_ui)
    local x = {}
    for _,v in ipairs(table_ui) do
        x[#x+1] = { n = G.UIT.C, nodes = {v}}
    end
    return x
end


AKYRS.is_in_pool = function(card,pool)
    if not card then return false end
    if not card.config then return false end
    if not card.config.center or not card.config.center.pools then return false end
    return card.config.center.pools[pool]
end


function AKYRS.filter_table(tbl, predicate, ordered_in, ordered_out) 
    if not tbl or not predicate then return {} end
    local table_out = {}
    if ordered_in then
        for k,v in ipairs(tbl) do
            if predicate(v) then
                if ordered_out then
                    table.insert(table_out,v)
                else
                    table_out[k] = v
                end
            end
        end
    else
        for k,v in pairs(tbl)  do
            if predicate(v) then
                if ordered_out then
                    table.insert(table_out,v)
                else
                    table_out[k] = v
                end
            end
        end 
    end
    return table_out
end

AKYRS.mod_score = function(score_mod)
    AKYRS.simple_event_add(
        function()
            AKYRS.mod_score_instant(score_mod)
            return true
        end, 0
    )
end

AKYRS.mod_score_instant = function(score_mod)

    score_mod = score_mod or {}
    local pow = score_mod.pow or 1
    local mult = score_mod.mult or 1
    local add = score_mod.add or 0
    local score_cal = score_mod.set or G.GAME.chips
    score_cal = score_cal ^ pow
    score_cal = score_cal * mult
    score_cal = score_cal + add
    local old = G.GAME.chips
    if Talisman then
        score_cal = to_big(score_cal)
    end
    -- TODO: jank, will fix later
    G.GAME.chips = score_cal
    local amount = score_cal - old
    local comp
    if Talisman then
        comp = amount > to_big(0)
    else
        comp = amount > 0
    end
    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
    if score_mod.card then
        card_eval_status_text(score_mod.card, 'jokers', nil, percent, nil, {message = localize{type='variable',key= comp and 'k_akyrs_score_add' or 'k_akyrs_score_minus',vars={amount}}, akyrs_no_sound = true, colour =  G.C.PURPLE, instant = true})
    end
    play_sound('gong')
end

AKYRS.get_most_played = function()
    local _planet, _hand, _tally = nil, nil, 0
    for k, v in ipairs(G.handlist) do
        if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
            _hand = v
            _tally = G.GAME.hands[v].played
        end
    end
    if _hand then
        AKYRS.get_planet_for_hand(_hand)
    end
    return _planet, _hand, _tally
end

AKYRS.get_planet_for_hand = function(_hand)
    local _planet
    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
        if v.config.hand_type == _hand then
            _planet = v.key
        end
        if v.config.akyrs_hand_types then
            for i,v2 in ipairs(v.config.akyrs_hand_types) do
                if v2 == v then
                    _planet = v.key
                end
            end
        end
    end
    return _planet
end

AKYRS.is_mod_loaded = function(var) 
    if not var then return false end
    return (SMODS.Mods[var] and SMODS.Mods[var].can_load) and true or false
end
function AKYRS.juice_like_tarot(card)
    play_sound('tarot1')
    card:juice_up(0.3, 0.5)
end
---@param cards Card[] list of cards
---@param func fun(card: Card, index: number): nil callback for each card
---@param config? table config for the function
---@param queue? string event queue
function AKYRS.do_things_to_card(cards, func, config, queue) -- func(card)
    queue = queue or "base"
    config = config or {stay_flipped_delay = 1,stagger = 0.5,finish_flipped_delay = 0.5, fifo = true}
    if not cards then return end
    for i, card in ipairs(cards) do
        AKYRS.simple_event_add(
            function ()
                
                if not config.no_sound then
                    play_sound('card1')
                end
                if not config.no_juice then
                    card:juice_up(0.3, 0.3)
                end
                if not config.no_flip then
                    card:flip()
                end
                if not config.fifo then
                    if(config.stay_flipped_delay) then
                        delay(config.stay_flipped_delay, queue)
                    end
                    AKYRS.simple_event_add(
                        function ()
                            func(card, i)
                            if not config.no_sound then
                                play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                            end
                            if not config.no_juice then
                                card:juice_up(0.3, 0.3)
                            end
                            if not config.no_flip then
                                card:flip()
                            end
                            if not config.dont_unhighlight and card.highlighted and card.area then
                                card.area:remove_from_highlighted(card)
                            end
                            return true
                        end,config.finish_flipped_delay or 0.5, queue
                    )
                end

                return true
            end,config.stagger or 0, queue
        )
        if config.fifo and config.fifo_wait_for_finish then
            AKYRS.simple_event_add(
                function ()
                    func(card, i)
                    if not config.no_sound then
                        play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                    end
                    if not config.no_juice then
                        card:juice_up(0.3, 0.3)
                    end

                    if not config.no_flip then
                        card:flip()
                    end
                    if not config.dont_unhighlight and card.highlighted and card.area then
                        card.area:remove_from_highlighted(card)
                    end
                    return true
                end,config.finish_flipped_delay or 0.5, queue
            )
        end
    end
    if(config.fifo and config.stay_flipped_delay) then
        delay(config.stay_flipped_delay or 0, queue)
        for i, card in ipairs(cards) do
            if config.fifo and not config.fifo_wait_for_finish then
                AKYRS.simple_event_add(
                    function ()
                        if not config.once then
                        end

                        func(card, i)
                        if not config.no_sound then
                            play_sound("card1",math.abs(1.15 - (i-0.999)/(#cards-0.998)*0.3))
                        end
                        if not config.no_juice then
                            card:juice_up(0.3, 0.3)
                        end

                        if not config.no_flip then
                            card:flip()
                        end
                        if not config.dont_unhighlight and card.highlighted and card.area then
                            card.area:remove_from_highlighted(card)
                        end
                        return true
                    end,config.finish_flipped_delay or 0.5, queue
                )
            end
        end
    end

end

function AKYRS.pseudorandom_elements(tables, count, seed, args)
    if not count then count = 1 end
    local outp = {}
    local tb = {}
    for i,j in ipairs(tables) do
        table.insert(tb,j)
    end
    
    if count >= #tb then
        return tb
    end
    for i = 1,count do
        local elem = pseudorandom_element(tb,seed,args)
        table.insert(outp,elem)
        AKYRS.remove_value_from_table(tb,elem)
    end
    return outp
end

function AKYRS.copy_p_card(original, new_card, card_scale, playing_card, strip_edition, area_to_add_to)
    area_to_add_to = area_to_add_to or G.hand
    playing_card = playing_card or G.playing_card
    playing_card = (playing_card and playing_card + 1) or 1
    local card = copy_card(original, new_card, card_scale, playing_card, strip_edition)
    table.insert(G.playing_cards,card)
    if area_to_add_to then
        area_to_add_to:emplace(card)
    end
    card:set_sprites(card.config.center,card.config.card)
    return card
end
function AKYRS.deselect_from_area(card)
    if card.area then
        card.area:remove_from_highlighted(card)
    end
end

function AKYRS.can_afford(money)
    if Talisman then
        
        return to_big(money) < to_big(G.GAME.dollars) - to_big(G.GAME.bankrupt_at)
    end
    return money < G.GAME.dollars - G.GAME.bankrupt_at
end


function AKYRS.do_nothing(...)
    return ...
end

function AKYRS.has_room(cardarea, card, extra)
    extra = extra or 0
    if not cardarea.cards then return true end
    return #cardarea.cards + extra < cardarea.config.card_limit + (card and AKYRS.edition_extend_card_limit(card) or 0)
end

function AKYRS.force_save()
    AKYRS.simple_event_add(
        function ()
            save_run()
            G.FILE_HANDLER.force = true
            return true
        end
    )
end


-- i fucking hate talisman™
function AKYRS.compare(val1, sign, val2)
    local value1 = Talisman and to_big(val1) or val1
    local value2 = Talisman and to_big(val2) or val2
    if sign == "==" then return value1 == value2 end
    if sign == ">=" then return value1 >= value2 end
    if sign == "<=" then return value1 <= value2 end
    if sign == ">" then return value1 > value2 end
    if sign == "<" then return value1 < value2 end
    if sign == "~=" or sign == "!=" then return value1 ~= value2 end
end

AKYRS.get_non_eternals = function (area, trigger)
    if area and area.cards then
        local cards = {}
        for _,c in ipairs(area.cards) do
            if not SMODS.is_eternal(c, trigger) then
                table.insert(cards, c)
            end
        end
        return cards
    end
    return {}
end

local validLetters = {}
for i = 48, 57 do -- 0-9
    table.insert(validLetters, string.char(i))
end
for i = 65, 90 do -- A-Z
    table.insert(validLetters, string.char(i))
end
for i = 97, 122 do -- a-z
    table.insert(validLetters, string.char(i))
end

function AKYRS.random_string(length)
    local stri = ""
    for i = 1, length do
        stri = stri .. pseudorandom_element(validLetters, "akyrs_random_string")
    end
    return stri

end

function AKYRS.round(val)
    local neg = val < 0 and -1 or 1
    local ve = math.abs(val)
    if ve - math.floor(ve) >= 0.5 then
        return neg * math.ceil(ve)
    else
        return neg * math.floor(ve)
    end
end
-- https://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
function AKYRS.hsl2rgb(h,s,l,al) 
    local a=s*math.min(l,1-l);
    local f = function(n, k) k = math.fmod((n+h/30),12); return l - a*math.max(math.min(k-3,9-k,1),-1) end
    return {f(0),f(8),f(4),al};
end
-- https://gist.github.com/FGRibreau/3790217
table.akyrs_filter = function(t, filterIter, isIndexed)
    local out = {}
    if isIndexed then
        for k, v in ipairs(t) do
            if filterIter(v, k, t) then table.insert(out, v) end
        end
    else
        for k, v in pairs(t) do
            if filterIter(v, k, t) then out[k] = v end
        end
    end

    return out
end