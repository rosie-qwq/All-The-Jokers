

local constellations = {
    "ara", "crux", "indus", "puppis", "lacerta", "eridanus", "reticulum","horologium","telescopium","microscopium"
}

function AKYRS.get_hand_in_game(_c)
    return (G.GAME and 
    G.GAME.hands and 
    _c.ability and 
    _c.ability.hand_type and 
    G.GAME.hands[_c.ability.hand_type]) 
    and G.GAME.hands[_c.ability.hand_type] or nil
end

local to_number = to_number or function(x) return x end

for i, k in ipairs(constellations) do
    local raw_hand =  (i+2).."-letter Word"
    local hand =  AKYRS.prefix.."_"..raw_hand
    if k == "microscopium" then
        break
    end
    
    SMODS.Planet{
        atlas = "aikoConstellationCards",
        pos = { x = i-1 , y=0},
        key = "p_"..k,
        config = {
            hand_type = hand,
            softlock = true
        },
        set_card_type_badge = function(self, card, badges)
            badges[1] = create_badge(localize('k_akyrs_constellation'), get_type_colour(self or card.config, card), nil, 1.2)
        end,
        loc_vars = function (self,iq,_c)
            local level = AKYRS.get_hand_in_game(_c) and AKYRS.get_hand_in_game(_c).level or 1
            local handlevelcol = G.C.HAND_LEVELS[math.min(7, level)]
            if Talisman then
                handlevelcol = G.C.HAND_LEVELS[math.min(7, to_number(level))]
            end
            return {
                vars = {
                    level,
                    localize(hand, 'poker_hands') or "???", 
                    SMODS.PokerHands[hand].l_mult or 1, 
                    SMODS.PokerHands[hand].l_chips or 1,
                    colours = {
                        (to_number(level) == 1 and 
                        G.C.UI.TEXT_DARK or 
                        handlevelcol)
                    }
                },
            }
        end,
        
        calculate = function(self, card, context)
            if G.GAME.used_vouchers.v_observatory
                and context.joker_main
                and (
                    context.scoring_name == hand
                )
            then
                local value = G.P_CENTERS.v_observatory.config.extra
                return {
                    Xmult = value,
                }
            end
        end,
        in_pool = function(self, args)
            return (G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled) and true or false
        end,

    }
end

local hands_multi = {}
local hands_multi_rev = {}
for i = 12 ,31 do
    table.insert(hands_multi,AKYRS.prefix.."_"..(i).."-letter Word")
    hands_multi_rev[AKYRS.prefix.."_"..(i).."-letter Word"] = true
end

SMODS.Planet{
    atlas = "aikoConstellationCards",
    pos = { x = 9 , y=0},
    key = "p_microscopium",
    config = {
        akyrs_hand_types = hands_multi,
        softlock = true
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_akyrs_constellation'), get_type_colour(self or card.config, card), nil, 1.2)
    end,
    loc_vars = function (self,iq,_c)
        local level = AKYRS.get_hand_in_game(_c) and AKYRS.get_hand_in_game(_c).level or 1
        return {
            vars = {
                localize(hands_multi[1], 'poker_hands') or "???", 
            },
        }
    end,
    use = function (self,card,area,copier)
        AKYRS.silent_bulk_level_up(self, card, area, copier, 1)
    end,

    can_use = function(self, card) return true end,
    calculate = function(self, card, context)
        if G.GAME.used_vouchers.v_observatory
            and context.joker_main
            and (
                hands_multi_rev[context.scoring_name]
            )
        then
            local value = G.P_CENTERS.v_observatory.config.extra
            return {
                Xmult = value,
            }
        end
    end,
    in_pool = function(self, args)
        return (G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled) and true or false
    end,

}


