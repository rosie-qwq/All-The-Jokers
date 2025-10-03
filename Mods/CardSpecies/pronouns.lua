CardPronouns.PronounClassification {
    key = "masculine",
    pronouns = { "HIM" }
}

CardPronouns.PronounClassification {
    key = "feminine",
    pronouns = { "HER" }
}

CardPronouns.PronounClassification {
    key = "neutral",
    pronouns = { "IT" }
}

CardPronouns.PronounClassification {
    key = "agender",
    pronouns = { "It", "IT", "Its", "Thing", "Robot", "Machinery" }
}

CardPronouns.PronounClassification {
    key = "neo",
    pronouns = { "Xe", "Xem", "Xyr", "Ze", "Zir", "Hir", "Hirs" }
}

CardPronouns.Pronoun {
    colour = HEX("FF90FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "HER" },
    in_pool = function()
        return true
    end,
    key = "l_her"
}

CardPronouns.Pronoun {
    colour = HEX("#6832E3"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "Him" },
    in_pool = function()
        return true
    end,
    key = "she_him"
}

CardPronouns.Pronoun {
    colour = HEX("FFABFF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "It" },
    in_pool = function()
        return true
    end,
    key = "she_it"
}


CardPronouns.Pronoun {
    colour = HEX("61B5FA"),
    text_colour = G.C.WHITE,
    pronoun_table = { "HIM" },
    in_pool = function()
        return true
    end,
    key = "l_him"
}

CardPronouns.Pronoun {
    colour = HEX("#6832E3"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "Her" },
    in_pool = function()
        return true
    end,
    key = "he_her"
}


CardPronouns.Pronoun {
    colour = G.C.WHITE,
    text_colour = G.C.BLACK,
    pronoun_table = { "Any", "All" },
    in_pool = function()
        return true
    end,
    key = "any_all"
}


CardPronouns.Pronoun {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    pronoun_table = { "IT" },
    in_pool = function()
        return true
    end,
    key = "l_it"
}


CardPronouns.Pronoun {
    colour = HEX("96D0FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "They" },
    in_pool = function()
        return true
    end,
    key = "he_they"
}

CardPronouns.Pronoun {
    colour = HEX("96D0FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "It" },
    in_pool = function()
        return true
    end,
    key = "he_it"
}