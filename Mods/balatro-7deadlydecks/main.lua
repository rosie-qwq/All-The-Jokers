-- Mod Icon
SMODS.Atlas{
    key = 'modicon',
    path = 'icon.png',
    px = 26,
    py = 26
}

----------------------------------------------
--------------CUSTOM JOKERS-------------------

SMODS.Atlas{
    key = "7DD_Jokers",
    path = "7DD_Jokers.png",
    px = 71,
    py = 95
}

-- Greed Joker

SMODS.Joker{
    key = 'greed',
    loc_txt = {
        name = 'Greed',
        text = {
            'Multiplies {C:mult}Mult{} based on how',
            'much {C:money}Money{} you have.',
            '{C:inactive}(Currently{} {X:mult,C:white}X#1#{}{C:inactive}){}'
        },

        unlock = {
            'Play with the',
            '{C:money}Deck of Greed{}',
            'at least once.'
        }
    },

    atlas = '7DD_Jokers',
    pos = {x = 0, y = 0},

    rarity = 3,
    blueprint_compat = false,
    brainstorm_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    config = { extra = {
        Xmult = 1
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.Xmult}}
    end,

    update = function(self, card, dt)
        -- Calculate the multiplier
        card.ability.extra.Xmult = G.GAME.dollars / 100

    end,

    calculate = function(self, card, context)

        -- Prevent Blueprint from triggering the Joker
        if context.joker_main and not context.blueprint then
            
            -- $100 = 1x mult. $80 = 0.8x mult.
            local mult = (G.GAME.dollars + (G.GAME.dollar_buffer or 0)) / 100

            return {
                card = card,
                Xmult_mod = mult,
                message = 'X' .. tostring(mult),
                colour = G.C.MULT
            }
        end
    end
}

-- Lust Joker

SMODS.Joker{
    key = 'lust',
    loc_txt = {
        name = 'Lust',
        text = {
            'This Joker gains {C:mult}+#1#{} Mult',
            'per {C:hearts}Heart{} card played.',
            'All non-{C:hearts}Heart{} cards',
            'are {C:red}debuffed{}.',
            '{s:0.8}Stone Card excluded.{}',
            '{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}'
        },

        unlock = {
            'Play with the',
            '{C:hearts}Deck of Lust{}',
            'at least once.'
        }
    },

    atlas = '7DD_Jokers',
    pos = {x = 1, y = 0},

    rarity = 3,
    blueprint_compat = true,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    config = { extra = {
        multAdd = 3,
        mult = 0
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.multAdd, center.ability.extra.mult}}
    end,

    calculate = function(self, card, context)

        if context.before and not context.blueprint then

            for _, pCard in ipairs(G.playing_cards) do

                -- Debuff all non-Heart cards, except for Stone Cards
                if pCard.base.suit ~= 'Hearts' and pCard.ability.effect ~= 'Stone Card' then
                    SMODS.debuff_card(pCard, true, 'lust')
                end
    
            end
        end

        if context.joker_main then

            -- Increment mult for each played Heart card
            for _, pCard in ipairs(context.scoring_hand) do
                if pCard.base.suit == 'Hearts' then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multAdd
                end
            end

            -- Add mult
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. tostring(card.ability.extra.mult),
                colour = G.C.MULT
            }
        end

    end,
}

-- Gluttony Joker

SMODS.Joker{
    key = 'gluttony',
    loc_txt = {
        name = 'Gluttony',
        text = {
            'Before every other {C:attention}played hand{},',
            '{C:red}Destroy{} one random card',
            'held in hand and gain',
            '{C:mult}+#1#{} Mult per card',
            '{C:inactive,s:0.8}Does not consume when no cards in hand.{}',
            '{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}'
        },

        unlock = {
            'Play with the',
            '{C:attention}Deck of Gluttony{}',
            'at least once.'
        }
    },

    config = { extra = {
        multAdd = 3,
        mult = 0,
        extra = {
            consume = false
        }
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.multAdd, center.ability.extra.mult}}
    end,

    atlas = '7DD_Jokers',
    pos = {x = 2, y = 0},

    rarity = 3,
    blueprint_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        
        -- Consume card if flag is set
        if card.ability.extra.consume and context.before then

            -- Only consume if more than 1 card in deck and in hand
            if #G.playing_cards > 1 and #G.hand.cards > 0 then

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function ()
                        
                        -- Get random card from hand
                        local dCard = pseudorandom_element(G.hand.cards, pseudoseed('gluttony'))
                        
                        -- Destroy card
                        dCard:start_dissolve()
                        
                        return true
                    end
                }))
                
                -- Increase mult
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multAdd

                -- Display message
                return {
                    message = 'Consumed Card',
                    colour = G.C.RED
                }
 
             end
        end

        -- Inverse flag
        card.ability.extra.consume = not card.ability.extra.consume

        if context.joker_main and not context.blueprint then

            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. tostring(card.ability.extra.mult),
                colour = G.C.MULT
            }

        end

    end
}

