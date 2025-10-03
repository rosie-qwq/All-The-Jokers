
AKYRS.example_words = {
    "cry",
    "card",
    "jimbo",
    "thrash",
    "sticker",
    "foreword",
    "mainframe",
    "mainlander",
    "hyperactive",
    "skeletonised",
    "neanderthaler",
    "televisionally",
    "demographically",
    "tropostereoscope",
    "erythroneocytosis",
    "heteroscedasticity",
    "unmisunderstandable",
    "adrenocorticosteroid",
    "poluphloisboiotatotic",
    "polioencephalomyelitis",
    "overintellectualization",
    "formaldehydesulphoxylate",
    "demethylchlortetracycline",
    "mentor-on-the-lake-village",
    "electroencephalographically",
    "antidisestablishmentarianism",
    "cyclotrimethylenetrinitramine",
    "##############################",
    "dichlorodiphenyltrichloroethane",
    "################################",
    "#################################",
    "##################################",
    "###################################",
    "####################################",
    "#####################################",
    "######################################",
    "#######################################",
    "########################################",
    "#########################################",
    "##########################################",
    "###########################################",
    "############################################",
    "pneumonoultramicroscopicsilicovolcanoconiosis",
}
local function replace_char(pos, str, r)
    return str:sub(1, pos-1) .. r .. str:sub(pos+1)
end
-- some skeleton
if AKYRS.config.wildcard_behaviour == 1 then
    -- default: shouldn't do anything
elseif AKYRS.config.wildcard_behaviour == 2 then
    -- warn on unset: this should be on the play cards function
elseif AKYRS.config.wildcard_behaviour == 3 then
    -- warn on unset: this should not run the recursive to find letters basically
elseif AKYRS.config.wildcard_behaviour == 4 then
    -- warn on unset: this should set pretend letters to that of the card
end

function AKYRS.check_word(str_arr_in)
    --print("what")
    local wild_positions = {}
    local wild_count = 0

    for i = 1, #str_arr_in do
        if str_arr_in[i] == "#" then
            wild_count = wild_count + 1
            wild_positions[wild_count] = i
        end
    end

    -- If no wildcards, check directly
    if wild_count == 0 then
        local word_str = table.concat(str_arr_in)
        return { valid = AKYRS.words[word_str], word = AKYRS.words[word_str] and word_str or nil }
    end

    local function backtrack(index)
        if index > wild_count then
            local word_str = table.concat(str_arr_in)
            if AKYRS.words[word_str] and #word_str == #str_arr_in then
                return { valid = true, word = word_str }
            end
            return nil
        end

        local pos = wild_positions[index]
        for i = 1, #aiko_alphabets_no_wilds do
            str_arr_in[pos] = aiko_alphabets_no_wilds[i]
            local result = backtrack(index + 1)
            if result then return result end
        end
        str_arr_in[pos] = "#"
        return nil
    end

    return backtrack(1) or { valid = false, word = nil }
end

AKYRS.WORD_CHECKED = {

}

