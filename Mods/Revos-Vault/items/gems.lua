--what the FUCK
--ok they work now :thumbs_up: (they fucking dont :^hauydtgqh4na ısd)

SMODS.ObjectType({ -- Do i need this? 
	key = "Gem",
})

SMODS.UndiscoveredSprite{ --Doesn't seem to work?
	key = "Gem",
	display_size = { w = 50, h = 50 },
	atlas = "gemss",
	pos = {x=0,y=3},
	no_overlay = true
}

RevosVault.Gem =
	SMODS.Voucher:extend({ --Voucher extend cause they work like vouchers + its easier to implement since vouchers already have calc support
		required_params = { "key" },
		display_size = { w = 50, h = 50 },
		set = "Gem",
		unlocked = true,
		discovered = true,
		cost = 6,
		config = {},
		pools = {	
			Gem = true,
		},
		set_card_type_badge = function(self, card, badges)
			badges[#badges + 1] = create_badge(localize("b_gem"), SMODS.Gradients["crv_gem"], G.C.WHITE, 1.2)
		end,
		class_prefix = "gem",
		apply_gem = function(self, card) end,
	})

--The gems
RevosVault.Gem({
	key = "exp",
	atlas = "gemss",
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 5,
		},
	},
	calculate = function(self, card, context)
		if context.setting_blind then
			print("a")
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
	end,
	update = function(self, card, context)
		if G and G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v:is_suit("Spades", true) or v:is_suit("Clubs", true) then
					if v.debuff then
						v:set_debuff(false)
					end
				end
			end
		end
	end,
})

RevosVault.Gem({
	key = "expe",
	atlas = "gemss",
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 2,
		},
	},
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
		if context.crv_easedollars and to_big(context.crv_easedollars) > to_big(0) and not crv.activated then
			crv.activated = true
			ease_dollars(context.crv_easedollars)
		end
		if crv.activated == true then
			local event
			event = Event({
				blockable = false,
				blocking = false,
				pause_force = true,
				no_delete = true,
				trigger = "after",
				delay = 1.2,
				timer = "UPTIME",
				func = function()
					event.start_timer = false
					crv.activated = false
				end,
			})
			G.E_MANAGER:add_event(event)
		end
	end,
})

RevosVault.Gem({
	key = "ruby",
	atlas = "gemss",
	pos = { x = 0, y = 3 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 0,
		},
	},
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
		if context.final_scoring_step then
			return {
				xmult = #G.jokers.cards,
			}
		end
	end,
})

RevosVault.Gem({
	key = "diamond",
	atlas = "gemss",
	pos = { x = 4, y = 0 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 5,
		},
	},
	calculate = function(self, card, context)
		if context.setting_blind then
			print("a")
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
	end,
	update = function(self, card, context)
		if G and G.playing_cards then
			for k, v in pairs(G.playing_cards) do
				if v:is_suit("Hearts", true) or v:is_suit("Diamonds", true) then
					if v.debuff then
						v:set_debuff(false)
					end
				end
			end
		end
	end,
})

RevosVault.Gem({
	key = "star_sapphire",
	atlas = "gemss",
	pos = { x = 0, y = 3 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 0,
		},
	},
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
		if context.joker_main then
			return {
				level_up = 1,
			}
		end
	end,
})

RevosVault.Gem({
	key = "obsidian",
	atlas = "gemss",
	pos = { x = 0, y = 3},
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 2,
            old_odds = 0
		},
	},
    calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
	end,
})


RevosVault.Gem({
	key = "angelite",
		atlas = "gemss",
	pos = { x = 0, y = 3 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 2,
            old_odds = 0
		},
	},
    calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
        if context.crv_joker_destroyed and context.crv_destroyedj then
            if pseudorandom("angelite") < 1 / 4 then 
                SMODS.add_card{
                    key = context.crv_destroyedj.config.center.key,
                }
            end
        end
	end,
})

RevosVault.Gem({
	key = "amethyst",
			atlas = "gemss",
	pos = { x = 2, y = 0 },
	config = {
		extra = {
			destroy_time = 0,
			destroy_time_max = 2,
		},
	},
	update = function(self, card, context) 
	if G.shop_jokers and G.shop_jokers.cards and card.area == G.vouchers then
		for _, v in pairs(G.shop_jokers.cards) do
			if not v.edition then
				v:juice_up()
				v:set_edition(poll_edition("gem_amethyst", nil, false, true))
			end
		end
	end
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			if card.ability.extra.destroy_time >= card.ability.extra.destroy_time_max then
				RevosVault.remove_gem(card.config.center.key)
			else
				card.ability.extra.destroy_time = card.ability.extra.destroy_time + 1
			end
		end
	end
})


--Ametrine - Played cards change suits 

--Adamite - something something with cards being destroyed

--