-- Envy Joker

SMODS.Joker{
    key = 'envy',
    loc_txt = {
        name = 'Envy',
        text = {
            'After each {C:attention}played hand{},',
            'replace the {C:attention}lowest rank card{}',
            'in your hand with the',
            '{C:attention}highest rank card{}',
        },

        unlock = {
            'Play with the',
            '{C:green}Deck of Envy{}',
            'at least once.'
        }
    },

    atlas = '7DD_Jokers',
    pos = {x = 3, y = 0},

    rarity = 3,
    blueprint_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        
        if context.after and not context.blueprint then
            
            -- Get lowest and highest cards
            local lCard = nil
            local hCard = nil
            local highest = 0
            local lowest = 14

            for _, pCard in ipairs(G.hand.cards) do
                
                -- Get highest
                if pCard:get_id() >= highest then
                    
                    hCard = pCard
                    highest = pCard:get_id()

                end

                -- Get lowest
                if pCard:get_id() <= lowest then

                    lCard = pCard
                    lowest = pCard:get_id()

                end

            end


            -- Convert the lowest card into the highest card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function ()
                    
                    lCard:juice_up()
                    copy_card(hCard, lCard)

                    return true
                end
            }))

            return {
                message = 'Converted',
                colour = G.C.GREEN
            }

        end

    end
}

-- Wrath Joker

SMODS.Joker{
    key = 'wrath',
    loc_txt = {
        name = 'Wrath',
        text = {
            'Adds or subtracts',
            'between {C:attention}1{} and {C:attention}#1#{}',
            '{C:chips}Chips{} or {C:mult}Mult{}',
            '{C:inactive}Does not go negative or zero{}'
        },

        unlock = {
            'Play with the',
            '{C:red}Deck of Wrath{}',
            'at least once.'
        }
    },

    config = { extra = {
        aMax = 30
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.extra.aMax}}
    end,

    atlas = '7DD_Jokers',
    pos = {x = 4, y = 0},

    rarity = 3,
    blueprint_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        
        if context.joker_main and not context.blueprint then
            
            -- Get which value to change
            local value = pseudorandom_element({'C', 'M'}, pseudoseed('wrath'))

            if value == 'C' then
                -- Chips

                -- Get the amount to change. Stay within bounds
                local lBound = math.max(-1 * (hand_chips - 1), -card.ability.extra.aMax)
                local uBound = card.ability.extra.aMax

                local amount = math.random(lBound, uBound)
                local sign = ''

                if amount < 0 then
                    sign = '-'
                else
                    sign = '+'
                end

                return {
                    message = sign .. tostring(math.abs(amount)) .. ' Chips',
                    colour = G.C.CHIPS,
                    chip_mod = amount
                }

            elseif value == 'M' then
                -- Mult

                -- Get the amount to change. Stay within bounds
                local lBound = math.max(-1 * (mult - 1), -card.ability.extra.aMax)
                local uBound = card.ability.extra.aMax

                local amount = math.random(lBound, uBound)
                local sign = ''

                if amount < 0 then
                    sign = '-'
                else
                    sign = '+'
                end

                return {
                    message = sign .. tostring(math.abs(amount)) .. ' Mult',
                    colour = G.C.MULT,
                    mult_mod = amount
                }

            end

        end

    end
}

-- Sloth Joker

