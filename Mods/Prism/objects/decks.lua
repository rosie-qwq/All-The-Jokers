SMODS.Atlas {
    key = 'prismdecks',
    path = "decks.png",
    px = 71,
    py = 95
}

function G.PRISM.Back(table)
	if table.dependency or table.dependency == nil then
		SMODS.Back(table)
	end
end

G.PRISM.Back({
	key = "purple", 
	atlas = "prismdecks",
	pos = {x = 2, y = 0},
    unlocked = false,
	apply = function(self)
		G.GAME.modifiers.purple_deck = true
	end,
    unlock_condition = {type = 'discover_amount', amount = 150}
})
local orig_can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
	if G.GAME.modifiers.purple_deck and G.GAME.current_round.discards_left < 1 and #G.hand.highlighted > 0 and
	(G.GAME.current_round.hands_left > 1 or G.GAME.current_round.discards_left > 1) then 
		e.config.colour = G.C.RED
        e.config.button = 'discard_cards_from_highlighted'
	elseif G.GAME.current_round.hands_left > 0 or G.GAME.current_round.discards_left > 1 then
		orig_can_discard(e)
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
	end
end
G.PRISM.Back({
	dependency = G.PRISM.config.myth_enabled,
	key = "ancient", 
	atlas = "prismdecks",
	pos = {x = 0, y = 0},
	config = { vouchers = { "v_prism_myth_merchant","v_prism_booster_box"}},
    unlocked = false,
    unlock_condition = {type = 'win_stake', stake=6}
})
G.PRISM.Back({
	key = "market", 
	atlas = "prismdecks",
	pos = {x = 1, y = 0},
	config = { vouchers = { "v_overstock_norm","v_reroll_surplus"}},
    unlocked = false,
    unlock_condition = {type = 'win_stake', stake=8}
})
