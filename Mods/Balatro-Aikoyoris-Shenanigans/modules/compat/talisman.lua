-- talisman exclusive hooks
if Talisman and false then
    -- these are for null cards
    
    local getchipxbonusHookAiko = Card.get_chip_x_bonus
    function Card:get_chip_x_bonus()
        if self.is_null then return 0 end
        local ret = getchipxbonusHookAiko(self)
        return ret
    end

    local getchipebonusHookAiko = Card.get_chip_e_bonus
    function Card:get_chip_e_bonus()
        if self.is_null then return 0 end
        local ret = getchipebonusHookAiko(self)
        return ret
    end

    local getchipeebonusHookAiko = Card.get_chip_ee_bonus
    function Card:get_chip_ee_bonus()
        if self.is_null then return 0 end
        local ret = getchipeebonusHookAiko(self)
        return ret
    end

    local getchipeeebonusHookAiko = Card.get_chip_eee_bonus
    function Card:get_chip_eee_bonus()
        if self.is_null then return 0 end
        local ret = getchipeeebonusHookAiko(self)
        return ret
    end

    local getchiphyperbonusHookAiko = Card.get_chip_hyper_bonus
    function Card:get_chip_hyper_bonus()
        if self.is_null then return {0,0} end
        local ret = getchiphyperbonusHookAiko(self)
        return ret
    end
    local getchipemultHookAiko = Card.get_chip_e_mult
    function Card:get_chip_e_mult()
        if self.is_null then return 0 end
        local ret = getchipemultHookAiko(self)
        return ret
    end

    local getchipeemultHookAiko = Card.get_chip_ee_mult
    function Card:get_chip_ee_mult()
        if self.is_null then return 0 end
        local ret = getchipeemultHookAiko(self)
        return ret
    end

    local getchipeeemultHookAiko = Card.get_chip_eee_mult
    function Card:get_chip_eee_mult()
        if self.is_null then return 0 end
        local ret = getchipeeemultHookAiko(self)
        return ret
    end

    local getchiphypermultHookAiko = Card.get_chip_hyper_mult
    function Card:get_chip_hyper_mult()
        if self.is_null then return {0,0} end
        local ret = getchiphypermultHookAiko(self)
        return ret
    end
end