--- STEAMODDED HEADER
--- MOD_NAME: kaliimoddy
--- MOD_ID: kaliimoddy
--- MOD_AUTHOR: [kaliicappy]
--- MOD_DESCRIPTION: follow @kaliicappy on twitter
--- PREFIX: kali
-----------------------------------------------
---------------MOD CODE------------------------

--dud seal
SMODS.Sound({key = "dudsfx", path = "dudsfx.ogg"})

SMODS.Atlas {
    key = "dud_seal",
    path = "TheDudSeal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "dud_seal",
    key = "dud_seal",
    badge_colour = HEX("dba91f"),
	config = { mult = 1, chips = 10, },
    loc_txt = {
        -- Badge name (displayed on card description when seal is applied)
        label = 'The Dud Seal',
        -- Tooltip description
        name = 'The Dud Seal',
        text = {
            '{C:mult}+#1#{} Mult',
            '{C:chips}+#2#{} Chips',
        }
    },


    sound = { sound = 'kaliimoddy_dudsfx', per = 1},

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips,} }
    end,
    atlas = "dud_seal",
    pos = {x=0, y=0},

    -- self - this seal prototype
    -- card - card this seal is applied to
    calculate = function(self, card, context)
        -- main_scoring context is used whenever the card is scored
        
        local _dudcounter = 0
        local _dudcounter2 = 0

        if G.hand.highlighted[1] then
            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i].seal == "kaliimoddy_dud_seal" then _dudcounter = _dudcounter + 1 end
            end
        end
        
        if G.play.cards[1] then
            for i = 1, #G.play.cards do
                if G.play.cards[i].seal == "kaliimoddy_dud_seal" then _dudcounter2 = _dudcounter2 + 1 end
            end
        end

        if _dudcounter >= 5 or _dudcounter2 >= 5 then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            blocking = false,
            blockable = false,
            delay = 0.7,
            func = function()
                G.GAME.current_round.current_hand.handname = "Dream Date"
                if G.GAME.current_round.current_hand.handname == "Dream Date" then return true end
            end
            }))
        end

        if context.main_scoring and context.cardarea == G.play then
            if string.find(G.GAME.current_round.current_hand.handname,"Dream Date") then end
            return {
                G.E_MANAGER:add_event(Event({func = function()
                play_sound('kaliimoddy_dudsfx')
                return true end })),
                
                message = "Dud!",
                mult = self.config.mult,
                chips = self.config.chips
            }
        end
    end,
}