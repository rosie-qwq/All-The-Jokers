B1999.SPECIL = {}
B1999.ACOUSTICA = {}

function SpecilReverse(base, reversed)
    local specil = {
        base = base,
        reversed = reversed
    }
    table.insert(B1999.SPECIL, specil)
end

function NewAcoustica(base, acoustica)
    local acoustica = {
        base = base,
        acoustica = acoustica
    }
    table.insert(B1999.ACOUSTICA, acoustica)
end