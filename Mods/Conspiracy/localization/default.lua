return {
    descriptions = {
        Conspiracy = {
            c_cspy_5g = {
                name = '5G',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'add {C:dark_edition}Foil{} to',
                    'up to {C:attention}#3#{} selected cards',
                }
            },
            c_cspy_assassination = {
                name = 'Assassination',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    '{C:red}destroy{} one random {C:attention}Joker{}',
                    'and add a {C:attention}Red Seal{} to all',
                    'playing cards held in hand'
                }
            },
            c_cspy_conspiracy_dummy = {
                name = 'Conspiracy Card',
                text = {
                    'Probability {C:attention}increases{} by {C:green}#1#{}',
                    'for every other',
                    'Conspiracy Card held'
                }
            },
            c_cspy_corruption = {
                name = 'Corruption',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'give {C:money}$#3#{} for',
                    'every {C:diamonds}Diamond{} in hand',
                }
            },
            c_cspy_coverup = {
                name = 'Cover-Up',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'destroy a selected {C:attention}Enhanced{} Card',
                    'and replace it with {C:attention}#3#{} base cards',
                    'of the same rank'
                }
            },
            c_cspy_flat_earth = {
                name = 'Flat Earth',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'create {C:attention}#3#{} random',
                    '{C:dark_edition}Negative {C:planet}Planet{} Cards',
                }
            },
            c_cspy_hoax = {
                name = 'Hoax',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'change the suit of up to {C:attention}#3#',
                    'selected cards to their',
                    'same-color counterpart',
                    '{C:inactive}({C:hearts}Hearts {C:inactive}<> {C:diamonds}Diamonds{C:inactive}, {C:clubs}Clubs {C:inactive}<> {C:spades}Spades{C:inactive})'
                }
            },
            c_cspy_landing = {
                name = 'Moon Landing',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'add {C:attention}#3#{} levels to your',
                    '{C:attention}least{} played poker hand',
                }
            },
            c_cspy_mib = {
                name = 'Men in Black',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    '{C:attention}remove{} the enhancement of',
                    'up to {C:attention}#3#{} selected cards',
                }
            },
            c_cspy_pyramid = {
                name = 'Pyramid',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'create a {C:attention}Stone Card{} for',
                    'every {C:spades}Spade{} in hand',
                }
            },
            c_cspy_sighting = {
                name = 'Sighting',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'give {C:attention}+#3#{} hand size',
                    'for current round',
                }
            },
            c_cspy_society = {
                name = 'Secret Society',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'add a {C:green}random {C:dark_edition}edition{} to',
                    'a {C:green}random{} Joker for every',
                    '{C:clubs}Club{} held in hand'
                }
            },
            c_cspy_tinfoil = {
                name = 'Tinfoil Fail',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'disable an active',
                    '{C:attention}Boss Blind',
                }
            },
            c_cspy_vaccine = {
                name = 'Vaccine',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'turn all {C:hearts}Hearts{} into',
                    '{C:attention}Lucky{} Cards',
                }
            },
            c_cspy_woke = {
                name = 'Woke',
                text = {
                    '{C:green}#1# in #2#{} chance to',
                    'change the rank of up to {C:attention}#3#',
                    'selected cards into {C:attention}Queens',
                }
            },
        },
        Joker = {
            j_cspy_apophenia = {
                name = 'Apophenia',
                text = {
                    "Played hands containing",
                    "a {C:attention}Straight{} creates",
                    "a {C:dark_edition}Negative {C:tarot}Conspiracy{} Card"
                },
            },
            j_cspy_bigfool = {
                name = 'Bigfool',
                text = {
                    "After each round,",
                    "{C:green}#1# in #2#{} chance to",
                    "make a held {C:tarot}Conspiracy",
                    "Card {C:dark_edition}Negative"
                },
            },
            j_cspy_cork_board = {
                name = 'Cork Board',
                text = {
                    "{X:mult,C:white}X#1#{} Mult for every {C:purple}Conspiracy{}",
                    "card held in hand"
                },
            },
            j_cspy_grifter = {
                name = 'Grifter',
                text = {
                    "{C:chips}+#1#{} Chips per {C:purple}Conspiracy{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive})",
                },
            },
            j_cspy_hush_money = {
                name = 'Hush Money',
                text = {
                    "Gives {C:money}$#1#{} at",
                    "end of round,",
                    "{C:red}-$#2#{} for every used",
                    "or sold {C:tarot}Conspiracy{} Card"
                },
            },
            j_cspy_illuminati = {
                name = 'Illuminati',
                text = {
                    "Creates {C:attention}#1#{} {C:purple}Conspiracy{} Card",
                    "at the end of each round",
                    "{C:inactive, s:0.8}(Must have room)",
                },
            },
            j_cspy_red_yarn = {
                name = 'Red Yarn',
                text = {
                    "{C:mult}+#1#{} Chips per {C:purple}Conspiracy{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive})",
                },
            },
            j_cspy_ufo = {
                name = 'Unidentified Funny Object',
                text = {
                    "{X:green,C:white}X#1#{} {C:green}probabilities{} of",
                    "{C:purple}Conspiracy{} Cards working",
                    "{C:green}#2# in #3#{} chance to be",
                    "{C:red}destroyed{} after each round"
                },
            },
        },
        Other = {
            p_cspy_conspiracy_jumbo_1 = {
                name = 'Jumbo Classified Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Tarot} Conspiracy{} cards to",
                    "be used immediately",
                },
            },
            p_cspy_conspiracy_mega_1 = {
                name = 'Mega Classified Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Tarot} Conspiracy{} cards to",
                    "be used immediately",
                },
            },
            p_cspy_conspiracy_normal_1 = {
                name = 'Classified Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Tarot} Conspiracy{} cards to",
                    "be used immediately",
                },
            },
            p_cspy_conspiracy_normal_2 = {
                name = 'Classified Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Tarot} Conspiracy{} cards to",
                    "be used immediately",
                },
            },
            cspy_credits = {
                name = "",
                text = {
                    '{C:dark_edition,E:1,s:4}C O N S P I R A C Y',
                    ' ',
                    '{X:purple,C:white}Lead{} {X:purple,C:white}Programmer:{} {C:purple}theAstra',
                    '{X:attention,C:white}Lead{} {X:attention,C:white}Artist:{} {C:attention}amerdymous',
                    ' ',
                    '{X:gold,C:white}Special{} {X:gold,C:white}Thanks:{} All the awesome people in the Balatro Discord!',
                }
            },
            undiscovered_conspiracy = {
                name = "Not Discovered",
                text = {
                    "Purchase this",
                    "card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },
        },
        Voucher = {

        }
    },
    misc = {
        achievement_descriptions = {

        },
        achievement_names = {

        },
        challenge_names = {

        },
        dictionary = {
            b_conspiracy_cards = "Conspiracy Cards",
            b_cspy_credits = "Credits",
            b_cspy_custom_menu = "Enable Custom Menu",
            k_cspy_artist = "Artist",
            k_conspiracy = "Conspiracy",
            k_cspy_covered_up = "Covered Up",
            k_cspy_classified_pack = "Classified Pack",
        },
        v_text = {

        }
    }
}
