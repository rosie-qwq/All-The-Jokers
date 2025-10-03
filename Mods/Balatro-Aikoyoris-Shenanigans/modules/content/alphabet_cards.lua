SMODS.UndiscoveredSprite{
    atlas = "consumablesAlphabetPacks",
    key = "Alphabet",
    pos = {x = 6, y = 2} 
    
}

SMODS.ConsumableType{
    atlas = "consumablesAlphabetPacks",
    key = "Alphabet",
    primary_colour = HEX("747482"),
    secondary_colour = HEX("3e63c2"),
    collection_rows = {6,6,6},
    shop_rate = 0,
    default = "c_akyrs_a",
    loc_txt = {
        collection = "Alphabet Cards",
        name = "Alphabet",

        undiscovered = { -- description for undiscovered cards in the collection
            name = 'Unknown Alphabet',
            text = { 'Find this card when', 'letters are enabled' },
        },
    },
}

local word_letter = {
    "Apple", "Bee", "Cat", "Dog", "Earth", "Fire", "Ghost", "Hat", "Ice", "Jar", 
    "Kite", "Lemon", "Mushroom", "Night", "Onion", "Pie", "Quill", "Rat", "Spoon", "Tea", 
    "Umbrella", "Vase", "Water", "Xylophone", "Yarn", "Zoom"
}


for k, v in ipairs(aiko_alphabets_no_wilds) do
    local upper = string.upper(v)
    
    SMODS.Consumable{
        key = v,
        set = "Alphabet",
        atlas = 'consumablesAlphabetPacks',
        pos = { x = math.fmod(k-1,20), y = math.floor((k-1)/20) } ,
        loc_txt = {
            name = upper.." for "..word_letter[k],
            text = { "Convert all selected cards'","letter to {C:red}#1#{}","{C:inactive,s:0.75}(up to #2# cards){}" },
        },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key = 'letters'..string.upper(card.ability.extra.letter), set = 'AikoyoriExtraBases' ,vars = {
                card.ability.extra.letter,
                (AKYRS.get_scrabble_score(card.ability.extra.letter)),
                1 + (AKYRS.get_scrabble_score(card.ability.extra.letter)/10),
            }}
            return {
                vars = {
                    string.upper(card.ability.extra.letter),
                    card.ability.extra.max_selected,
                },
            }
        end,
        
        config = {extra = {letter = v, max_selected = 999999}},
        
        can_use = function(self, card)
            return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
        end,
        use = function(self, card, area, copier)
            for i=1, #G.hand.highlighted do
                local percent = math.abs(1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3)
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            
            delay(0.5)
            
            for i=1, #G.hand.highlighted do
                local percent = math.abs(0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3)
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    G.hand.highlighted[i]:set_letters(card.ability.extra.letter)
                    G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
        end,
        in_pool = function(self, args)
            return G.GAME.akyrs_character_stickers_enabled
        end,
    }

end



-- Letters
SMODS.Consumable{
    key = "Wild",
    set = "Alphabet",
    atlas = 'consumablesAlphabetPacks',
    pos = { x = 6, y = 1 } ,
    cost = 6,
    loc_txt = {
        name = "? for ????",
        text = { "Convert up to #2# selected card's","letter to {C:red}Wild (#1#){}" },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'letters'..string.upper(card.ability.extra.letter), set = 'AikoyoriExtraBases' ,vars = {
            card.ability.extra.letter,
            (AKYRS.get_scrabble_score(card.ability.extra.letter)),
            1 + (AKYRS.get_scrabble_score(card.ability.extra.letter)/10),
        }}
        return {
            vars = {
                string.upper(card.ability.extra.letter),
                card.ability.extra.max_selected,
            },
        }
    end,
    config = {extra = {letter = "#", max_selected = 1}},
    
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    use = function(self, card, area, copier)
        for i=1, #G.hand.highlighted do
            local percent = math.abs(1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        
        delay(0.5)
        
        for i=1, #G.hand.highlighted do
            local percent = math.abs(0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                G.hand.highlighted[i]:set_letters(card.ability.extra.letter)
                G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
    end,
    in_pool = function(self, args)
        return G.GAME.akyrs_character_stickers_enabled
    end,
}