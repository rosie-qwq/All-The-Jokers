SMODS.Consumable {
    key = "soully",
    set = "Silly",
    atlas = "Consumables",
    pos = {x = 0, y = 2 },
    soul_pos = { x = 2, y = 2,
        draw = function(card, scale_mod, rotate_mod)
            local _scale_mod = 0.08 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.03*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*11)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local _rotate_mod = 0.2*math.sin(1.219*G.TIMERS.REAL) + 0.10*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            card.children.floating_sprite.role.draw_major = card
            card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center, _scale_mod, _rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, _scale_mod, _rotate_mod)
        end,
    },
    cost = 10,
    hidden = true,
    soul_set = "Spectral",
    use = function(self, card, context, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local key = LR_UTIL.get_fmod_legendaries('soully')
            play_sound('timpani')
            SMODS.add_card({set = 'Joker', area = G.jokers, key = key})
            return true end }))
        delay(0.6)
    end,
    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
            return true
        else
            return false
        end
    end
}