AKYRS.Enchantments = {}
AKYRS.Enchantment = SMODS.GameObject:extend{
    set = "Enchantment",
    required_params = {
        "key",
        "max_level"
    },
    max_level = 1,
    get_level = function(self,ench_power)
        return self.max_level
    end
}