SMODS.Joker{
    key = 'sloth',
    loc_txt = {
        name = 'Sloth',
        text = {
            'When a hand is played,',
            '{C:green}#1# in #2#{} chance for',
            'the hand to {C:attention}not score{},',
            'and gain {X:mult,C:white}X#3#{} Mult.',
            'Chance increases by {C:attention}#5#{}',
            'every {C:attention}scored hand{}.',
            '{X:mult,C:white}Xmult{} decreases over time.',
            '{C:inactive}(Currently{} {X:mult,C:white}X#4#{} {C:inactive}Mult){}'
        },

        unlock = {
            'Play with the',
            '{C:blue}Deck of Sloth{}',
            'at least once.'
        }
    },

    config = { extra = {
        MaxOdds = 100,
        odds = 2,
        XmultGain = 2,
        Xmult = 1,
        XmultDec = 0.1,
        oddsInc = 5,
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {
            G.GAME and G.GAME.probabilities.normal or 1,
            center.ability.extra.odds,
            center.ability.extra.XmultGain,
            center.ability.extra.Xmult,
            center.ability.extra.oddsInc,
        }}
    end,

    atlas = '7DD_Jokers',
    pos = {x = 5, y = 0},

    rarity = 3,
    blueprint_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        
        if context.joker_main and not context.blueprint then
            
            -- Run probabilities
            local roll = pseudorandom('sloth')

            if roll < G.GAME.probabilities.normal/card.ability.extra.odds then
                
                -- Hand does not score
                hand_chips = 0
                mult = 0

                -- Reset odds
                card.ability.extra.odds = card.ability.extra.MaxOdds

                -- Increase mult
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.XmultGain

                return {
                    message = 'Zzz...',
                    colour = G.C.FILTER,
                    card = card,
                }

            else

                -- Hand scores. Increase odds. Dont go pass 1/1
                if card.ability.extra.odds > card.ability.extra.oddsInc then
                    card.ability.extra.odds = card.ability.extra.odds - card.ability.extra.oddsInc
                end

                -- Get mult to score before decrease
                local Xmult = card.ability.extra.Xmult

                -- Decrease mult. Dont go pass X1
                if card.ability.extra.Xmult > 1 then
                    card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.XmultDec
                end

                return {
                    message = 'X' .. tostring(Xmult),
                    colour = G.C.MULT,
                    card = card,
                    Xmult_mod = Xmult
                }

            end

        end

    end
}

-- Pride Joker

SMODS.Joker{
    key = 'pride',
    loc_txt = {
        name = 'Pride',
        text = {
            '{C:green}#1# in #2#{} chance for',
            '{X:chips,C:white}X#3#{} Chips,',
            '{X:mult,C:white}X#4#{} Mult,',
            'or {X:dark_edition,C:white}X#5#{} Chips and Mult',
        },

        unlock = {
            'Play with the',
            '{C:gold}Deck of Pride{}',
            'at least once.'
        }
    },

    config = { extra = {
        odds = 4,
        Xchips = 0.75,
        Xmult = 0.75,
        Xboth = 2,
    }},

    loc_vars = function(self, info_queue, center)
        return {vars = {
            G.GAME and G.GAME.probabilities.normal or 1,
            center.ability.extra.odds,
            center.ability.extra.Xchips,
            center.ability.extra.Xmult,
            center.ability.extra.Xboth
        }}
    end,

    atlas = '7DD_Jokers',
    pos = {x = 6, y = 0},

    rarity = 3,
    blueprint_compat = false,

    unlocked = false,
    discovered = false,

    in_pool = function(self)
        return false
    end,

    calculate = function(self, card, context)
        
        if context.joker_main and not context.blueprint then
            
            -- Run probabilities
            local roll = pseudorandom('pride')

            if roll < G.GAME.probabilities.normal/card.ability.extra.odds then
                
                -- Choose a random effect
                local effect = math.random(1, 3)

                if effect == 1 then

                    -- Chips
                    local Xchips_mod = (hand_chips * card.ability.extra.Xchips) - hand_chips

                    return {
                        message = 'I don\'t need those chips!',
                        colour = G.C.CHIPS,
                        card = card,
                        chip_mod = Xchips_mod
                    }

                elseif effect == 2 then
                    
                    -- Mult
                    return {
                        message = 'Who needs mult? I don\'t!',
                        colour = G.C.MULT,
                        card = card,
                        Xmult_mod = card.ability.extra.Xmult
                    }

                elseif effect == 3 then

                    -- Both
                    local Xchips_mod = (hand_chips * card.ability.extra.Xboth) - hand_chips

                    return {
                        message = 'I\'m the best!',
                        colour = G.C.DARK_EDITION,
                        card = card,
                        chip_mod = Xchips_mod,
                        Xmult_mod = card.ability.extra.Xboth
                    }

                end

            else

                -- No effects

            end

        end

    end
}

----------------------------------------------
-----------------DECKS-------------------------

SMODS.Atlas{
    key = '7DD_Decks',
    path = '7DD_Decks.png',
    px = 71,
    py = 95
}

--- Greed Deck

GREED_DECK = SMODS.Back{
    name = 'Deck of Greed',
    key = 'greed',
    atlas = '7DD_Decks',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Deck of Greed',
        text = {
            'Start with {C:money}$100{},',
            'All cards are {C:gold,T:m_gold}Gold{}',
            'Start with a',
            '{C:money}greedy Joker{}.'
        },
    },
    apply = function ()

        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Set starting money to $100
                G.GAME.dollars = 100

                -- Add Greedy Joker and Midas Mask
                greed = {
                    key = 'j_7dd_greed',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(greed)

                for _, card in ipairs(G.playing_cards) do

                    -- Set every card to Gold with Gold seal
                    card:set_ability(G.P_CENTERS.m_gold, nil, true)
                    card:set_seal('Gold', true, true)

                end

                local money_mult_ref = money_mult
                function money_mult(context)
                    context = context or {}

                    -- $100 = 1x mult. $800 = 0.8x mult.
                    local mult = G.GAME.dollars / 100

                    -- Multiply mult at end of round
                    if context.end_of_round then
                        G.GAME.mult = G.GAME.mult * mult
                    end

                    return money_mult_ref(context)
                end

                return true
            end
        }))
    end
}

