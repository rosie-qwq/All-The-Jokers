return {
    descriptions = {
        Blind = {
            bl_mul_limbo = {
                name = "The Limbo",
                text = {
                    "F O C U S",
                    "(X#1# Blind size",
                    "on failure)"
                }
            },
            bl_mul_undying = {
                name = "The Undying",
                text = {
                    "Survive",
                    "(Lose chips equal to",
                    "#1#% of Blind size when hit)"
                }
            }
        },
        Enhanced = {
            m_mul_calling_card = {
                name = "Calling Card",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Increases to {X:mult,C:white}X#2#{} Mult",
                    "during a Boss Blind",
                    "Always treated as an",
                    "{C:attention}Ace{} of {C:hearts}Hearts{}",
                    "Gives no base {C:chips}chips{}"
                }
            },
            m_mul_netherite = {
                name = "Netherite Card",
                text = {
                    "{C:chips}+#1#{} Chips when held in",
                    "hand or played",
                    "{X:mult,C:white}X#2#{} Mult when held",
                    "in hand",
                    "Gives {C:money}$#3#{} when held in",
                    "hand at end of round",
                }
            },
            m_mul_normal = {
                name = "Normal Card",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "Treated as",
                    "a {C:attention}face card{}"
                }
            },
            m_mul_motivated = {
                name = "Motivated Card",
                text = {
                    "Retrigger this",
                    "card {C:attention}#1#{} time",
                    "{C:green}#2# in #3#{} chance to",
                    "lose enhancement"
                }
            },
            m_mul_waldo = {
                name = "Waldo Card",
                text = {
                    "Retrigger this",
                    "card {C:attention}#1#{} time per",
                    "card in played hand",
                    "Gives no base {C:chips}chips{}",
                    "Has no rank or suit",
                    "You can only have {C:attention}1{}",
                    "{C:attention}Waldo Card{} in deck"
                }
            }
        },
        mul_Myth = {
            c_mul_philosophers_stone = {
                name = "Philosopher\'s Stone",
                text = {
                    "{C:mul_transmuted,E:1}Transmutes{} {C:attention}#1#{} selected Joker",
                    "that is currently {C:mul_transmuted}Transmutable{}",
                    "{C:inactive}(Must have room, bypasses Eternal){}"
                }
            },
            c_mul_holy_grail = {
                name = "Holy Grail",
                text = {
                    "Creates {C:attention}#1#{} {C:dark_edition}Negative{} consumables",
                    "relevant to the {C:mul_transmuted}transmutation{}",
                    "of selected Joker"
                }
            }
        },
        Joker = {
            j_mul_bloodbath = {
                name = "Bloodbath",
                text = {
                    {
                        "All cards give {X:mult,C:white}X#1#{} Mult when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}I hate the Michigun ufo part"
                    }
                }
            },
            j_mul_cataclysm = {
                name = "Cataclysm",
                text = {
                    {
                        "All cards give {C:mult}+#1#{} Mult when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}That first wave part is so stupid"
                    }
                }
            },
            j_mul_aftermath = {
                name = "Aftermath",
                text = {
                    {
                        "All cards give {C:chips}+#1#{} Chips when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}Who even remembers this level?"
                    }
                }
            },
            j_mul_magic_school_bus = {
                name = "Magic School Bus",
                text = {
                    {
                        "This Joker gains {C:mult}+#1#{} Mult per",
                        "{C:attention}face{} card held in hand",
                        "Resets if there are no",
                        "{C:attention}face cards{} held in hand",
                        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                    },
                    {
                        "{C:inactive,s:0.8}\"Mrs. Frizzle, where are we going?\"",
                        "{C:inactive,s:0.8}\"We're going gambling!\""
                    }
                }
            },
            j_mul_v1 = {
                name = "V1",
                text = {
                    {
                        "When {C:attention}first hand{} of round is",
                        "played, add a {C:attention}Gold Seal{} to",
                        "a random scoring card",
                    },
                    {
                        "{C:inactive,s:0.8}Ultrakill fans will do anything",
                        "{C:inactive,s:0.8}to screw the murder robot"
                    }
                }
            },
            j_mul_villager = {
                name = "Villager",
                text = {
                    {
                        "{C:mult}+#1#{} Mult, lose {C:money}$#2#{}",
                        "when hand is played",
                        "{C:inactive}(#3#/#4#?){}"
                    },
                    {
                        "{C:inactive,s:0.8}Oh, them? They're the villagers!"
                    }
                }
            },
            j_mul_antimatter = {
                name = "Antimatter",
                text = {
                    {
                        "{C:mult}+#1#{} Mult?"
                    },
                    {
                        "{C:inactive,s:0.8}The ninth dimension is",
                        "{C:inactive,s:0.8}[DATA EXPUNGED],",
                        "{C:inactive,s:0.8}trust me bro"
                    }
                }
            },
            j_mul_red_balloon = {
                name = "Red Balloon",
                text = {
                    {
                        "Earn {C:money}$#1#{} when a card is scored",
                        "{C:red,E:2}Self-destructs{} in {C:attention}#3#{} rounds",
                        "{C:inactive}(Currently #2#/#3#){}"
                    },
                    {
                        "{C:inactive,s:0.8}The hardest balloon to pop,",
                        "{C:inactive,s:0.8}especially if it's camoflauged,",
                        "{C:inactive,s:0.8}regenerating and fortified"
                    }
                }
            },
            j_mul_ren_amamiya = {
                name = "Ren Amamiya",
                text = {
                    {
                        "The {C:attention}first{} played card that",
                        "scores becomes a {C:attention}Calling Card{}",
                        "Retrigger all played {C:attention}Calling Cards{}",
                        "a number of times equal to the",
                        "number of {C:attention}distinct{} {C:tarot}Tarot{} cards",
                        "in your consumable area",
                        "{C:inactive}(Currently #1# times){}"
                    },
                    {
                        "{C:inactive,s:0.8}You never see it coming"
                    }
                }
            },
            j_joker = {
                name = "Joker",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:inactive}(#2#/#3#?){}"
                }
            },
            j_mul_steve = {
                name = "Steve",
                text = {
                    {
                        "All played cards with {C:diamonds}#1#{}",
                        "suit become {C:attention}Netherite{} cards",
                        "{C:attention}+#2#{} hand size"
                    },
                    {
                        "{C:inactive,s:0.8}L-l-l-lava,{}",
                        "{C:inactive,s:0.8}ch-ch-ch-chicken,",
                        "{C:inactive,s:0.8}steve's lava chicken yeah",
                        "{C:inactive,s:0.8}it's tasty as hell"
                    }
                }
            },
            j_mul_summoned_skull = {
                name = "Summoned Skull",
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult",
                        "Destroys a {C:attention}random{} Joker",
                        "when purchased"
                    },
                    {
                        "{C:inactive,s:0.8}Yugi should've used this",
                        "{C:inactive,s:0.8}as his ace monster",
                        "{C:inactive,s:0.8}instead of Dark Magician,",
                        "{C:inactive,s:0.8}needs 1 less tribute for the same",
                        "{C:inactive,s:0.8}amount of attack power"
                    }
                }
            },
            j_mul_fifty_fifty = {
                name = "50/50",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance",
                        "to give {X:mult,C:white}X#3#{} Mult",
                        "If this probability fails, instead",
                        "give {C:mult}+#4#{} Mult"
                    },
                    {
                        "{C:inactive,s:0.8}The 50/50 feels like a",
                        "{C:inactive,s:0.8}10/90 because of how often",
                        "{C:inactive,s:0.8}I get a Qiqi"
                    }
                }
            },
            j_mul_victory_royale = {
                name = "Victory Royale",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance for",
                        "scored cards to create",
                        "a random {C:dark_edition}Negative{}",
                        "{C:spectral}Spectral{} card",
                        "{C:green}Base odds{} decreases by",
                        "{C:attention}#3#{} when a card is scored",
                        "{C:green}Base odds{} resets to {C:attention}100{}",
                        "after creating a {C:spectral}Spectral{} card"
                    },
                    {
                        "{C:inactive,s:0.8}Who let Miku have a gun?"
                    }
                }
            },
            j_mul_hammer_bro = {
                name = "Hammer Bro",
                text = {
                    {
                        "Scored cards {C:attention}randomly{} give",
                        "either {C:mult}+#1#{} Mult",
                        "or {X:mult,C:white}X#2#{} Mult",
                        "{C:inactive}(#3#/#4#?){}"
                    },
                    {
                        "{C:inactive,s:0.8}These turtles always",
                        "{C:inactive,s:0.8}pick the worst time",
                        "{C:inactive,s:0.8}to throw hammers at me"
                    }
                }
            },
            j_mul_gerson = {
                name = "Gerson",
                text = {
                    {
                        "Disables every {C:attention}Boss Blind{}",
                        "All Jokers each give",
                        "{X:mult,C:white}X#1#{} Mult, increases by",
                        "{X:mult,C:white}X#2#{} when entering",
                        "a {C:attention}Boss Blind{}",
                    },
                    {
                        "{C:inactive,s:0.8}I'm old!"
                    }
                }
            },
            j_mul_stand_user = {
                name = "Stand User",
                text = {
                    {
                        "Prevents Death during",
                        "a {C:attention}Boss Blind{}, then",
                        "{C:attention}#1#{} Ante",
                        "{C:red,E:2}Self-destructs{}"
                    },
                    {
                        "{C:inactive,s:0.8}The stand user",
                        "{C:inactive,s:0.8}could be anyone"
                    }
                }
            },
            j_pareidolia = {
                name = "Pareidolia",
                text = {
                    "All cards are",
                    "considered",
                    "{C:attention}face{} cards",
                    "{C:inactive}(#1#/#2#?){}"
                },
            },
            j_mul_waldo = {
                name = "Waldo",
                text = {
                    "Add a {C:attention}Waldo Card{} to",
                    "deck when this card",
                    "is obtained",
                    "{C:attention}Waldo Cards{} give {X:mult,C:white}X#1#{} Mult",
                    "per card in full deck",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
                }
            },
            j_mul_foddian_struggle = {
                name = "Foddian Struggle",
                text = {
                    "This Joker gains",
                    "{C:mult}+#2#{} Mult per",
                    "consecutive hand played",
                    "without a {V:1}#1#{}",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
                }
            },
            j_mul_peashooter = {
                name = "Peashooter",
                text = {
                    "If played hand contains",
                    "exactly {C:attention}1{} card,",
                    "this Joker gains {C:mult}+#1#{} Mult",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            }
        },
        Spectral = {
            c_mul_eternity = {
                name = "Eternity",
                text = {
                    "Select {C:attention}#1#{} card in hand",
                    "Destroys all unselected",
                    "cards in hand and gives",
                    "all Jokers {C:attention}Eternal{}",
                }
            },
            c_mul_eternity_alt = {
                name = "Eternity",
                text = {
                    "Select {C:attention}#1#{} card in hand",
                    "Destroys all unselected",
                    "cards in hand and gives",
                    "all Jokers {C:attention}Eternal{}",
                    "{C:inactive}(Destroys all Jokers that",
                    "{C:inactive}cannot receive Eternal)"
                }
            }
        },
        Tarot = {
            c_mul_lobotomized = {
                name = "The Lobotomized",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Normal Cards{}"
                }
            },
            c_mul_chair = {
                name = "The Chair",
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "card into a",
                    "{C:attention}Motivated Card{}"
                }
            },
            c_mul_apple = {
                name = "The Apple",
                text = {
                    "Plays the entire",
                    "{C:attention}Bad Apple{} video",
                    "for no benefit"
                }
            },
            c_mul_burger = {
                name = "The Burger",
                text = {
                    "Plays an animation",
                    "of a person with a",
                    "burger for {C:attention}1{} minute"
                }
            }
        },
        Other = {
            mul_transmutable = {
                name = "Transmutable",
                text = {
                    "Can use {C:attention}Philosopher's Stone{}",
                    "on this card to create",
                    "{C:mul_transmuted,E:1}Transmuted{} Jokers"
                }
            },
            mul_joker_hint = {
                name = "Hint",
                text = {
                    "Use a variety of",
                    "{C:tarot}Tarot{} cards"
                }
            },
            mul_villager_hint = {
                name = "Hint",
                text = {
                    "Get lots of {C:attention}Gold{},",
                    "{C:attention}Stone{} and {C:attention}Steel{}"
                }
            },
            mul_hammer_bro_hint = {
                name = "Hint",
                text = {
                    "Trigger this card",
                    "lots of times"
                }
            },
            mul_pareidolia_hint = {
                name = "Hint",
                text = {
                    "Play some unique",
                    "{C:attention}poker hands{}"
                }
            },
            undiscovered_mul_myth = {
                name = "Not Discovered",
                text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				}
            },
        },
        Mod = {
            Multiverse = {
                name = "Multiverse",
                text = {
                    "A {C:attention}conceptually crazy{} but {C:attention}mechanically balanced{} Balatro mod.",
                    "This mod contains new {C:attention}Jokers{}, {C:tarot}Tarots{}, {C:spectral}Spectrals{}, {C:attention}Blinds{}, {C:attention}card",
                    "{C:attention}enhancements{}, and {C:mul_transmuted}Myths{} (a new consumable type).",
                    "{C:mul_transmuted}Myth{} cards can help you obtain {C:mul_transmuted}Transmuted{} Jokers, which",
                    "can allow your runs to reach into high {C:attention}Antes{} in {C:attention}Endless Mode{} while",
                    "doing so in a way that feels {C:attention}relatively vanilla{} compared to other mods.",
                    "A {C:red}warning{} for those with {C:attention}Talisman{} installed:",
                    "I have not tested my mod with {C:attention}Talisman{} very much.",
                    "Considering that {C:attention}Talisman{} tends to cause lots of {C:red}crashes{}",
                    "due to how it represents numbers in its code, I do not expect",
                    "{C:mul_transmuted}Multiverse{} to play smoothly when {C:attention}Talisman{} is installed.",
                    "I am willing to make bugfixes regarding {C:attention}Talisman{} crashes",
                    "if {C:mul_transmuted}Multiverse{} is responsible for the crash, however these fixes",
                    "will most likely not be implemented until a {C:attention}future{} content update."
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_mul_transmuted = "Transmuted",
            k_mul_missed_bus = "Missed the bus!",
            k_mul_antimatter_init = "And so it begins...",
            k_mul_antimatter_grow1 = "More!",
            k_mul_antimatter_grow2 = "Even more!",
            k_mul_antimatter_grow3 = "Is this too much?",
            k_mul_antimatter_grow4 = "What have we done?",
            k_mul_popped = "Popped!",
            k_mul_won_fifty_fifty = "Won!",
            k_mul_lost_fifty_fifty = "Lost...",
            mul_stand_user = "Saved by Stand User via time reversal",
            k_mul_myth = "Myth",
            b_mul_myth_cards = "Myth Cards",
            b_mul_discord_server = "My Discord Server",
            b_mul_landing_page = "About Me",
            mul_page = "Page",
            mul_customization = "You can enable or disable certain aspects of Multiverse here",
            mul_changes_warn = "It is recommended to restart the game after making config changes",
            mul_changes_debug = "Debug Mode affects several elements of the mod",
            mul_changes_pool1 = "Enabling/disabling certain types of content affects",
            mul_changes_pool2 = "whether or not cards of those types can spawn",
            mul_music_customization1 = "Enable or disable certain songs that this mod uses",
            mul_music_customization2 = "Hover over the song details to see when the song plays",
            mul_debug = "Enable Debug Mode",
            mul_joke = "Enable Joke Content",
            ["mul_Prophecy"] = {
                "Plays when you have",
                "a Joker that has the",
                "{C:mul_transmuted}Transmutable{} sticker"
            },
            ["mul_Life Will Change"] = {
                "Plays when you",
                "have {C:attention}Ren Amamiya{}"
            },
            ["mul_Pigstep"] = {
                "Plays when you",
                "have {C:attention}Steve{}"
            },
            ["mul_Hammer of Justice"] = {
                "Plays when you",
                "have {C:attention}Gerson{}"
            },
            ["mul_Presage"] = {
                "Plays on {C:attention}Ante 8{}",
                "or higher"
            },
            ["mul_Sneaky Snitch"] = {
                "Plays when you",
                "have {C:attention}Waldo{}"
            },
            ["mul_Battle Against a True Hero"] = {
                "Plays when facing",
                "The Undying"
            }
        },
        labels = {
            mul_transmutable = "Transmutable",
            myth = "Myth",
            k_mul_transmuted = "Transmuted",
        }
    }
}