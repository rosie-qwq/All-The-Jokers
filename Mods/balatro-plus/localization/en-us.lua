local mysthic_pack = {
  name = "Mysthic Pack",
  text = {
    "Choose {C:attention}#1#{} of up to",
    "{C:attention}#2#{} {C:bplus_sigil}Sigil{} cards to",
    "be used immediately",
  },
}

local enhancement_tarot_text = {
  "Enhances {C:attention}#1#{}",
  "selected cards to",
  "{C:attention}#2#s",
}

return {
  descriptions = {
    Back = {
      b_bplus_purple = {
        name = "Purple Deck",
        text = {
          "Reroll also refresh {C:attention}Booster Pack{}",
          "reroll cost {C:money}$#1#{} more",
        },
      },
      b_bplus_illusion = {
        name = "Illusion Deck",
        text = {
          "Playing cards has more {C:chips}Chips",
          "start run with {C:attention}#1#{}",
          "random cards destroyed",
        },
      },
      b_bplus_jokered = {
        name = "Jokered Deck",
        text = {
          "Start with {C:money}$#1#{},",
          "{C:attention,T:p_buffoon_jumbo_1}Jumbo Buffoon Pack{}",
          "and {C:attention,T:v_hone}Hone{} voucher",
        },
      },
      b_bplus_mysthical = {
        name = "Mysthical Deck",
        text = {
          "Create a random {C:bplus_sigil}Sigil{} card",
          "when blind is selected",
          "{C:inactive}(Must have room)",
          "Shop {C:attention}slot{} and Shop {C:attention}Booster",
          "{C:attention}Pack{} has {C:attention}1{} less slot",
        },
      },
      b_bplus_random = {
        name = "Random Deck",
        text = {
          "Start with random {C:attention}Voucher{}",
          "and random {C:blue}Common{} Joker",
          "Random {C:blue}hand{} every round",
        },
      },
    },

    Joker = {
      j_bplus_hungry = {
        name = "Hungry Joker",
        text = {
          "At the {C:attention}end of shop",
          "destroy {C:attention}Food Joker",
          "to gain {X:mult,C:white} X#1# {} Mult",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
      j_bplus_blackjack = {
        name = "Blackjack",
        text = {
          "Gains {C:chips}#1#{} Chips if played",
          "hand is {C:attention}Blackjack{}",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
      j_bplus_calculator = {
        name = "Calculator",
        text = {
          "If all played cards is",
          "{C:attention}numbered{} card {C:inactive}(2 to 10){},",
          "add the sum of all played",
          "cards to the {C:mult}Mult",
        },
      },
      j_bplus_space_invader = {
        name = "Space Invader",
        text = {
          "{C:planet}Planet{} card added",
          "to {C:attention}Consumable slot{}",
          "become {C:dark_edition}negative",
        },
      },
      j_bplus_treasure_map = {
        name = "Treasure Map",
        text = {
          "Earn {C:money}$#1#{} up to {C:money}$#2#{}",
          "every {C:attention}#3#{} trigger",
          "{C:inactive}(#4#){}",
        },
      },
      j_bplus_magnifying_glass = {
        name = "Magnifying Glass",
        text = {
          "Add {C:attention}triple{} of each",
          "played {C:attention}2{} and {C:attention}3{} Chips",
          "value to the {C:chips}Chips{}",
        },
      },
      j_bplus_crown = {
        name = "Crown",
        text = {
          "Gain {X:mult,C:white} X#1# {} Mult when",
          "playing {C:attention}Royal Flush{}",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {}{C:inactive} Mult)",
        },
      },
      j_bplus_pickpocket = {
        name = "Pickpocket",
        text = {
          "Choose one more card when",
          "opening any {C:attention}Booster pack{}",
        },
      },
      j_bplus_four_leaf_clover = {
        name = "4 Leaf Clover",
        text = {
          "{X:green,C:white} X4 {} all {C:green,E:1,s:1.1}probabilities{} after",
          "playing hand that is contain",
          "exactly {C:attention}4{} {C:clubs}Clubs{}, inactive",
          "after {C:attention}Boss Blind{} defeated",
        },
      },
      j_bplus_toilet = {
        name = "Toilet",
        text = {
          "Gain {C:chips}Chips{} from half {C:chips}Chips{}",
          "value of {C:attention}Flush{} poker hand",
          "when {C:attention}Flush{} is discarded",
          "{s:0.8}only work once each round{}",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
      },
      j_bplus_boxer = {
        name = "Boxer",
        text = {
          "Gives {X:mult,C:white} X#1# {} for each",
          "remaining {C:blue}hands{} above {C:attention}#2#",
          "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
        },
      },
      j_bplus_memory_card = {
        name = "Memory Card",
        text = {
          "Save remaining {C:blue}hand",
          "for next round",
          "{C:inactive}({C:blue}#1#{C:inactive}/{C:blue}#2#{C:inactive} Saved)",
        },
      },
      j_bplus_jim130 = {
        name = "Joker JIM130",
        text = {
          "Gain {X:mult,C:white} X#1# {} each",
          "triggered {C:attention}Steel Card",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
      j_bplus_archeologist = {
        name = "Archeologist",
        text = {
          "Gain {C:mult}#1#{} Mult for every {C:spades}Spade",
          "cards in your {C:attention}full hand",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        },
      },
      j_bplus_golden_cheese = {
        name = "Golden Cheese",
        text = {
          "Earn {C:money}$#1#{} at the end",
          "of round, loss {C:money}$#2#",
          "each blind is {C:attention}skipped",
        },
      },
      j_bplus_anonymous_mask = {
        name = "Anonymous Mask",
        text = {
          "All {C:attention}face cards{}",
          "can't be {C:red}debuffed{}",
        },
      },
      j_bplus_santa_claus = {
        name = "Santa Claus",
        text = {
          "Each {C:attention}#1#{} rounds played give",
          "a {C:dark_edition}negative{} {C:red}Rare{} Joker",
          "at the end of round",
          "{C:inactive}(#2#)",
        },
      },
      j_bplus_shopping_bill = {
        name = "Shopping Bill",
        text = {
          "All {C:attention}numbered{} cards held in",
          "hand at the end of round",
          "have {C:green}#1# in #2#{} chance to earn",
          "{C:attention}rank{} value of card {C:money}dollars{}",
        },
      },
      j_bplus_ufo = {
        name = "UFO",
        text = {
          "Gain {C:chips}+#1#{} Chips for each",
          "{C:attention}unique{} {C:planet}Planet{} card on",
          "your {C:attention}consumables{} slot at",
          "the end of the {C:attention}shop",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
      j_bplus_zombie_hand = {
        name = "Zombie Hand",
        text = {
          "Level up played {C:attention}poker hand{}",
          "by {C:attention}#1#{} level on final hand",
        },
      },
      j_bplus_jackpot = {
        name = "Jackpot",
        text = {
          "Gain {C:mult}+#1#{} Mult every {C:attention}#2#{} {C:inactive}[#5#]",
          "times {C:attention}#3#{} is triggered",
          "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
        },
      },
      j_bplus_snowman = {
        name = "Snowman",
        text = {
          "{C:chips}+#1#{} Chips and gain {C:chips}+#2#",
          "Chips for each cards",
          "{C:attention}held in hand{}, resets",
          "at the end of round",
        },
      },
      j_bplus_trash_can = {
        name = "Trash Can",
        text = {
          "Retrigger all card",
          "{C:red}discard{} ability",
        },
      },
      j_bplus_blacksmith = {
        name = "Blacksmith",
        text = {
          "Gains {C:chips}+#1#{} Chips when",
          "enhancing card",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
      j_bplus_wheel = {
        name = "Wheel",
        text = {
          "Gain {X:mult,C:white} X#1# {} each discarded",
          "cards, resets after",
          "playing a {C:blue}hand",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
      j_bplus_fragile = {
        name = "Fragile",
        text = {
          "{C:attention}Glass Card{} is",
          "destroyed when",
          "{C:red}discarded{}",
        },
      },
      j_bplus_stone_skipping = {
        name = "Stone Skipping",
        text = {
          "Give {X:mult,C:white} X#1# {} Mult when {C:attention}Stone Card{}",
          "is triggered, increase {X:mult,C:white} X#2# {}",
          "per {C:attention}Stone Card{} triggered,",
          "reset after playing hand",
        },
      },
      j_bplus_stone_carving = {
        name = "Stone Carving",
        text = {
          "All {C:attention}Stone Card{} is",
          "{C:attention}#1#{} of {V:1}#2#",
          "{s:0.8}Card changes every round",
        },
      },
      j_bplus_chef = {
        name = "Chef",
        text = {
          "Create a {C:attention}Food Joker",
          "when blind is {C:attention}selected",
          "{C:inactive}(Must have room)",
        },
      },
      j_bplus_potato_chips = {
        name = "Potato Chips",
        text = {
          "{C:chips}+#1#{} Chips",
          "{C:chips}-#2#{} Chips for",
          "every card trigger",
        },
      },
      j_bplus_membership_card = {
        name = "Membership Card",
        text = {
          "Reduce {C:attention}Premium Card",
          "cost by {C:money}$#1#{}",
        },
      },
      j_bplus_art_exhibition = {
        name = "Art Exhibition",
        text = {
          "Gains {C:chips}+#1#{} Chips for",
          "each {C:attention}Framed Cards",
          "in your {C:attention}played hand",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
      j_bplus_wizard = {
        name = "Wizard",
        text = {
          "After {C:attention}#1#{} {C:inactive}[#2#]{} cards destroyed",
          "create a random {C:bplus_sigil}Sigil{} card",
          "when blind is selected",
          "{C:inactive}(Must have room)",
        },
      },
      j_bplus_seller = {
        name = "Seller",
        text = {
          "Earn {C:attention}sell value{} of",
          "Joker to the {C:attention}right{} at",
          "the end of round",
        },
      },
      j_bplus_chance_card = {
        name = "Chance Card",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "{C:attention}retrigger{} played card",
        },
      },
      j_bplus_paper_shredder = {
        name = "Paper Shredder",
        text = {
          "After hand played {C:red}destroy{} the",
          "{C:attention}right most{} card in your {C:attention}played",
          "cards and gain {C:mult}+#1#{} Mult",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        },
      },
      j_bplus_meteor = {
        name = "Meteor",
        text = {
          "Upgrade a random {C:attention}poker",
          "{C:attention}hand{} when blind is",
          "selected",
        },
      },
      j_bplus_jumbo = {
        name = "Jumbo",
        text = {
          "Give {X:mult,C:white} X#1# {} Mult, destroy",
          "{C:attention}right most{} joker if",
          "there is no {C:attention}empty{} space",
          "when blind is selected",
        },
      },
      j_bplus_blured = {
        name = "Blured Joker",
        text = {
          "All {V:1}#1#{} is",
          "also a {V:2}#2#",
          "{s:0.8}changes every round",
        },
      },
      j_bplus_murderer = {
        name = "Murderer",
        text = {
          "Gain {X:mult,C:white} X#1# {} Mult when",
          "Joker is destroyed",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
      j_bplus_scorched = {
        name = "Scorched Joker",
        text = {
          "Gain {X:mult,C:white} X#1# {} Mult when",
          "{C:attention}Burned Card{} is burned",
          "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
      j_bplus_not_found = {
        name = "Joker Not Found",
        text = {
          "{C:blue}Common{} Jokers no longer",
          "{C:attention}appear{} in the {C:attention}shop",
        },
      },
      j_bplus_puzzle = {
        name = "Puzzle",
        text = {
          "Gain {C:chips}+#1#{} Chips if",
          "{C:attention}scoring{} hand contains",
          "{C:attention}#2#{} of {V:1}#3#",
          "{s:0.8}Card changes after gain chips",
          "{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)",
        },
      },
      j_bplus_rgb = {
        name = "RGB Joker",
        text = {
          "{C:mult}+#1#{} Mult if scoring",
          "hand contains {C:attention}exactly",
          "{C:attention}3{} different {C:attention}suits",
        },
      },
      j_bplus_newspaper = {
        name = "Newspaper",
        text = {
          "Each played {C:attention}#1#",
          "gives {C:mult}+#2#{} Mult",
          "{s:0.8}Rank changes every round",
        },
      },
      j_bplus_time_machine = {
        name = "Time Machine",
        text = {
          "Sell this card to",
          "{C:attention}#1#{} ante",
        },
      },
      j_bplus_add_4 = {
        name = "Add 4",
        text = {
          "When round begins,",
          "draw {C:attention}4{} cards",
        },
      },
      j_bplus_in_a_box = {
        name = "Joker In a Box",
        text = {
          "Give {C:mult}+#1#{} Mult",
          "or {C:chips}+#2#{} Chips",
          "or {C:money}+#3#{} dollars",
          "or {X:mult,C:white} X#4# {} Mult",
        },
      },
      j_bplus_magnetic = {
        name = "Magnetic Joker",
        text = {
          "After hand drawn,",
          "draw 1 {C:attention}Steel Card{}",
          "from your deck",
        },
      },
      j_bplus_fortune_cookie = {
        name = "Fortune Cookie",
        text = {
          "{X:green,C:white} X#1# {} all {C:green,E:1,s:1.1}probabilities",
          "After {C:attention}Boss Blind",
          "defeated, loss {X:green,C:white} X1 ",
        },
      },
    },

    Tarot = {
      c_bplus_rich = { name = "The Rich", text = enhancement_tarot_text },
      c_bplus_craftsman = { name = "The Craftsman", text = enhancement_tarot_text },
      c_bplus_balance = { name = "Balance", text = enhancement_tarot_text },
      c_bplus_hell = { name = "The Hell", text = enhancement_tarot_text },
    },

    Enhanced = {
      m_bplus_premium = {
        name = "Premium Card",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "#3# {C:money}$#2#",
        },
      },
      m_bplus_framed = {
        name = "Framed Card",
        text = {
          "Gains {C:chips}+#1#{} Chips",
          "each {C:attention}triggered",
        },
      },
      m_bplus_balanced = {
        name = "Balanced Card",
        text = {
          "{C:attention}Balance{} this card",
          "{C:chips}Chips{} and {C:mult}Mult",
        },
      },
      m_bplus_burned = {
        name = "Burned Card",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "If {C:attention}held in hand{} at the",
          "{C:attention}end of round{}, enhance",
          "adjacent card to {C:attention}Burned",
          "{C:attention}Card{} and {C:red}burn{} this card",
        },
      },
    },

    Voucher = {
      v_bplus_refund = {
        name = "Refund",
        text = {
          "Earn {C:money}$#1#{} per {C:attention}choose{}",
          "remaining when any",
          "{C:attention}Booster Pack{} is skipped",
        },
      },
      v_bplus_big_pack = {
        name = "Big Pack",
        text = {
          "{C:attention}Booster Pack{} has",
          "{C:attention}+#1#{} choose and",
          "{C:attention}+#2#{} card slot",
        },
      },
      v_bplus_dash = {
        name = "Dash",
        text = {
          "When {C:attention}Blind{} is",
          "skipped, earn {C:money}$#1#{}",
        },
      },
      v_bplus_rainbow = {
        name = "Rainbow",
        text = {
          "When {C:attention}Blind{} is skipped,",
          "give any {C:dark_edition}edition",
          "to random Joker",
        },
      },
    },

    Blind = {
      bl_bplus_loop = {
        name = "The Loop",
        text = {
          "Set score to 0 if score",
          "is less than required",
        },
      },
      bl_bplus_extra = {
        name = "The Extra",
        text = {
          "Each hand played add",
          "random normal card",
        },
      },
      bl_bplus_low = {
        name = "The Low",
        text = {
          "Played cards enhancement",
          "are removed",
        },
      },
      bl_bplus_hammer = {
        name = "The Hammer",
        text = {
          "Destroy 1 random card",
          "every hand drawn",
        },
      },
      bl_bplus_thunder = {
        name = "The Thunder",
        text = {
          "Score more for each",
          "Jokers you have",
        },
      },
      bl_bplus_brake = {
        name = "The Brake",
        text = {
          "Cannot play/discard",
          "consecutively",
        },
      },
      bl_bplus_lazy = {
        name = "The Lazy",
        text = {
          "Retrigger effects",
          "are not allowed",
        },
      },
      bl_bplus_scales = {
        name = "The Scales",
        text = {
          "Loss $1 for each",
          "cards held in hend",
        },
      },
      bl_bplus_thirteen = {
        name = "The 13",
        text = {
          "All probabilities are 0",
        },
      },
      bl_bplus_handcuffs = {
        name = "The Handcuffs",
        text = {
          "Debuff all cards held in",
          "hand per hand played",
        },
      },
    },

    Tag = {
      tag_bplus_glow = {
        name = "Glow Tag",
        text = {
          "Add random {C:dark_edition}edition{} to",
          "random Joker if any",
        },
      },
      tag_bplus_glove = {
        name = "Glove Tag",
        text = {
          "{C:blue}+#1#{} Hands",
          "next round",
        },
      },
      tag_bplus_collector = {
        name = "Collector Tag",
        text = {
          "Earn {C:money}$#1#{} for each",
          "card above {C:attention}#2#{}",
          "in your full deck",
          "{C:inactive}(Max of {C:money}$#3#{C:inactive})",
          "{C:inactive}(Currently {C:money}$#4#{C:inactive})",
        },
      },
      tag_bplus_booster = {
        name = "Booster Tag",
        text = {
          "Adds {C:attention}#1# Booster Pack",
          "to the next shop",
        },
      },
      tag_bplus_dish = {
        name = "Dish Tag",
        text = {
          "Create random",
          "{C:attention}Food Joker",
          "{C:inactive}(Must have room)",
        },
      },
      tag_bplus_bounty = {
        name = "Bounty Tag",
        text = {
          "Earn {X:money,C:white} X#1# {} {C:money}dollars{} of the {C:attention}Blinds",
          "reward when defeated",
        },
      },
      tag_bplus_enhanced = {
        name = "Enhanced Tag",
        text = {
          "Enhance all cards",
          "held in hand to",
          "{C:attention}#1#s",
          "when round begin",
        },
      },
      tag_bplus_mysthic = {
        name = "Mysthic Tag",
        text = {
          "Gives a free",
          "{C:bplus_sigil}Mega Mysthic Pack",
        },
      },
      tag_bplus_burning = {
        name = "Burning Tag",
        text = {
          "{C:red}+#1#{} Discards",
          "next round",
        },
      },
      tag_bplus_symbolic = {
        name = "Symbolic Tag",
        text = {
          "Earn {C:money}$#1#{} for every",
          "{V:1}#2#{} cards you have",
          "{C:inactive}(Currently {C:money}$#3#{C:inactive})",
          "{C:inactive}(Max of {C:money}$#4#{C:inactive})",
        },
      },
      tag_bplus_recycle = {
        name = "Recycle Tag",
        text = {
          "Create last added tag",
          "{s:0.8,C:green}Recycle Tag {s:0.8}excluded",
        },
      },
      tag_bplus_backpack = {
        name = "Backpack Tag",
        text = {
          "Create {C:dark_edition}negative{} copies of all",
          "cards in your {C:attention}Consumable slot",
        },
      },
    },

    sigil = {
      c_bplus_sigil_blank = {
        name = "Blank",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "create other {C:attention}Sigil{} card",
          "{s:0.8}chance is increasing",
          "{s:0.8}at the end of round",
          "{C:inactive}(Must have room)",
        },
      },
      c_bplus_sigil_polyc = {
        name = "Polyc",
        text = {
          "Destroy {C:attention}1{} random Joker",
          "to add {C:dark_edition}Polychrome{} to",
          "selected Joker",
        },
      },
      c_bplus_sigil_rebirth = {
        name = "Rebirth",
        text = {
          "Destroy all non {C:dark_edition}negative{}",
          "Jokers to {C:attention}create{} Jokers",
          "with the same amount of",
          "{C:attention}destroyed{} Jokers with",
          "same {C:attention}Rarity",
        },
      },
      c_bplus_sigil_astra = {
        name = "Astra",
        text = {
          "Level up your most played {C:attention}poker",
          "{C:attention}hand{} level by total of all other",
          "{C:attention}poker hands{} level above {C:attention}1{}, resets",
          "other {C:attention}poker hands{} level",
          "{C:inactive}(Currently level up by {C:attention}#1#{C:inactive})",
        },
      },
      c_bplus_sigil_aye = {
        name = "Aye",
        text = {
          "Change up to {C:attention}#1#{} selected",
          "cards {C:attention}rank{} and {C:attention}suits{} to",
          "{C:attention}rank{} and {C:attention}suits{} of random",
          "card in your {C:attention}deck",
        },
      },
      c_bplus_sigil_bann = {
        name = "Bann",
        text = {
          "Destroy all cards with",
          "selected card {C:attention}rank",
          "and {C:attention}suit",
        },
      },
      c_bplus_sigil_beast = {
        name = "Beast",
        text = {
          "Enhance up to {C:attention}#1#{} selected cards",
          "with random {C:attention}Enhancement{} and {C:attention}Seal{}",
          "destroy other {C:attention}unselected{} cards with",
          "same amount of {C:attention}selected{} cards",
        },
      },
      c_bplus_sigil_curse = {
        name = "Curse",
        text = {
          "{C:green}#1# in #2#{} chance to add",
          "any {C:dark_edition}edition{} to random",
          "Joker if {C:red}failed{} add",
          "{C:eternal}Eternal{} and {C:rental}Rental",
        },
      },
      c_bplus_sigil_dupe = {
        name = "Dupe",
        text = {
          "Covert all {C:attention}unselected",
          "cards to {C:attention}selected{} card",
          "{C:blue}-#1#{} Hand",
        },
      },
      c_bplus_sigil_froze = {
        name = "Froze",
        text = {
          "{C:red}Debuff{} selected joker for",
          "{C:attention}#1#{} rounds, become {C:dark_edition}negative{}",
          "after {C:red}debuff{} end",
        },
      },
      c_bplus_sigil_klone = {
        name = "Klone",
        text = {
          "Create copy of up",
          "to {C:attention}#1#{} selected",
          "cards",
        },
      },
      c_bplus_sigil_rewind = {
        name = "Rewind",
        text = {
          "Destroys all {C:attention}Consumables",
          "to fill it with copies of",
          "last used {C:tarot}Tarot{} or",
          "{C:planet}Planet{} card",
        },
      },
      c_bplus_sigil_sacre = {
        name = "Sacre",
        text = {
          "Destroys {C:attention}#1#{} random cards",
          "in your hand, create",
          "a random {C:red}Rare{} Joker",
          "{C:inactive}(Must have room)",
        },
      },
      c_bplus_sigil_shine = {
        name = "Shine",
        text = {
          "Add {C:dark_edition}#1#{} to",
          "selected card",
          "{s:0.8}changes every round",
          "{s:0.8}cannot be {C:dark_edition,s:0.8}negative",
        },
      },
    },

    Other = {
      p_bplus_mysthic_normal1 = mysthic_pack,
      p_bplus_mysthic_normal2 = mysthic_pack,
      p_bplus_mysthic_jumbo = mysthic_pack,
      p_bplus_mysthic_mega = mysthic_pack,

      bplus_green_seal = {
        name = "Green Seal",
        text = {
          "{C:green}#1# in #2#{} chance",
          "for {X:mult,C:white} X#3# {} Mult",
        },
      },

      undiscovered_sigil = {
        name = "Not Dicovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does",
        },
      },
    },
  },
  misc = {
    dictionary = {
      b_sigil_cards = "Sigil Cards",
      k_sigil = "Sigil",

      k_bplus_mysthic_pack = "Mysthic Pack",
      k_bplus_ho_ho_ho_ex = "Ho Ho Ho!",
      k_bplus_no_retrigger = "No Retrigger",
      k_bplus_inactive_ex = "Inactive!",
      k_bplus_burn_ex = "Burn!",

      ph_bplus_defeat_the_blind = "Defeat the Blind",
    },

    v_dictionary = {
      k_bplus_saved_ex = "#1# Saved!",
      k_bplus_draw_ex = "Draw #1#!",
      k_bplus_plus_choose_ex = "+#1# Choose!",
      k_bplus_plus_sigil_ex = "+#1# Sigil!",
    },

    labels = {
      bplus_green_seal = "Green Seal",
    },
  },
}