AKYRS.words_hand = {}
for i = 3, 45 do
    local exampler = {}
    for j = 1, #AKYRS.example_words[i-2] do
        local c = AKYRS.example_words[i-2]:sub(j,j)
        table.insert(exampler,{
            AKYRS.randomCard(),
            true,
            nil,
            akyrs_letter = c,
            is_null = true
        })
    end
    
    table.insert(AKYRS.words_hand, i.."-letter Word")
    SMODS.PokerHand {
        key = i.."-letter Word",
        visible = false,
        example = exampler,
        evaluate = function(parts, hand_in)
            if ((not G.GAME.akyrs_character_stickers_enabled) or (not G.GAME.akyrs_wording_enabled)) and not AKYRS.word_blind() then 
            return {} end
            local word_hand = {}
            local hand = AKYRS.shallow_indexed_table_copy(hand_in)
            table.sort(hand, AKYRS.hand_sort_function)
            for _, v in pairs(hand) do
                if not v.ability or not v.ability.aikoyori_letters_stickers then return {} end
                local alpha = v.ability.aikoyori_letters_stickers:lower()
                if alpha == "#" and v.ability.aikoyori_pretend_letter then
                    -- if wild is set fr tbh
                    alpha = v.ability.aikoyori_pretend_letter:lower()
                elseif alpha == "#" and AKYRS.config.wildcard_behaviour == 3 then -- if it's unset in mode 3 then just make it a random letter i guess
                    alpha = '★'
                end
                for _, ltr in ipairs(AKYRS.word_splitter(alpha)) do
                    table.insert(word_hand, ltr)
                end 
            end
            if #word_hand ~= i then
                return {}
            end
            
            local word_hand_str = table.concat(word_hand)
            
            local all_wildcards = true
            for _, val in ipairs(word_hand) do
                if val ~= "#" then
                    all_wildcards = false
                    break
                end
            end
            if all_wildcards then
                G.GAME.aiko_current_word = string.lower(AKYRS.example_words[i-2])
                return { hand }
            end
            local wordData = {}
            --print("CHECK TIME! FOR '"..word_hand_str.."' IS THE WORD")
            if (AKYRS.WORD_CHECKED[word_hand_str]) then
                --print("WORD "..word_hand_str.." IS IN MEMORY AND THUS SHOULD USE THAT")
                wordData = AKYRS.WORD_CHECKED[word_hand_str]
            else
                --print("WORD "..word_hand_str.." IS NOT IN MEMORY ... CHECKING")
                wordData = AKYRS.check_word(word_hand)
                AKYRS.WORD_CHECKED[word_hand_str] = wordData
            end
            if wordData.valid then
                G.GAME.aiko_current_word = wordData.word
                local aiko_current_word_split = {}
                return {hand}
            else 
                return {}
            end
        end,
        chips = 3 * i + (i-1.8) ^ (1 + i * 0.25),
        mult = 2*1.5^i + 3,
        l_chips = 5*1.5^i + 3,
        l_mult = 2*1.45^i + 3,
    }
end


