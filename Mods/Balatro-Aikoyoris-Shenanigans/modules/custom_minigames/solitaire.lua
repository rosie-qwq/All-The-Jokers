-- solitaire
AKYRS.SOL = {}

AKYRS.SOL.stockCardArea = nil -- the deck basically
AKYRS.SOL.wasteCardArea = nil -- the thing you get from draw pile
AKYRS.SOL.foundationArea1 = nil -- the part where you move aces to to win
AKYRS.SOL.foundationArea2 = nil
AKYRS.SOL.foundationArea3 = nil
AKYRS.SOL.foundationArea4 = nil
AKYRS.SOL.tableauArea1 = nil -- the triangular shaped shit
AKYRS.SOL.tableauArea2 = nil
AKYRS.SOL.tableauArea3 = nil
AKYRS.SOL.tableauArea4 = nil
AKYRS.SOL.tableauArea5 = nil
AKYRS.SOL.tableauArea6 = nil
AKYRS.SOL.tableauArea7 = nil
AKYRS.SOL.cardarea_initialized = false
AKYRS.SOL.cards_protos = {
    "H_2","H_3","H_4","H_5","H_6","H_7","H_8","H_9","H_T","H_J","H_Q","H_K","H_A",
    "C_2","C_3","C_4","C_5","C_6","C_7","C_8","C_9","C_T","C_J","C_Q","C_K","C_A",
    "D_2","D_3","D_4","D_5","D_6","D_7","D_8","D_9","D_T","D_J","D_Q","D_K","D_A",
    "S_2","S_3","S_4","S_5","S_6","S_7","S_8","S_9","S_T","S_J","S_Q","S_K","S_A",
}
AKYRS.SOL.playing_cards = {}
AKYRS.SOL.states = {
    INACTIVE = 0,
    INITIAL = 1,
    START_DRAW = 2,
    PLAY = 3,
    GAME_END = 4,
}
AKYRS.SOL.current_state = 0
AKYRS.SOL.card_area_priority = {
    "foundations", "tableau"
}
AKYRS.SOL.cardAreas = {
    stock = {

    },
    waste = {
        
    },
    foundations = {

    },
    tableau = {

    }
}

AKYRS.SOL.reset_card_areas = function()
    for i,areas in ipairs(AKYRS.SOL.cardAreas) do
        for j,anarea in ipairs(areas) do
            if anarea then
                anarea:remove()
            end
        end
    end
    AKYRS.SOL.cardAreas = {
        stock = {
    
        },
        waste = {
            
        },
        foundations = {
    
        },
        tableau = {
    
        }
    }
    AKYRS.SOL.cardarea_initialized = false
end


AKYRS.SOL.fill_stock_with_fresh_cards = function()
    if AKYRS.SOL.stockCardArea then
        local a = AKYRS.SOL.stockCardArea.T
        for i, proto in ipairs(AKYRS.SOL.cards_protos) do
            local card = SolitaireCard(a.X,a.Y,G.CARD_W,G.CARD_H, G.P_CARDS[proto], G.P_CENTERS['c_base'])
            card.sprite_facing = 'back'
            card.facing = 'back'
            card.states.release_on.can = true
            card.states.collide.can = true
            card.ability.akyrs_part_of_solitaire = true
            card.states.collide.can = false
            AKYRS.SOL.stockCardArea:emplace(card)
        end
        AKYRS.SOL.stockCardArea:shuffle(pseudoseed('aikoyorisoiltaires'..tostring(G.TIMERS.REAL)))
    end
end
AKYRS.SOL.initial_setup = function()
    G.E_MANAGER:clear_queue("akyrs_desc")
    AKYRS.SOL.current_state = AKYRS.SOL.states.START_DRAW
    if #AKYRS.SOL.cardAreas.tableau > 0 and AKYRS.SOL.stockCardArea then
        G.E_MANAGER:add_event(
            Event{
                trigger = "after",
                delay = 0.1,
                func = function ()
                    
                    for i, ca in ipairs(AKYRS.SOL.cardAreas.tableau) do
                        if not ca then return true end
                        AKYRS.SOL.draw_from_stock_to_tableau(i,i)
                    end
                    delay(0.01)
                    AKYRS.simple_event_add(
                        function ()
                            AKYRS.SOL.current_state = AKYRS.SOL.states.PLAY
                            return true
                        end, 0.1,"akyrs_desc"
                    )
                    return true
                end
            },"akyrs_desc"
        )
    end
