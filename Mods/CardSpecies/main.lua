loc_colour()
CardSpecies = SMODS.current_mod
--this mod is literally just a copy of card pronouns with some alterations, forgive me god for i have done coding sin

CardSpecies.badge_types = {}
CardSpecies.classifications = {}
CardSpecies.PlayingCardOverrides = {}

assert(SMODS.load_file("util.lua"))()
assert(SMODS.load_file("api.lua"))()
assert(SMODS.load_file("badge.lua"))()

assert(SMODS.load_file("species.lua"))()
assert(SMODS.load_file("Items/Jokers/shapebending.lua"))()
--assert(SMODS.load_file("Items/Jokers/genderactive.lua"))()

if next(SMODS.find_mod("cardpronouns")) then
    assert(SMODS.load_file("pronouns.lua"))()
end