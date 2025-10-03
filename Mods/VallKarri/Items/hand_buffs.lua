local fakestart = Game.start_run
function Game:start_run(args)
    fakestart(self, args)
    G.GAME.buff_text = ""

    G.GAME.existing_buffs = vallkarri.hand_buffs
    G.GAME.buff_power = {}
    for name, _ in pairs(G.GAME.existing_buffs) do
        G.GAME.buff_power[name] = 0
    end
end

vallkarri.hand_buffs = {
    m_bonus = { title = "EXTRA", colour = G.C.CHIPS },
    m_mult = { title = "MULTI", colour = G.C.MULT },
    m_wild = { title = "WILD", colour = lerpcolour(G.C.RED, G.C.MONEY, 20) },
    m_gold = { title = "GILDED", colour = G.C.MONEY },
    m_lucky = { title = "CHANCE", colour = G.C.GREEN },
    m_glass = { title = "SHATTERED", colour = G.C.WHITE},
    m_steel = { title = "FORGED", colour = G.C.GREY},
    m_stone = { title = "CRACKED", colour = darken(G.C.GREY, 5)},
    m_cry_echo = { title = "ECHOING", colour = G.C.PURPLE},
    m_cry_light = { title = "GLOWING", colour = G.C.YELLOW },
    m_cry_abstract = { title = "ABSTRACTED", colour = G.C.CRY_ASCENDANT},
}

vallkarri.hand_buff_functions = {
    m_bonus = function(n) return { sound = "valk_buff_bonus", xchips = (1 + n) ^ 1.25 } end,
    m_mult = function(n) return { sound = "valk_buff_mult", xmult = (1 + n) ^ 1.25 } end,
    m_wild = function(n, cards)
        local t = vallkarri.get_hand_buff_functions()
        return SMODS.merge_effects({pseudorandom_element(t, "m_wild_buff")(n,cards),pseudorandom_element(t, "m_wild_buff")(n,cards),{sound = "valk_buff_wild", }}) 
    end,
    m_gold = function(n) return { sound = "valk_buff_gold", dollars = math.ceil((3 + n) ^ 1.1) } end,
    m_lucky = function(n)
        n = n + 1
        return {
            sound = "valk_buff_lucky", 
            chips = pseudorandom("chance", 1, n ^ 2),
            mult = pseudorandom("chance", 1, n ^ 2),
            xchips = pseudorandom("chance", 1, n^0.5),
            xmult = pseudorandom("chance", 1, n^0.5)
        }
    end,
    m_glass = function(n) return { sound = "valk_buff_glass", emult = (n + 1) ^ 1.15 } end,
    m_steel = function(n) return { sound = "valk_buff_steel", emult = (n + 3) ^ 1.05 } end,
    m_stone = function(n) return { echips = 1 + ((n ^ 0.7) / 2) } end,
}
function vallkarri.add_hand_buff(key, title, colour, scoring_func)
    vallkarri.hand_buffs[key] = { title = title, colour = colour}
    vallkarri.hand_buff_functions[key] = scoring_func
    if G and G.GAME then
        G.GAME.existing_buffs = vallkarri.hand_buffs
        G.GAME.buff_power[key] = 0
        
    end
end

local uhthook = update_hand_text
function update_hand_text(config, vals)
    uhthook(config, vals)
    
    local enhancements = {}
    for i, card in ipairs(#G.hand.highlighted > 0 and G.hand.highlighted or G.play.cards) do
        for key, enhancement in pairs(SMODS.get_enhancements(card)) do
            enhancements[#enhancements + 1] = key
        end
    end

    -- print(enhancements)
    -- if not (#enhancements > 0) then
    --     G.GAME.buff_text = ""
    --     return
    -- end

    local counts = {}
    for i, enh in ipairs(enhancements) do
        if G.GAME.existing_buffs[enh] then
            if not counts[enh] then
                counts[enh] = 1
            else
                counts[enh] = counts[enh] + 1
            end
        end
    end

    for name, pow in pairs(G.GAME.buff_power) do
        counts[name] = counts[name] and counts[name] + pow or pow
    end

    -- string is build like +NAME+2xNAME+3xNAME
    -- not in order of number
    local str = ""
    local colour = nil
    G.GAME.applied_buffs = {}
    G.GAME.buff_requirement = G.GAME.buff_requirement or 5
    for name, count in pairs(counts) do
        local pwr = count - (G.GAME.buff_requirement - 1)
        if pwr > 0 then
            str = str .. " + " .. ((pwr > 1) and (pwr .. "x") or "") .. G.GAME.existing_buffs[name].title
            G.GAME.applied_buffs[#G.GAME.applied_buffs + 1] = {
                power = pwr,
                effect = G.GAME.existing_buffs[name],
                key = name
            }
        end
    end

    for name, val in pairs(G.GAME.existing_buffs) do
        if counts[name] > 0 then
            colour = val.colour
        end
    end

    if not next(G.GAME.applied_buffs) then
        G.GAME.buff_text = ""
        return
    end

    if not colour then
        -- how did we get here?
        return
    end
    G.E_MANAGER:add_event(Event({ --Hello LocalThunk
        trigger = 'before',
        blockable = not config.immediate,
        delay = config.delay or 0.8,
        func = function()
            local old = G.GAME.buff_text
            G.GAME.buff_text = str
            if G.GAME.buff_text ~= old then
                G.HUD:get_UIE_by_ID("bufftext"):juice_up()
            end
            G.HUD:get_UIE_by_ID("bufftext").config.colour = colour
            return true
        end
    }))
end

local hudcopy = create_UIBox_HUD
function create_UIBox_HUD(force)
    local res = hudcopy()
    res.nodes[1].nodes[1].nodes[4].nodes[1].nodes[4] = {
        n = G.UIT.R,
        config = { align = "cm", minh = 0.5 },
        nodes = { {
            n = G.UIT.C,
            config = { align = "cm" },
            nodes = {
                { n = G.UIT.T, config = { id = "bufftext", ref_table = G.GAME, ref_value = "buff_text", scale = 0.3, colour = G.C.WHITE, shadow = true } },
            }
        } }
    }

    return res
end

function vallkarri.get_hand_buff_functions()
    -- this functions name is intentionally long and stupid
    return vallkarri.hand_buff_functions
end

SMODS.Sound {
    key = "buff_bonus",
    path = "chips.ogg", 
}

SMODS.Sound {
    key = "buff_mult",
    path = "mult.ogg", 
}

SMODS.Sound {
    key = "buff_wild",
    path = "wild.ogg", 
}

SMODS.Sound {
    key = "buff_glass",
    path = "glass.ogg", 
}

SMODS.Sound {
    key = "buff_steel",
    path = "steel.ogg", 
}

SMODS.Sound {
    key = "buff_gold",
    path = "gold.ogg", 
}

SMODS.Sound {
    key = "buff_lucky",
    path = "lucky.ogg", 
}