-- Lust Deck

LUST_DECK = SMODS.Back{
    name = 'Deck of Lust',
    key = 'lust',
    atlas = '7DD_Decks',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = 'Deck of Lust',
        text = {
            'Deck has {C:attention}52{} {C:hearts}Hearts{}',
            'Start with a',
            '{C:red}lustful Joker{}.'
        },
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()
                
                -- Set all cards to Hearts
                for _, card in ipairs(G.playing_cards) do
                    if card.base.suit ~= 'Hearts' then
                        
                        assert(SMODS.change_base(card, 'Hearts'))

                    end
                end

                -- Add eternal Lust Joker
                lust = {
                    key = 'j_7dd_lust',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(lust)

                return true
            end
        }))
    end,
}

-- Gluttony Deck

GLUTTONY_DECK = SMODS.Back{
    name = 'Deck of Gluttony',
    key = 'gluttony',
    atlas = '7DD_Decks',
    pos = {x = 2, y = 0},
    loc_txt = {
        name = 'Deck of Gluttony',
        text = {
            '{C:attention}+2{} hand size',
            'Start with a',
            '{C:attention}very hungry Joker{}.',
        },
    },

    config = {
        hand_size = 2
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add eternal Gluttony Joker
                gluttony = {
                    key = 'j_7dd_gluttony',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(gluttony)

                return true
            end
        }))
    end,

}

-- Envy Deck

ENVY_DECK = SMODS.Back{
    name = 'Deck of Envy',
    key = 'envy',
    atlas = '7DD_Decks',
    pos = {x = 3, y = 0},
    loc_txt = {
        name = 'Deck of Envy',
        text = {
            '{C:red}+2{} discards',
            'Start with an',
            '{C:green}envious Joker{}.',
        },
    },

    config = {
        discards = 2
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add eternal Envy Joker
                envy = {
                    key = 'j_7dd_envy',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(envy)

                return true
            end
        }))
    end,
}

-- Wrath Deck

WRATH_DECK = SMODS.Back{
    name = 'Deck of Wrath',
    key = 'wrath',
    atlas = '7DD_Decks',
    pos = {x = 4, y = 0},
    loc_txt = {
        name = 'Deck of Wrath',
        text = {
            '{C:blue}+2{} hands',
            'Start with a',
            '{C:red}wrathful Joker{}.',
        },
    },

    config = {
        hands = 2
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add eternal Wrath Joker
                wrath = {
                    key = 'j_7dd_wrath',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(wrath)

                return true
            end
        }))
    end,
}

-- Sloth Deck

SLOTH_DECK = SMODS.Back{
    name = 'Deck of Sloth',
    key = 'sloth',
    atlas = '7DD_Decks',
    pos = {x = 5, y = 0},
    loc_txt = {
        name = 'Deck of Sloth',
        text = {
            '{C:blue}+1{} hands,',
            'Start with a',
            '{C:blue}sleepy Joker{}'
        },
    },

    config = {
        hands = 1,
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add eternal Sloth Joker
                sloth = {
                    key = 'j_7dd_sloth',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(sloth)

                return true
            end
        }))
    end,
}

-- Pride Deck

PRIDE_DECK = SMODS.Back{
    name = 'Deck of Pride',
    key = 'pride',
    atlas = '7DD_Decks',
    pos = {x = 6, y = 0},
    loc_txt = {
        name = 'Deck of Pride',
        text = {
            'Start with {C:attention}Money Seed{},',
            '{C:attention}Director\'s Cut{}, and a',
            '{C:gold}prideful Joker{}.',
        },
    },

    config = {
        vouchers = {
            'v_seed_money',
            'v_directors_cut',
        }
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add eternal Pride Joker
                pride = {
                    key = 'j_7dd_pride',
                    set = 'Joker',
                    stickers = {'eternal'},
                }

                SMODS.add_card(pride)

                return true
            end
        }))
    end,
}

----------------------------------------------
--------------CARD SLEEVES--------------------

-- Load Card Sleeves if mod is installed
if CardSleeves then
    SMODS.load_file('cardsleeves.lua')()
end