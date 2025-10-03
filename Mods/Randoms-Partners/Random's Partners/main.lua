RAND = {}
RAND.C = {}

RAND.compat = {
           partners = (SMODS.Mods['partner'] or {}).can_load or false,
           paperback = (SMODS.Mods['paperback'] or {}).can_load or false,
           MintysSillyMod = (SMODS.Mods['MintysSillyMod'] or {}).can_load or false,
           Bunco = (SMODS.Mods['Bunco'] or {}).can_load or false,
           SixSuits = (SMODS.Mods['SixSuits'] or {}).can_load or false,
           InkAndColor = (SMODS.Mods['InkAndColor'] or {}).can_load or false
}

if RAND.compat.partners then
SMODS.load_file("Items/partner.lua")()
end

--Paperback Mod atlas
SMODS.Atlas{
    key = "minipaper",
    px = 46,
    py = 58,
    path = "paperback.png"
}


if RAND.compat.paperback then
SMODS.load_file("Items/Paperback.lua")()
end


--Partner Mod atlas
SMODS.Atlas{
    key = "minijoke",
    px = 46,
    py = 58,
    path = "partners.png"
}

if RAND.compat.MintysSillyMod then
SMODS.load_file("Items/Minty.lua")()
end

--MintysSillyMod Mod atlas
SMODS.Atlas{
    key = "miniminty",
    px = 46,
    py = 58,
    path = "Minty.png"
}

if RAND.compat.Bunco then
SMODS.load_file("Items/Bunco.lua")()
end

--Bunco Mod atlas
SMODS.Atlas{
    key = "minibunco",
    px = 46,
    py = 58,
    path = "Bunco.png"
}

if RAND.compat.SixSuits then
SMODS.load_file("Items/SixSuits.lua")()
end

--SixSuits Mod atlas
SMODS.Atlas{
    key = "minisix",
    px = 46,
    py = 58,
    path = "SixSuits.png"
}

if RAND.compat.InkAndColor then
SMODS.load_file("Items/InkAndColor.lua")()
end

--InkAndColor Mod atlas
SMODS.Atlas{
    key = "miniink",
    px = 46,
    py = 58,
    path = "InkAndColor.png"
}




SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
})
