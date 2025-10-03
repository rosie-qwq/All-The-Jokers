-- Some of this code was "borrowed" from Cryptid and Pokermon mods

if not Wraith then
	Wraith = {}
end

local mod_path = "" .. SMODS.current_mod.path
Wraith.path = mod_path
Wraith_config = SMODS.current_mod.config

---- ATLAS STUFF ----
SMODS.Atlas {
	key = "joke_one",
	px = 71,
	py = 95,
	path = "joke_one.png"
}

SMODS.Atlas({
	key = "modicon",
	path = "wrt_icon.png",
	px = 34,
	py = 34
})

---- JOKERS ----
local jokers = {
	themoon = {
		key = "themoon",
		name = "wrt-The Moon",
		
		unlocked = false,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = false,
		perishable_compat = true,
		
		atlas = "joke_one",
		config = {extra = {min = 1, odds = 2}},
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 0, y = 0},
		soul_pos = {x = 1, y = 0},
		rarity = 4,
		cost = 22,
		
		loc_vars = function(self, info_queue, card)
			card.ability.extra.min = (G.GAME and G.GAME.probabilities.normal or 1)
		
			return {vars = {card.ability.extra.min, card.ability.extra.odds}}
		end,
			
		calculate = function(self, card, context)
			if self.debuff then return nil end
			
			if 
				context.using_consumeable
				and context.consumeable.ability.set == "Planet"
				and not context.consumeable.beginning_end
			then
				-- Safely get the hand level
				local hand_type = context.consumeable.ability.hand_type
				local hand_data = G.GAME.hands[hand_type]
				
				-- Check if hand_data exists and has a level that's less than 101
				if hand_data and hand_data.level and type(hand_data.level) == 'number' and hand_data.level < 101 then
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						if pseudorandom('wrt_themoon') < G.GAME.probabilities.normal/card.ability.extra.odds then
							G.E_MANAGER:add_event(Event({
								func = function()
									local cards = copy_card(context.consumeable)
									cards:add_to_deck()
									G.consumeables:emplace(cards)
									return true
								end,
							}))
							card_eval_status_text(
								context.blueprint_cards or card,
								"extra",
								nil,
								nil,    
								nil,
								{ message = "Copied!" }
							)
						end
					end
				end
			end
		end
	},
	
	wraithJ = {
		key = "wraithJ",
		name = "wrt-Wraith",
		
		unlocked = true,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = true,
		perishable_compat = true,
		
		atlas = "joke_one",
		config = {extra = {mult = 1, extra = 3}},
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 3, y = 0},
		rarity = 2,
		cost = 6,
		
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra.mult, card.ability.extra.extra}}
		end,
		
		calculate = function(self, card, context)
			if context.joker_main and (to_big(card.ability.extra.mult) > to_big(1)) then
				return {
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = { number_format(card.ability.extra.mult) },
					}),
					mult_mod = lenient_bignum(card.ability.extra.mult),
				}
			elseif
				context.selling_card
				and not context.blueprint
			then
				card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.mult) + card.ability.extra.extra)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = {number_format(card.ability.extra.extra)},
					}),
				})
				return nil, true
			end
			if context.forcetrigger then
				card.ability.extra.mult = lenient_bignum(to_big(card.ability.extra.x_mult) + card.ability.extra.extra)
				return {
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = {number_format(card.ability.extra.extra)},
					}),
					mult_mod = lenient_bignum(card.ability.extra.mult),
				}
			end
		end,
	},
	
	vouchJok = {
		key = "vouchJok",
		name = "wrt-Voucher Joker",
		
		unlocked = true,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = false,
		perishable_compat = true,
		
		atlas = "joke_one",
		config = {extra = {slot = 1}},
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 2, y = 0},
		rarity = 2,
		cost = 6,
		
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra.slot}}
		end,
		
		add_to_deck = function(self, card, from_debuff)
			card.ability.extra.slot = math.floor(card.ability.extra.slot)
			local mod = card.ability.extra.slot
			SMODS.change_voucher_limit(mod)
		end,
		
		remove_from_deck = function(self, card, from_debuff)
			card.ability.extra.slot = math.floor(card.ability.extra.slot)
			local mod = card.ability.extra.slot
			SMODS.change_voucher_limit(-mod)
		end,
	},
	
	nothJok = {
		key = "nothJok",
		name = "wrt-Nothing",
		
		unlocked = true,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = false,
		perishable_compat = false,
		
		atlas = "joke_one",
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 4, y = 0},
		rarity = 1,
		cost = -3,
	},
	
	smhJok = {
		key = "smhJok",
		name = "wrt-Something",
		
		unlocked = true,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = false,
		perishable_compat = false,
		joker_gate = "wrt-Nothing",
		
		atlas = "joke_one",
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 0, y = 1},
		rarity = 1,
		cost = 4,
		
		config = {
			extra = {
				Xmult = 1.5,
				type = "High Card",
			},
		},
		
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra.Xmult}}
		end,
		
		calculate = function(self, card, context)
			if
				(context.joker_main and context.poker_hands and next(context.poker_hands[card.ability.extra.type]))
				or context.forcetrigger
			then
				return {
					message = localize({
						type = "variable",
						key = "a_xmult",
						vars = { number_format(card.ability.extra.Xmult)},
					}),
					colour = G.C.RED,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end,
		
		in_pool = function(self)
			return #find_joker("wrt-Nothing", true) ~= 0
		end,
	},
	
	fallSun = {
		key = "fallSun",
		name = "wrt-Falling Sun",
		
		unlocked = false,
		discovered = false,
		eternal_compat = true,
		blueprint_compat = true,
		perishable_compat = true,
		
		atlas = "joke_one",
		--vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds},
		pos = {x = 1, y = 1},
		rarity = 3,
		cost = 9,
		
		config = {
			extra = {
				Xmult = 4,
				cards = 6,
				varcar = 5
			},
		},
		
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra.varcar, card.ability.extra.Xmult}}
		end,
		
		calculate = function(self, card, context)
			if
				context.cardarea == G.jokers and context.joker_main
				or context.forcetrigger
			then
				if #context.scoring_hand >= card.ability.extra.cards then
					return {
						message = localize({
							type = "variable",
							key = "a_xmult",
							vars = {number_format(card.ability.extra.Xmult)},
						}),
						colour = G.C.RED,
						Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
					}
				end
			end
		end,
		
		check_for_unlock = function(self, args)
			if args.type == "hand_contents" then
				if #args.cards >= 6 then
					unlock_card(self)
				end
			end
			if args.type == "cry_lock_all" then
				lock_card(self)
			end
			if args.type == "cry_unlock_all" then
				unlock_card(self)
			end
		end,
	},
}

