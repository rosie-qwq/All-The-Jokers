SMODS.Enhancement {
    key = "mirrored",
    loc_txt = {
        name = "Mirrored",
        text = {
            "Copies the {C:attention}Suit, Rank{} and {C:attention}Modifications{}",
            "of the card to the right",
            "{C:inactive}(Can replace self){}",
            credit("mailingway")
        },
    },
    atlas = "main",
    pos = {x = 10, y = 3},
    config = { immutable = { counter = 5 } },
    update = function(self, card, dt)
        if card.ability.immutable and card.ability.immutable.counter and card.ability.immutable.counter <= 0 then
            
            -- print("running")
            
            if (not card.area) or (card.area ~= G.play and card.area ~= G.hand) then --must be in hand or play to work
                return
            end

            -- print("area exists")

            local right_card = card.area.cards[find_index(card, card.area.cards) + 1]
            if not right_card then
                return
            end

            -- print("right card exists")

            local enh = SMODS.get_enhancements(right_card)


            if (right_card.base.suit ~= card.base.suit) or (right_card.base.value ~= card.base.value) then
                SMODS.change_base(card, right_card.base.suit, right_card.base.value)
            end
            
            if card.seal ~= right_card.seal then
                card.seal = right_card.seal
            end
            if card.edition ~= right_card.edition then
                card.edition = right_card.edition
            end
            
            if enh and not enh["m_valk_mirrored"] and next(enh) then
                card:set_ability(next(enh))
            end
        else
            card.ability.immutable = card.ability.immutable or {counter = 10}
            card.ability.immutable.counter = card.ability.immutable.counter - 1  
        end
    end
}