end
AKYRS.SOL.draw_from_stock_to_tableau = function(tableau_no, amount)
    delay(0.01)
    if not AKYRS.SOL.cardAreas.tableau[tableau_no] or not AKYRS.SOL.stockCardArea or not AKYRS.SOL.cardAreas.tableau[tableau_no].cards or not AKYRS.SOL.stockCardArea.cards then return end
    for i=1, amount do
        AKYRS.draw_card(AKYRS.SOL.stockCardArea,AKYRS.SOL.cardAreas.tableau[tableau_no], i*100/amount, 'down', false, nil, 0.03, false, true, nil,nil, "back")
    end
    AKYRS.simple_event_add(
        function ()
            if not AKYRS.SOL.cardAreas.tableau[tableau_no] or not AKYRS.SOL.cardAreas.tableau[tableau_no].cards then return true end
                AKYRS.SOL.cardAreas.tableau[tableau_no]:align_cards()
            return true
        end, 0
    )
end
AKYRS.SOL.draw_from_stock_to_waste = function(amount)
    if not AKYRS.SOL.wasteCardArea or not AKYRS.SOL.stockCardArea or not AKYRS.SOL.wasteCardArea.cards or not AKYRS.SOL.stockCardArea.cards then return end
    for i=1, amount do
        AKYRS.draw_card(AKYRS.SOL.stockCardArea,AKYRS.SOL.wasteCardArea, i*100/amount, 'up', false, nil, 0)
    end
    AKYRS.simple_event_add(
        function ()
            AKYRS.SOL.wasteCardArea:align_cards()
            return true
        end, 0
    )
end

AKYRS.SOL.draw_from_waste_to_stock = function(amount)

    
    for i=1, amount do
    if not AKYRS.SOL.wasteCardArea or not AKYRS.SOL.stockCardArea or not AKYRS.SOL.wasteCardArea.cards or not AKYRS.SOL.stockCardArea.cards then return end
        AKYRS.draw_card(AKYRS.SOL.wasteCardArea,AKYRS.SOL.stockCardArea, i*100/amount, 'down', false, nil, 0.01)
    end
end


function AKYRS.SOL.initialize_card_area(cardarea, destroy)
    
    if cardarea == "stock" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.stockCardArea) end
        AKYRS.SOL.stockCardArea = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "deck"}
        
        table.insert(AKYRS.SOL.cardAreas.stock, AKYRS.SOL.stockCardArea)
        AKYRS.SOL.stockCardArea.states.click.can = true
        AKYRS.SOL.stockCardArea.states.hover.can = true
        AKYRS.SOL.stockCardArea.states.collide.can = true
        AKYRS.SOL.fill_stock_with_fresh_cards()
        return AKYRS.SOL.stockCardArea
    end

    if cardarea == "waste" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.wasteCardArea) end
        AKYRS.SOL.wasteCardArea = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "akyrs_solitaire_waste"}
        table.insert(AKYRS.SOL.cardAreas.waste, AKYRS.SOL.wasteCardArea)
        return AKYRS.SOL.wasteCardArea
    end
    
    if cardarea == "foundation1" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.foundationArea1) end
        AKYRS.SOL.foundationArea1 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "akyrs_solitaire_foundation", sol_emplace_func = AKYRS.SOL.foundation_check}
        table.insert(AKYRS.SOL.cardAreas.foundations, AKYRS.SOL.foundationArea1)
        
        return AKYRS.SOL.foundationArea1
    end
    if cardarea == "foundation2" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.foundationArea2) end
        AKYRS.SOL.foundationArea2 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "akyrs_solitaire_foundation", sol_emplace_func = AKYRS.SOL.foundation_check}
        table.insert(AKYRS.SOL.cardAreas.foundations, AKYRS.SOL.foundationArea2)
        return AKYRS.SOL.foundationArea2
    end
    if cardarea == "foundation3" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.foundationArea3) end
        AKYRS.SOL.foundationArea3 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "akyrs_solitaire_foundation", sol_emplace_func = AKYRS.SOL.foundation_check}
        table.insert(AKYRS.SOL.cardAreas.foundations, AKYRS.SOL.foundationArea3)
        return AKYRS.SOL.foundationArea3
    end
    if cardarea == "foundation4" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.foundationArea4) end
        AKYRS.SOL.foundationArea4 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H, type = "akyrs_solitaire_foundation", sol_emplace_func = AKYRS.SOL.foundation_check}
        table.insert(AKYRS.SOL.cardAreas.foundations, AKYRS.SOL.foundationArea4)
        return AKYRS.SOL.foundationArea4
    end

    if cardarea == "tableau1" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea1) end
        AKYRS.SOL.tableauArea1 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea1)
        return AKYRS.SOL.tableauArea1
    end
    if cardarea == "tableau2" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea2) end
        AKYRS.SOL.tableauArea2 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
        
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea2)
        return AKYRS.SOL.tableauArea2
    end
    if cardarea == "tableau3" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea3) end
        AKYRS.SOL.tableauArea3 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea3)
        return AKYRS.SOL.tableauArea3
    end
    if cardarea == "tableau4" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea4) end
        AKYRS.SOL.tableauArea4 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea4)
        return AKYRS.SOL.tableauArea4
    end
    if cardarea == "tableau5" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea5) end
        AKYRS.SOL.tableauArea5 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea5)
        return AKYRS.SOL.tableauArea5
    end
    if cardarea == "tableau6" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea6) end
        AKYRS.SOL.tableauArea6 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
            
        table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea6)
        return AKYRS.SOL.tableauArea6
    end
    if cardarea == "tableau7" then
        if destroy then AKYRS.destroy_existing_cards(AKYRS.SOL.tableauArea7) end
        AKYRS.SOL.tableauArea7 = 
            AKYRS.make_new_card_area{ w = G.CARD_W , h = G.CARD_H* 2.5, type = "akyrs_solitaire_tableau", sol_emplace_func = AKYRS.SOL.tableau_check, pile_drag = true}
            
            table.insert(AKYRS.SOL.cardAreas.tableau, AKYRS.SOL.tableauArea7)
        AKYRS.SOL.cardarea_initialized = true -- jank
        AKYRS.SOL.initial_setup()
        return AKYRS.SOL.tableauArea7
    end


