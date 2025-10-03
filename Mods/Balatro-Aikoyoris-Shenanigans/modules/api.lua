-- this file contains function that you can hook to add your own compatibility stuff



AKYRS.other_mods_blind_icons = function(blind,ability_text_table,extras,data)
end


-- for custom blind icons
AKYRS.other_mods_blind_icons_pos = function(key)
end

-- this should return 3 things
-- first return is for the intended card area for a thing to spawn (as an area)
-- second is the intended pool (table)
-- third is the intended center name
AKYRS.other_mods_maxwell_card_to_area_map = function(word)
end

-- first is key without e and second is key with e_
AKYRS.other_mods_word_to_edition_map = function(word)
end

-- parameter is word returns enhancement from G.P_CENTERS
AKYRS.other_mods_word_to_enhancement_map = function(word)
end

-- parameter is plurals and returns singular form
AKYRS.other_mods_plural_centers = function(word)
end


AKYRS.other_mods_is_star = function(key)
end

AKYRS.other_mods_get_sprite_for_letter = function(card, letter)
end

AKYRS.other_mods_rank_to_atlas = function(rank_key, card)
end

AKYRS.other_mods_suit_to_atlas = function(suit_key, card)
end

AKYRS.card_conf_any_drag = function(area, card)
    return false
end
