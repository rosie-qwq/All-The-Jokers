SMODS.Achievement{
    key = "spell_aikoyori",
    prefix_config = {
        atlas = false
    },
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_spell_word" and args.lowercase_word == "aikoyori") then
            return true
        end
    end
}
SMODS.Achievement{
    key = "happy_ghast_grown",
    prefix_config = {
        atlas = false
    },
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_happy_ghast_grown_from_dried") then
            return true
        end
    end
}
SMODS.Achievement{
    key = "repeater_into_another_one",
    prefix_config = {
        atlas = false
    },
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_repeater_into_another_one") then
            return true
        end
    end
}

SMODS.Achievement{
    key = "repeater_into_another_one",
    prefix_config = {
        atlas = false
    },
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_repeater_into_another_one") then
            return true
        end
    end
}

SMODS.Achievement{
    key = "both_pickaxe",
    prefix_config = {
        atlas = false
    },
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_both_pickaxe") then
            return true
        end
    end
}
SMODS.Achievement{
    key = "win_klondike",
    prefix_config = {
        atlas = false
    },
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "akyrs_win_solitaire") then
            return true
        end
    end
}