end
-- hooks 

local solitaireCardAreaClickHook = CardArea.click
function CardArea:click()
    local c = solitaireCardAreaClickHook(self)
    if self == AKYRS.SOL.stockCardArea and #self.cards <= 0 and AKYRS.SOL.wasteCardArea then
        AKYRS.SOL.draw_from_waste_to_stock(#AKYRS.SOL.wasteCardArea.cards)
    end
    return c
end

G.FUNCS.akyrs_draw_from_waste_to_stock = function ()
    AKYRS.SOL.draw_from_waste_to_stock(#AKYRS.SOL.wasteCardArea.cards)
end

G.FUNCS.akyrs_draw_from_waste_to_stock = function ()
    AKYRS.SOL.draw_from_waste_to_stock(#AKYRS.SOL.wasteCardArea.cards)
end

G.FUNCS.akyrs_check_drag_target_active = function(e)
end

AKYRS.are_suits_opposite_colour = function(card1, card2)
    local red_suits = { "Hearts", "Diamonds" }
    local black_suits = { "Spades", "Clubs" }

    local is_red1 = AKYRS.is_in_table(red_suits, card1.base.suit)
    local is_red2 = AKYRS.is_in_table(red_suits, card2.base.suit)
    local is_black1 = AKYRS.is_in_table(black_suits, card1.base.suit)
    local is_black2 = AKYRS.is_in_table(black_suits, card2.base.suit)

    return (is_red1 and is_black2) or (is_black1 and is_red2)
end

function AKYRS.SOL.foundation_check(cardarea, card)
    if not card.ability.akyrs_part_of_solitaire then return false end
    if card.following_cards and #card.following_cards > 0 then return false end
    if #cardarea.cards == 0 and card.base.value == "Ace" then
        return true
    end
    local top_card = cardarea.cards[#cardarea.cards]
    if top_card and card.base.value ~= "Ace" and AKYRS.is_in_table(SMODS.Ranks[top_card.base.value].next, card.base.value) and 
    
        card.base.suit == top_card.base.suit then
        return true
    end
    return false
    
end
function AKYRS.SOL.tableau_check(cardarea, card)
    if not card.ability.akyrs_part_of_solitaire then return false end
    if #cardarea.cards == 0 and card.base.value == "King" then
        return true
    end
    local top_card = cardarea.cards[#cardarea.cards]
    --print(AKYRS.is_in_table(SMODS.Ranks[top_card.base.value].prev, card.base.value))
    if top_card and top_card.base.value ~= "Ace" and AKYRS.is_in_table(SMODS.Ranks[top_card.base.value].prev, card.base.value) and
    AKYRS.are_suits_opposite_colour(top_card, card) and card.base.suit ~= top_card.base.suit then
        return true
    end
    return false
    
end

function AKYRS.SOL.klondike_quick_stack(card)
    if card.following_cards then
        --print("yep definitely there is card following rn "..#card.following_cards)
    end
    
    
    if not card then return end
    if card.area.cards[#card.area.cards] ~= card then return end
    for _,ap in ipairs(AKYRS.SOL.card_area_priority) do
        for i, ca in ipairs(AKYRS.SOL.cardAreas[ap]) do
            if ca.config.akyrs_sol_emplace_func and ca.config.akyrs_sol_emplace_func(ca,card) and ca ~= card.area then
                card.following_cards = nil
                card:akyrs_calculate_following_cards(function(x) return x == card end)
                --print(card.following_cards and #card.following_cards or "fuck you")
                AKYRS.draw_card(card.area,ca,1,"down",nil,card,0.0)
                card.states.drag.can = false
                AKYRS.simple_event_add(
                    function()
                        card:akyrs_bring_following_cards(ca)
                        return true
                    end, 0
                )
                return
            end
        end
    end
end

function G.FUNCS.solitaire_state_update()

end