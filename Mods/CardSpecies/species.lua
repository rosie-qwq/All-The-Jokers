CardSpecies.SpecieClassification {
    key = "humanoid",
    species = { "Human", "Alien", "Furry" }
}

CardSpecies.SpecieClassification {
    key = "robot",
    species = { "Robot", "Machinery", "Android" }
}

CardSpecies.SpecieClassification {
    key = "animalistic",
    species = { "Cat", "Feline", "Dog", "Canine", "Fox", "Vulpine", "Horse", "Equine", "Sheep", "Goat", "Cow", "Bovine", "Therian" }
}


CardSpecies.SpecieClassification {
    key = "farm",
    species = { "Horse", "Pony", "Equine", "Sheep", "Goat", "Cow", "Bovine", "Farm Animal" }
}

CardSpecies.SpecieClassification {
    key = "hoofed",
    species = { "Horse", "Pony", "Equine", "Sheep", "Goat", "Cow", "Bovine" }
}


CardSpecies.SpecieClassification {
    key = "equine",
    species = { "Horse", "Pony", "Equine" }
}

CardSpecies.SpecieClassification {
    key = "bovine",
    species = { "Sheep", "Goat", "Cow", "Bovine" }
}



CardSpecies.SpecieClassification {
    key = "domestic",
    species = { "Cat", "Kitty", "Feline", "Dog", "Puppy", "Canine", "Domestic Animal" }
}

CardSpecies.SpecieClassification {
    key = "pawed",
    species = { "Cat", "Kitty", "Feline", "Dog", "Puppy", "Canine", "Fox", "Vulpine" }
}


CardSpecies.SpecieClassification {
    key = "feline",
    species = { "Cat", "Kitty", "Morphed Kitty", "Feline" }
}

CardSpecies.SpecieClassification {
    key = "canine",
    species = { "Dog", "Puppy", "Canine" }
}



CardSpecies.SpecieClassification {
    key = "any",
    species = { "Shapeshifter" }
}

CardSpecies.SpecieClassification {
    key = "all",
    species = { "Human", "Alien", "Furry", "Robot", "Machinery", "Android", "Cat", "Kitty", "Feline", "Dog", "Canine", "Fox", "Vulpine", "Horse", "Equine", "Sheep", "Goat", "Cow", "Bovine", "Therian", "Shapeless" }
}

CardSpecies.SpecieClassification {
    key = "none",
    species = { "Shapeless" }
}



CardSpecies.SpecieClassification {
    key = "trans",
    species = { "Morphed Kitty" }
}


CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Shapeless" },
    in_pool = function()
        return true
    end,
    key = "shapeless"
}

CardSpecies.Specie {
    colour = HEX("#FF0E0E"),
    text_colour = G.C.WHITE,
    specie_table = { "Human" },
    in_pool = function()
        return true
    end,
    key = "human"
}

CardSpecies.Specie {
    colour = HEX("#00D4D4"),
    text_colour = G.C.WHITE,
    specie_table = { "Alien" },
    in_pool = function()
        return true
    end,
    key = "alien"
}


CardSpecies.Specie {
    colour = HEX("#014995"),
    text_colour = G.C.WHITE,
    specie_table = { "Furry" },
    in_pool = function()
        return true
    end,
    key = "furry"
}

CardSpecies.Specie {
    colour = HEX("#014995"),
    text_colour = G.C.WHITE,
    specie_table = { "Feline", "Furry" },
    in_pool = function()
        return true
    end,
    key = "f_furry"
}

CardSpecies.Specie {
    colour = HEX("#014995"),
    text_colour = G.C.WHITE,
    specie_table = { "Canine", "Furry" },
    in_pool = function()
        return true
    end,
    key = "c_furry"
}

CardSpecies.Specie {
    colour = HEX("#014995"),
    text_colour = G.C.WHITE,
    specie_table = { "Vulpine", "Furry" },
    in_pool = function()
        return true
    end,
    key = "v_furry"
}

CardSpecies.Specie {
    colour = HEX("#014995"),
    text_colour = G.C.WHITE,
    specie_table = { "Equine", "Furry" },
    in_pool = function()
        return true
    end,
    key = "e_furry"
}


CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Android" },
    in_pool = function()
        return true
    end,
    key = "android"
}


CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Thing" },
    in_pool = function()
        return true
    end,
    key = "thing"
}


CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Robot" },
    in_pool = function()
        return true
    end,
    key = "robot"
}

CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Robot", "Thing" },
    in_pool = function()
        return true
    end,
    key = "robot_t"
}

CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Robot", "Machinery" },
    in_pool = function()
        return true
    end,
    key = "robot_mach"
}

CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Machinery" },
    in_pool = function()
        return true
    end,
    key = "mach"
}

CardSpecies.Specie {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    specie_table = { "Machinery", "Robot" },
    in_pool = function()
        return true
    end,
    key = "mach_robot"
}


CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Cat" },
    in_pool = function()
        return true
    end,
    key = "cat"
}

CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Kitty" },
    in_pool = function()
        return true
    end,
    key = "kitty"
}

CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Morphed Kitty" },
    in_pool = function()
        return true
    end,
    key = "m_kitty"
}

CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Feline" },
    in_pool = function()
        return true
    end,
    key = "feline"
}

CardSpecies.Specie {
    colour = HEX("#D0A15A"),
    text_colour = G.C.WHITE,
    specie_table = { "Cat", "Dog"},
    in_pool = function()
        return true
    end,
    key = "cat_dog"
}

CardSpecies.Specie {
    colour = HEX("#EC8E4A"),
    text_colour = G.C.WHITE,
    specie_table = { "Cat", "Fox"},
    in_pool = function()
        return true
    end,
    key = "cat_fox"
}

CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Feline", "Thing" },
    in_pool = function()
        return true
    end,
    key = "feline_t"
}


CardSpecies.Specie {
    colour = HEX("#A17133"),
    text_colour = G.C.WHITE,
    specie_table = { "Dog" },
    in_pool = function()
        return true
    end,
    key = "dog"
}

CardSpecies.Specie {
    colour = HEX("#A17133"),
    text_colour = G.C.WHITE,
    specie_table = { "Canine" },
    in_pool = function()
        return true
    end,
    key = "canine"
}

CardSpecies.Specie {
    colour = HEX("#D0A15A"),
    text_colour = G.C.WHITE,
    specie_table = { "Dog", "Cat" },
    in_pool = function()
        return true
    end,
    key = "dog_cat"
}

CardSpecies.Specie {
    colour = HEX("#B95913"),
    text_colour = G.C.WHITE,
    specie_table = { "Dog", "Fox" },
    in_pool = function()
        return true
    end,
    key = "dog_fox"
}

CardSpecies.Specie {
    colour = HEX("#A17133"),
    text_colour = G.C.WHITE,
    specie_table = { "Canine", "Thing" },
    in_pool = function()
        return true
    end,
    key = "canine_t"
}


CardSpecies.Specie {
    colour = HEX("#C96115"),
    text_colour = G.C.WHITE,
    specie_table = { "Fox" },
    in_pool = function()
        return true
    end,
    key = "fox"
}

CardSpecies.Specie {
    colour = HEX("#C96115"),
    text_colour = G.C.WHITE,
    specie_table = { "Vulpine" },
    in_pool = function()
        return true
    end,
    key = "vulpine"
}

CardSpecies.Specie {
    colour = HEX("#EC8E4A"),
    text_colour = G.C.WHITE,
    specie_table = { "Fox", "Cat" },
    in_pool = function()
        return true
    end,
    key = "fox_cat"
}

CardSpecies.Specie {
    colour = HEX("#B95913"),
    text_colour = G.C.WHITE,
    specie_table = { "Fox", "Dog" },
    in_pool = function()
        return true
    end,
    key = "fox_dog"
}

CardSpecies.Specie {
    colour = HEX("#C96115"),
    text_colour = G.C.WHITE,
    specie_table = { "Vulpine", "Thing" },
    in_pool = function()
        return true
    end,
    key = "vulpine_t"
}


CardSpecies.Specie {
    colour = HEX("#212121"),
    text_colour = G.C.WHITE,
    specie_table = { "Horse" },
    in_pool = function()
        return true
    end,
    key = "horse"
}

CardSpecies.Specie {
    colour = HEX("#212121"),
    text_colour = G.C.WHITE,
    specie_table = { "Equine" },
    in_pool = function()
        return true
    end,
    key = "equine"
}

CardSpecies.Specie {
    colour = HEX("#212121"),
    text_colour = G.C.WHITE,
    specie_table = { "Equine", "Thing" },
    in_pool = function()
        return true
    end,
    key = "equine_t"
}


CardSpecies.Specie {
    colour = HEX("#FFBE47"),
    text_colour = G.C.BLACK,
    specie_table = { "Feline", "Therian" },
    in_pool = function()
        return true
    end,
    key = "feline_ther"
}

CardSpecies.Specie {
    colour = HEX("#A17133"),
    text_colour = G.C.WHITE,
    specie_table = { "Canine", "Therian" },
    in_pool = function()
        return true
    end,
    key = "canine_ther"
}

CardSpecies.Specie {
    colour = HEX("#C96115"),
    text_colour = G.C.WHITE,
    specie_table = { "Vulpine", "Therian" },
    in_pool = function()
        return true
    end,
    key = "vulpine_ther"
}

CardSpecies.Specie {
    colour = HEX("#212121"),
    text_colour = G.C.WHITE,
    specie_table = { "Equine", "Therian" },
    in_pool = function()
        return true
    end,
    key = "equine_ther"
}


CardSpecies.Specie {
    colour = G.C.WHITE,
    text_colour = G.C.BLACK,
    specie_table = { "Shapeshifter"},
    in_pool = function()
        return true
    end,
    key = "shape"
}