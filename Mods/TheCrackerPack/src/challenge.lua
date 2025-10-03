function Cracker.get_challenge_by_id(challenges_table, id) -- G.CHALLENGES for vanilla challenges
    for _, challenge in pairs(challenges_table) do
        if challenge.id == id then
            return challenge
        end
    end
    return nil
end
local omelette = Cracker.get_challenge_by_id(G.CHALLENGES, "c_omelette_1")
local nonperishable = Cracker.get_challenge_by_id(G.CHALLENGES, "c_non_perishable_1")
local blastoff = Cracker.get_challenge_by_id(G.CHALLENGES, "c_blast_off_1")
local fivecard = Cracker.get_challenge_by_id(G.CHALLENGES, "c_five_card_1")
local goldenneedle = Cracker.get_challenge_by_id(G.CHALLENGES, "c_golden_needle_1")

if omelette then
    table.insert(omelette.restrictions.banned_cards, 2, {id = 'v_cracker_silver_spoon'})
    table.insert(omelette.restrictions.banned_cards, 2, {id = 'v_cracker_heirloom'})
    table.insert(omelette.restrictions.banned_cards, {id = 'j_cracker_chocolatecoin'})
    if not disable_card then
        table.insert(omelette.restrictions.banned_cards, {id = 'j_cracker_yellowcard'})
    end
end

if nonperishable then
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_chocolatecoin'})
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_saltinecracker'})
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_grahamcracker'})
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_cheese'})
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_crackerbarrel'})
    table.insert(nonperishable.restrictions.banned_cards, 8, {id = 'j_cracker_curry'})
end

if blastoff then
    table.insert(blastoff.restrictions.banned_cards, {id = 'j_cracker_knifethrower'})
end

if fivecard then
    if not disable_card then
        table.insert(fivecard.restrictions.banned_cards, {id = 'j_cracker_pinkcard'})
    end
end

if goldenneedle then
    table.insert(goldenneedle.restrictions.banned_cards, {id = 'j_cracker_knifethrower'})
end

SMODS.Challenge{
    loc_txt = {name = "Hot Potato"},
    key = "hotpotato",
    jokers = {
        {id = 'j_cracker_bomb', eternal = true},
    },
    rules = {
        modifiers = {
            { id = "joker_slots", value = 6 },
        },
        custom = {
        }
    },
}

SMODS.Challenge{
    loc_txt = {name = "Dance of the Blades"},
    key = "swordsclash",
    jokers = {
        {id = 'j_ceremonial', eternal = true},
        {id = 'j_cracker_sacramentalkatana', eternal = true},
    },
    rules = {
        modifiers = {
            { id = "joker_slots", value = 4 },
        }
    },
    restrictions = {
        banned_cards = {
        }
    }
}

SMODS.Challenge{
    loc_txt = {name = "The End"},
    key = "theend2",
    jokers = {
        {id = 'j_perkeo', edition = "negative"},
        {id = 'j_diet_cola'},
    },
    vouchers = {
    },
    rules = {
        custom = {
            {id = 'ante_39'},
            {id = 'plasma'},
            {id = 'plasma_2'},
        }
    }
}