---- FUNCTIONS----
local function create_joker(joker)
	--[[atlas = joker.atlas
	
	if joker.rarity == 4 then
		soul_pos = joker.soul_pos
	end

    if joker.vars == nil then joker.vars = {} end

    joker.config = {extra = {}}

    for _, kv_pair in ipairs(joker.vars) do
        local k, v = next(kv_pair)
        joker.config.extra[k] = v
    end

    -- Joker creation

    SMODS.Joker {
        name = joker.name,
        key = joker.key,

        atlas = atlas,
		
        pos = joker.pos,
		soul_pos = soul_pos,

        rarity = joker.rarity,
        cost = joker.cost,

        unlocked = joker.unlocked,
        check_for_unlock = joker.check_for_unlock,
        unlock_condition = joker.unlock_condition,
        discovered = joker.discovered,

        blueprint_compat = joker.blueprint,
        eternal_compat = joker.eternal,
        perishable_compat = joker.perishable,
		
        config = joker.config,
		
		loc_vars = function(self, info_queue, card)
			return {vars = joker.vars}
		end,
		
        loc_txt = joker.loc_txt,

        calculate = joker.calculate,
        update = joker.update,
	}]]
	
	SMODS.Joker(joker)
end

-- load decks
local back, load_error = SMODS.load_file("items/deck.lua")

if load_error then
	sendDebugMessage ("The error is: "..load_error)
else
	sendDebugMessage("Loading file deck.lua")
	local cur_back = back()
	
	for i, item in ipairs(cur_back.items) do
		SMODS.Back(item)
	end
end

-- load other jokers
local joker, load_error = SMODS.load_file("items/misc_joker.lua")

if load_error then
	sendDebugMessage ("The error is: "..load_error)
else
	sendDebugMessage("Loading file misc_joker.lua")
	local cur_file = joker()
	
	for i, item in ipairs(cur_file.items) do
		SMODS.Joker(item)
	end
end

-- load jokers
for k, v in pairs(jokers) do
	create_joker(v)
	
	--print("[WRAITH] Loading " .. v.loc_txt.name)
end