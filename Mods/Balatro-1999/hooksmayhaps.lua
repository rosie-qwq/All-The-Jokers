--This is where I'll keep stolen goods if I'll need em. Nice >:]

--This one is from Baladrone. Balatro Modded Wiki is very convenient for taking other peoples stuff!
do
    local original_play_cards_from_highlighted = G.FUNCS.play_cards_from_highlighted
    G.FUNCS.play_cards_from_highlighted = function(e)
        SMODS.calculate_context({b1999_play_button = true})

        original_play_cards_from_highlighted(e)
    end
end

do
    local original_ease_ante = ease_ante
    ease_ante = function(e)
        SMODS.calculate_context({b1999_ante_change = true})

        original_ease_ante(e)
    end
end

--Do I need this? Idk, probably no? I think Cartoncle is probably possible without it, butttt.... Idk man, I wanted to 
do
    local original_use_card = G.FUNCS.use_card
    G.FUNCS.use_card = function(e)
        SMODS.calculate_context({b1999_use_card = true})

        original_use_card(e)
    end
end