SMODS.PokerHand{
    key = "expression",
    chips = 0,
    mult = 0,
    l_chips = 0,
    l_mult = 0,
    visible = false,
    example = {
        { "", true, nil, akyrs_letter = "3", is_null = true},
        { "", true, nil, akyrs_letter = "7", is_null = true},
        { "", true, nil, akyrs_letter = "*", is_null = true},
        { "", true, nil, akyrs_letter = "4", is_null = true},
        { "", true, nil, akyrs_letter = "+", is_null = true},
        { "", true, nil, akyrs_letter = "2", is_null = true},
        { "", true, nil, akyrs_letter = "7", is_null = true},
    },
    evaluate = function(parts, hand_in)
        if ((not G.GAME.akyrs_character_stickers_enabled) or (not G.GAME.akyrs_mathematics_enabled)) then 
        return {} end
        local word_hand = {}
        local hand = AKYRS.shallow_indexed_table_copy(hand_in)
        table.sort(hand, AKYRS.hand_sort_function)
        for _, v in pairs(hand) do
            if not v.ability or not v.ability.aikoyori_letters_stickers then return {} end
            local alpha = v.ability.aikoyori_letters_stickers:lower()
            if alpha == "#" and v.ability.aikoyori_pretend_letter then
                -- if wild is set fr tbh
                alpha = v.ability.aikoyori_pretend_letter:lower()
            elseif alpha == "#" and AKYRS.config.wildcard_behaviour == 3 then -- if it's unset in mode 3 then just make it a random letter i guess
                alpha = '★'
            end
            table.insert(word_hand, alpha)
                
        end
        
        local expression = table.concat(word_hand)
        
        
        local status, value = pcall(AKYRS.MathParser.solve,AKYRS.MathParser,expression)
        if not status or #hand < 1 then return {} end
        G.GAME.aikoyori_evaluation_value = value
        G.GAME.aikoyori_evaluation_replace = false
        SMODS.set_scoring_calculation('akyrs_math_display')
        if (G.STATE == G.STATES.HAND_PLAYED) then

            G.GAME.aikoyori_evaluation_value = value
           
        end
        return {hand}
    end,
}
SMODS.PokerHand{
    key = "modification",
    chips = 0,
    mult = 0,
    l_chips = 0,
    l_mult = 0,
    visible = false,
    example = {
        { "", true, nil, akyrs_letter = "/", is_null = true},
        { "", true, nil, akyrs_letter = "2", is_null = true},
        { "", true, nil, akyrs_letter = "5", is_null = true},
    },
    evaluate = function(parts, hand_in)
        if ((not G.GAME.akyrs_character_stickers_enabled) or (not G.GAME.akyrs_mathematics_enabled)) then 
        return {} end
        local word_hand = {}
        local hand = AKYRS.shallow_indexed_table_copy(hand_in)
        table.sort(hand, AKYRS.hand_sort_function)
        for _, v in pairs(hand) do
            if not v.ability or not v.ability.aikoyori_letters_stickers then return {} end
            local alpha = v.ability.aikoyori_letters_stickers:lower()
            if alpha == "#" and v.ability.aikoyori_pretend_letter then
                -- if wild is set fr tbh
                alpha = v.ability.aikoyori_pretend_letter:lower()
            elseif alpha == "#" and AKYRS.config.wildcard_behaviour == 3 then -- if it's unset in mode 3 then just make it a random letter i guess
                alpha = '★'
            end
            table.insert(word_hand, alpha)
                
        end
        
        local expression = table.concat(word_hand)
        local to_number = to_number or function(l) return l end
        local expression_with_chips = tostring(to_number(G.GAME.chips))..table.concat(word_hand)
        
        
        local status_check, value_fake = pcall(AKYRS.MathParser.solve,AKYRS.MathParser,expression)
        local status, value = pcall(AKYRS.MathParser.solve,AKYRS.MathParser,expression_with_chips)
        if status_check or #hand < 1 then return {} end
        if not status then return {} end
        G.GAME.aikoyori_evaluation_value = value
        G.GAME.aikoyori_evaluation_replace = true
        SMODS.set_scoring_calculation('akyrs_math_display')
        if (G.STATE == G.STATES.HAND_PLAYED) then

            G.GAME.aikoyori_evaluation_value = value
           
        end
        return {hand}
    end,
}
SMODS.PokerHand{
    key = "assignment",
    chips = 0,
    mult = 0,
    l_chips = 0,
    l_mult = 0,
    visible = false,
    example = {
        { "", true, nil, akyrs_letter = "x", is_null = true},
        { "", true, nil, akyrs_letter = "=", is_null = true},
        { "", true, nil, akyrs_letter = "7", is_null = true},
    },
    evaluate = function(parts, hand_in)
        if ((not G.GAME.akyrs_character_stickers_enabled) or (not G.GAME.akyrs_mathematics_enabled)) then 
        return {} end
        local word_hand = {}
        local hand = AKYRS.shallow_indexed_table_copy(hand_in)
        table.sort(hand, AKYRS.hand_sort_function)
        for _, v in pairs(hand) do
            if not v.ability or not v.ability.aikoyori_letters_stickers then return {} end
            local alpha = v.ability.aikoyori_letters_stickers:lower()
            if alpha == "#" and v.ability.aikoyori_pretend_letter then
                -- if wild is set fr tbh
                alpha = v.ability.aikoyori_pretend_letter:lower()
            elseif alpha == "#" and AKYRS.config.wildcard_behaviour == 3 then -- if it's unset in mode 3 then just make it a random letter i guess
                alpha = '★'
            end
            table.insert(word_hand, alpha)
                
        end
        
        local expression = table.concat(word_hand)
        local parts = {}
        for part in expression:gmatch("[^=]+") do
            table.insert(parts, part)
        end

        if #parts ~= 2 then
            return {}
        end

        local variable, value_expression = parts[1], parts[2]
        local status, value = pcall(AKYRS.MathParser.solve, AKYRS.MathParser, value_expression)

        if not status then
            return {}
        end

        G.GAME.aikoyori_variable_to_set = variable
        G.GAME.aikoyori_value_to_set_to_variable = value
        return {hand}
    end,
}