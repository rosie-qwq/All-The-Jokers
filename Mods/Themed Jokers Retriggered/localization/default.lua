return {
    descriptions={
        Back={
            b_tjr_ca_battlefield={
                name = "Combat Ace Deck",
                text = {
                    "Join the {C:attention}Combat Aces{}",
                    "on the battlefield.",
                    "Start with {C:attention}The Contract{}",
                    "and {C:attention}Recruiter{}"
                }                               
            },
            b_tjr_ju_fossil={
                name = "Jurassic Deck",
                text = {
                    "Jurassic Dinosaurs rise again.",
                    "Start with {C:attention}The Amber{}",
                    "and an{C:attention} Dinosaur Egg{}."
                }                               
            },
            b_tjr_in_outbreak={
                name = "Infected Deck",
                text = {
                    "The {C:attention}Infected{}",
                    "are on the loose.",
                    "Start with a {C:green}The Blight{}",
                    "and {C:green}Mutation{}."
                }                               
            }
        },
        Enhanced={
            m_tjr_infected={
                name = "Infected Card",
                text = {
                    "Spreads {C:green}Infection{}.",
                    "{X:chips,C:white}X#1#{} Chips while this card stays in hand",
                    "when {C:green}Infected Poker Hand{} is played.",
                    "{X:chips,C:white}X#2#{} Chips when this card stays in hand",
                    "when any other Poker Hand is played."
                }                               
            }
        },
        Blind={
            bl_tjr_ca_desertation={
                name = "The Deserter",
                text = {
                    "All {C:attention}Aces{} are",
                    "debuffed."
                }                               
            }
        },
        Spectral={
            c_tjr_in_miasma={
                name = "Miasma",
                text = {
                    "Spreads {C:green}Infection{} to 5 random cards in deck."
                }
            },
            c_tjr_ju_extinction={
                name = "Extinction",
                text = {
                    "Turn one {C:attention}Jurassic Dinosaur{} into its {C:attention}Fossil{}"
                }
            },
            c_tjr_ss_vessel={
                name = "Vessel",
                text = {
                    "Converts up to 5 random cards",
                    "into the most common suit in deck.",
                    "{C:inactive}(Currently {C:#1#}#1#{}){}"
                }
            }
        },
        Tarot={
            c_tjr_in_blight={
                name = "The Blight",
                text = {
                    "Creates a random {C:green}Infected{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"

                }
            },
            c_tjr_ca_contract={
                name = "The Contract",
                text = {
                    "Creates a random {C:attention}Combat Ace{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"

                }
            },
            c_tjr_ju_amber={
                name = "The Amber",
                text = {
                    "Creates a random {C:attention}Jurassic{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"

                }
            },
            c_tjr_mc_mischief={
                name = "The Mischief",
                text = {
                    "Creates a random {C:attention}Mischief{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"

                }
            },
            c_tjr_ss_devotion_spades={
                name = "The Devotee",
                text = {
                    "Creates a random {C:spades}Sacred Suit{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            c_tjr_ss_devotion_hearts={
                name = "The Devotee",
                text = {
                    "Creates a random {C:hearts}Sacred Suit{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            c_tjr_ss_devotion_clubs={
                name = "The Devotee",
                text = {
                    "Creates a random {C:clubs}Sacred Suit{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            c_tjr_ss_devotion_diamonds={
                name = "The Devotee",
                text = {
                    "Creates a random {C:diamonds}Sacred Suit{} {C:attention}Joker{}",
                    "{C:inactive}(Must have room){}"
                }
            }
        },
        Joker={
            j_tjr_ca_soldier={
                name = "Soldier",
                text = {
                    "Played {C:attention}Aces{} each",			
                    "give {C:chips}+#1#{} Chips",
                    "when scored."
                }                               
            },
            j_tjr_ca_supplies={
                name = "Supplies",
                text = {
                    "For every {C:red}3 discarded{} ",			
                    "{C:attention}Aces{} get {C:money}$#1#{}.",
                    "+{C:money}$1{} every time it activates",
                    "{C:inactive}(Next supply drop in: #2#)"
                }                  
            },
            j_tjr_ca_mercenary={
                name = "Mercenary",
                text = {
                    "Played {C:attention}Aces{} each give",
                    "{X:mult,C:white} X#1# {} Mult. At the",
                    "end of Round pay {C:money}$#2#{}",
                    "If unable to pay, destroy this Joker."                    
                }    
            },
            j_tjr_ca_promotion={
                name = "Promotion",
                text = {
                    "Played {C:attention}Aces{} have a",
                    "{C:green}#1# in #2#{} chance to",
                    "become a random edition"
                }    
            },
            j_tjr_ca_recruiter={
                name = "Recruiter",
                text = {
                    "{C:red}Discarded cards{} have a",
                    "{C:green}#1# in #2#{} chance to",
                    "become an {C:attention}Ace{}"
                }    
            },
            j_tjr_ca_general={
                name = "General",
                text = {
                    "{X:mult,C:white} X#1# {} Mult for each",
                    "remaining {C:attention}Ace{} in Deck",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {} {C:inactive}Mult){}"
                }    
            },
            j_tjr_ca_veteran={
                name = "Veteran",
                text = {
                    "Each {C:attention}Ace{}",
                    "held in hand",
                    "gives {X:mult,C:white} X#1# {} Mult"
                }    
            },
            j_tjr_ju_quetzalcoatlus={
                name = "Quetzalcoatlus",
                text = {
                    "Retrigger each played",
                    "{C:attention}Ace{} and {C:attention}Stone Card{}.",
                    "{C:green}#1# in #2#{} chance to go extinct",
                    "at the end of round."
                }                               
            },
            j_tjr_ju_trex={
                name = "T-Rex",
                text = {
                    "Every played {C:attention}King{}",
                    "and {C:attention}Stone Card{} permanently",
                    "gains {C:chips}+#1# Chips{} and {C:mult}+#2# Mult{}",
                    "when scored.",
                    "{C:green}#3# in #4#{} chance to go extinct",
                    "at the end of round."
                }                               
            },
            j_tjr_ju_mosasaurus={
                name = "Mosasaurus",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "for every scored {C:attention}Queen{}",
                    "and {C:attention}Stone Card{}.",
                    "{C:green}#3# in #4#{} chance to go extinct",
                    "at the end of round.",
                    "{C:inactive}(Currently {C:chips}+#2#{} {C:inactive}Chips){}"
                }                               
            },
            j_tjr_ju_brachiosaurus={
                name = "Brachiosaurus",
                text = {
                    "Gives {C:mult}#1#{} Mult for each {C:attention}Jack{} and",
                    "{C:attention}Stone Card{} in your full deck.",
                    "{C:green}#3# in #4#{} chance to go extinct",
                    "at the end of round.",
                    "{C:inactive}(Currently {C:mult}#2# {} {C:inactive}Mult){}"
                }                               
            },
            j_tjr_ju_fossil_quetz={
                name = "Fossil",
                text = {
                    "Played {C:attention}Aces{} and {C:attention}Stone Cards{}",
                    "each give {X:mult,C:white} X#1# {} Mult when scored"
                }                               
            },
            j_tjr_ju_fossil_rex={
                name = "Fossil",
                text = {
                    "Played {C:attention}Kings{} and {C:attention}Stone Cards{}",
                    "each give {X:mult,C:white} X#1# {} Mult when scored"
                }                               
            },
            j_tjr_ju_fossil_mosa={
                name = "Fossil",
                text = {
                    "Played {C:attention}Queens{} and {C:attention}Stone Cards{}",
                    "each give {X:mult,C:white} X#1# {} Mult when scored"
                }                               
            },
            j_tjr_ju_fossil_brachio={
                name = "Fossil",
                text = {
                    "Played {C:attention}Jacks{} and {C:attention}Stone Cards{}",
                    "each give {X:mult,C:white} X#1# {} Mult when scored"
                }                               
            },
            j_tjr_ju_paleontologist={
                name = "Paleontologist",
                text = {
                    "{C:attention}Stone Card{} held",
                    "in Hand gives {X:mult,C:white} X#1# {} Mult"
                }                               
            },
            j_tjr_ju_excavation={
                name = "Excavation",
                text = {
                    "If first hand of round has",
                    "no {C:attention}Stone Cards{}, all played cards",
                    "become {C:attention}Stone Cards{}."
                }                               
            },
            j_tjr_ju_museum={
                name = "Museum",
                text = {
                    "Earn {C:money}$#1#{} for each {C:attention}Stone Card{}",
                    "in your full deck at the end of round",
                    "{C:inactive}(Currently {C:money}$#2#{}{C:inactive}){}"
                }                               
            },
            j_tjr_ju_dinosauregg = {
                name = "Dinosaur Egg",
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "hatches into a random {C:attention}Dinosaur{}",
                    "or a {C:attention}Fossilized Egg{}.",
                    "{C:inactive}(#2#/#1#){}"
                }
            },
            j_tjr_ju_fossil_egg = {
                name = "Fossilized Egg",
                text = {
                    "Played {C:attention}Stone Cards{}",
                    "each give {C:money}$#1#{} when scored."
                }
            },
            j_tjr_in_mutation={
                name = "Mutation",
                text = {
                    "{C:green}Infected Cards{}",
                    "give {X:mult,C:white}X#1#{} Mult",
                    "when scored"
                }
            },
            j_tjr_in_potency={
                name = "Potency",
                text = {
                    "Upgrades level of played",
                    "{C:green}Infected Poker Hand{}",
                }
            },
            j_tjr_in_joker={
                name = "Infected Joker",
                text = {
                    "Spreads {C:green}Infection{}",
                    "to a random card in deck",
                    "when {C:attention}Blind{} is selected."
                }
            },
            j_tjr_in_contaigon={
                name = "Contagion",
                text = {
                    "{C:green}Infection{} also spreads",
                    "{C:attention}Seals{} and {C:attention}Editions",
                }
            },
            j_tjr_in_swarm={
                name = "Swarm",
                text = {
                    "Retrigger all",
                    "{C:green}Infected Cards{}"
                }
            },
            j_tjr_in_plaguedoctor={
                name = "Plague Doctor",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult.",
                    "for each {C:green}Infected Card{}",
                    "in your full deck",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_in_corruptedjoker={
                name = "Corrupted Joker",
                text = {
                    "Played {C:green}Infected Cards{}",
                    "give {C:mult}+#1#{} Mult",
                    "when scored"
                }
            },
            j_tjr_in_superspreadder={
                name = "Super Spreader",
                text = {
                   "Played {C:green}Infected Cards{}",
                   "have a {C:green}#1# in #2#{} chance to",
                   "{C:green}Spread{} when scored"
                }
            },
            j_tjr_in_pulcinella={
                name = "Pulcinella",
                text = {
                    "When you play an {C:green}Infected Poker Hand{},",
                    "retrigger it once for each",
                    "{C:green}Infected Card{} held in hand"
                }
            },
            j_tjr_mc_piece1={
                name = "Piece of The Mischievous One",
                text = {
                    "???",
                    "{C:inactive}(#1#/4){}"
                }
            },
            j_tjr_mc_piece2={
                name = "Piece of The Mischievous One",
                text = {
                    "???",
                    "{C:inactive}(#1#/4){}"
                }
            },
            j_tjr_mc_piece3={
                name = "Piece of The Mischievous One",
                text = {
                    "???",
                    "{C:inactive}(#1#/4){}"
                }
            },
            j_tjr_mc_piece4={
                name = "Piece of The Mischievous One",
                text = {
                    "???",
                    "{C:inactive}(#1#/4){}"
                }
            },
            j_tjr_mc_cultist={
                name = "Mischievous Cultist",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult",
                    "for each collected {C:attention}Piece of The Mischievous One{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_mc_jimbo={
                name = "Jimbo, the Mischievous One",
                text = {
                  "Gives {X:mult,C:white}X#1#{} Mult.",
                  "Played cards either permanently gain",
                  "{C:chips}+#2#{} Chips, {C:mult}+#3#{} Mult,",
                  "{C:money}$#4#{} or nothing when scored."
                }
            },
            j_tjr_ss_shaman_spades={
                name = "Shaman of Spades",
                text = {
                    "{C:green}#2# in #3#{} chance to change",
                    "the suit of played cards to {C:spades}#1#{}",
                    
                }
            },
            j_tjr_ss_druid_diamonds={
                name = "Druid of Diamonds",
                text = {
                    "{C:green}#2# in #3#{} chance to change",
                    "the suit of played cards to {C:diamonds}#1#{}"
                }
            },
            j_tjr_ss_monk_clubs={
                name = "Monk of Clubs",
                text = {
                    "{C:green}#2# in #3#{} chance to change",
                    "the suit of played cards to {C:clubs}#1#{}"
                }
            },
            j_tjr_ss_priest_hearts={
                name = "Priest of Hearts",
                text = {
                    "{C:green}#2# in #3#{} chance to change",
                    "the suit of played cards to {C:hearts}#1#{}"
                }
            },
            j_tjr_ss_cathedral={
                name = "Cathedral",
                text = {
                    "{X:mult,C:white}x#1#{} Mult for every {C:hearts}Heart{}",
                    "in full deck if played hand is",
                    "a {C:hearts}Hearts Flush{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_ss_monastery={
                name = "Monastery",
                text = {
                    "{X:mult,C:white}x#1#{} Mult for every {C:clubs}Club{}",
                    "in full deck if played hand is",
                    "a {C:clubs}Clubs Flush{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_ss_bone_temple={
                name = "Bone Temple",
                text = {
                    "{X:mult,C:white}x#1#{} Mult for every {C:spades}Spade{}",
                    "in full deck if played hand is",
                    "a {C:spades}Spades Flush{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_ss_stone_circle={
                name = "Stone Circle",
                text = {
                    "{X:mult,C:white}x#1#{} Mult for every {C:diamonds}Diamond{}",
                    "in full deck if played hand is",
                    "a {C:diamonds}Diamonds Flush{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                }
            },
            j_tjr_ss_staff_diamonds={
                name = "Staff of Diamonds",
                text = {
                    "Scored {C:diamonds}Diamonds{} gain",
                    "{C:chips}+#1#{} Chips permanently",
                    "Held {C:diamonds}Diamonds{} gain",
                    "{C:mult}+#2#{} Mult permanently"
                }
            },
            j_tjr_ss_rosary_hearts={
                name = "Rosary of Hearts",
                text = {
                    "Scored {C:hearts}Hearts{} gain",
                    "{C:mult}+#1#{} Mult permanently",
                    "Held {C:hearts}Hearts{} gain",
                    "{C:chips}+#2#{} Chips permanently"
                }
            },
            j_tjr_ss_dagger_spades={
                name = "Dagger of Spades",
                text = {
                    "Scored {C:spades}Spades{} gain",
                    "{C:chips}+#1#{} Chips permanently",
                    "Held {C:spades}Spades{} gain",
                    "{C:chips}+#2#{} Chips permanently"
                }
            },
            j_tjr_ss_mala_clubs={
                name = "Mala of Clubs",
                text = {
                    "Scored {C:clubs}Clubs{} gain",
                    "{C:mult}+#1#{} Mult permanently",
                    "Held {C:clubs}Clubs{} gain",
                    "{C:mult}+#2#{} Mult permanently"
                }
            },
            j_tjr_ss_aspect_passion={
                name = "Aspect of Passion",
                text = {
                    "Retrigger all {C:hearts}Hearts{}",
                    "{C:attention}#1#{} additional times"
                }
            },
            j_tjr_ss_aspect_balance={
                name = "Aspect of Balance",
                text = {
                    "Retrigger all {C:clubs}Clubs{}",
                    "{C:attention}#1#{} additional times"
                }
            },
            j_tjr_ss_aspect_silence={
                name = "Aspect of Silence",
                text = {
                    "Retrigger all {C:spades}Spades{}",
                    "{C:attention}#1#{} additional times"
                }
            },
            j_tjr_ss_aspect_growth={
                name = "Aspect of Growth",
                text = {
                    "Retrigger all {C:diamonds}Diamonds{}",
                    "{C:attention}#1#{} additional times"
                }
            }
        },
        Voucher={
            v_tjr_mc_awakening = {
                name = "Mischievous Awakening",
                text = {                  
                    "{C:attention}The Mischievous One{}",
                    "walks the earth again.",
                    "Pray you can survive what you have called forth."
                }
            },
            v_tjr_mc_ritual={
                name = "Mischievous Ritual",
                text = {
                    "Starts the Mischievous Ritual.",
                    "{C:attention}Pieces of The Mischievous One{}",
                    "can be found in most {C:attention}Booster Packs{}."
                }
            }
        },
        Other={
            tt_dinosauregg_fossil = {
                name = "Fossilized Egg",
                text = {
                    "Earn {C:money}Money{} for each",
                    "scored {C:attention}Stone Card{}"
                }
            },
            tt_trex = {
                name = "T-Rex",
                text = {
                    "{C:attention}Kings{} and {C:attention}Stone Cards{} gain",
                    "permanent {C:chips}Chips{} and {C:mult}Mult{}"
                }
            },
            tt_mosasaurus = {
                name = "Mosasaurus",
                text = {
                    "Gains {C:chips}Chips{} for {C:attention}Queens{} and",
                    "{C:attention}Stone Cards{} when scored"
                }
            },
            tt_brachiosaurus = {
                name = "Brachiosaurus",
                text = {
                    "{C:mult}Mult{} for {C:attention}Jacks{} and {C:attention}Stone Cards{}",
                    "in your deck"
                }
            },
            tt_quetzalcoatlus = {
                name = "Quetzalcoatlus",
                text = {
                    "Retriggers {C:attention}Aces{} and {C:attention}Stone Cards{}",
                    "when scored"
                }
            },

            tt_infection = {
                name = "Infection",
                text = {
                    "Turns a random card",
                    "in remaining deck into",
                    "an {C:green}Infected Card{} if held",
                    "at the end of round."
                 }
             },

             tt_infected_pokerhand = {
                name = "Infected Poker Hand",
                text = {
                    "{C:green}Patient Zero{} - 1 Infected Card",
                    "{C:green}Outbreak{} - 2 Infected Cards",
                    "{C:green}Epidemic{} - 3 Infected Cards",
                    "{C:green}Plague{} - 4 Infected Cards",
                    "{C:green}Global Pandemic{} - 5 Infected Cards"
                }
             }
        }
    },
    misc={
        dictionary = {
                    k_badge_ca = "Combat Ace",
        k_badge_infected = "Infected",
        k_badge_jurassic = "Jurassic",
        k_badge_mischief = "Mischief",
        k_badge_sacred_suits = "Sacred Suits",
            k_supplies_up = "+ Supplies!",
            k_supplydrop = "Supply drop!",
            k_mercenary_destroy = "Ciao!",
            k_mercenary_pay = "Payday!",
            k_promotion_success = "Promotion!",
            k_recruiter_success = "Recruited!",
            k_debuffed = "Debuffed!",
            k_extinction = "Extinction!",
            k_safe_ex = "Survived!",
            k_upgrade_ex = "Upgraded!",
            k_excavation_complete = "Excavation complete!",
            k_museum_earnings = "Museum earnings!",
            k_mosasaurus_chips = "Upgraded!",
            k_dinosauregg_hatch = "Hatched!",
            k_infected_spread = "It's spreading!",
            k_potency_level_up = "Potency up!",
            k_mischief_piece_add = "Piece collected!",
            k_wololo = "Wololo!",
        },

        poker_hand_descriptions = {
            ["tjr_patient_zero"] = {
                "1 Infected Card"
            },
            ["tjr_outbreak"] = {
                "2 Infected Cards"
            },
            ["tjr_epidemic"] = {
                "3 Infected Cards"
            },
            ["tjr_plague"] = {
                "4 Infected Cards"
            },
            ["tjr_global_pandemic"] = {
                "5 Infected Cards"
            },
        },
        poker_hands = {
            ["tjr_patient_zero"] = "Patient Zero",
            ["tjr_outbreak"] = "Outbreak",
            ["tjr_epidemic"] = "Epidemic",
            ["tjr_plague"] = "Plague",
            ["tjr_global_pandemic"] = "Global Pandemic",
        },


    }
}