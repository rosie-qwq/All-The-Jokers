return {
    descriptions = {
        Joker = {
            j_BfJ_balloony = {
                name = "Balloony",
                text = {
                    "{C:red}+#1#{} Mult"
                }
            },
            j_BfJ_cake = {
                name = "Cake",
                text = {
                    "{C:blue}+#1#{} Chips",
                }
            },
            j_BfJ_winner = {
                name = "Winner",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if all",
                    "cards in scoring",
                    "hand are {C:attention}7s{}",
                }
            },
            j_BfJ_bottle = {
                name = "Bottle",
                text = {
                    "This Joker gains {C:red}+#3#{} Mult",
                    "and {C:blue}+#1#{} Chips for every",
                    "{C:attention}Glass Card{} that is {C:red}destroyed{}",
                    "{C:inactive}(Currently {C:mult}+#4#{}{C:inactive} Mult and {C:chips}+#2#{}{C:inactive} Chips)"
                }
            },
            j_BfJ_pillow = {
                name = "Pillow",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroy Joker to the right",
                    "and permanently add {C:chips}Chips{}",
                    "depending on its {C:attention}rarity{}",
                    "{s:0.8,C:blue}+20{s:0.8} for {s:0.8,C:common}Common{s:0.8}, {s:0.8,C:blue}+40{s:0.8} for {s:0.8,C:uncommon}Uncommon{s:0.8},{}",
                    "{s:0.8,C:blue}+100{s:0.8} for {s:0.8,C:rare}Rare{s:0.8}, and {s:0.8,C:blue}+1000{s:0.8} for {s:0.8,C:legendary}Legendary{}",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}"
                }
            },
            j_BfJ_lollipop = {
                name = "Lollipop",
                text = {
                    "Earn {C:money}$#1#{} if played",
                    "hand contains at least",
                    "{C:attention}two different{} scoring suits"
                }
            },
            j_BfJ_taco = {
                name = "Taco",
                text = {
                    "{C:red}+#4#{} Mult and {C:blue}+#3#{} Chips for",
                    "each empty {C:attention}Joker{} slot",
                    "{s:0.8}Taco included{}",
                    "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult and {C:chips}+#1#{}{C:inactive} Chips)"
                }
            },
            j_BfJ_grassy = {
                name = "Grassy",
                text = {
                    "If played hand is a",
                    "{C:attention}#4#{}, randomly",
                    "gives either {C:mult}+#1#{} Mult,",
                    "{C:chips}+#2#{} Chips, or {X:mult,C:white}X#3#{} Mult"
                }
            },
            j_BfJ_eggy = {
                name = "Eggy",
                text = {
                    {
                        "Increases the {C:attention}sell value{}",
                        "of adjacent jokers by {C:money}$#2#{}",
                        "and gives {C:money}$#1#{} at end of round",
                    },
                    {
                        "At end of round,",
                        "{C:green}#3# in #4#{} chance to",
                        "{S:1.1,C:red,E:2}self destruct{}"
                    }
                }
            },
            j_BfJ_eightball = {
                name = "8 Ball",
                text = {
                    "Each played {C:attention}8{} gives",
                    "{C:mult}+#1#{} Mult and {C:chips}+#1#{} Chips",
                    "when scored"
                }
            },
            j_BfJ_foldy = {
                name = "Foldy",
                text = {
                    "Played cards with",
                    "{C:attention}no enhancements{} give",
                    "{C:mult}+#1#{} Mult when scored"
                }
            },
            j_BfJ_clock = {
                name = "Clock",
                text = {
                    "Gain {C:blue}+#1#{} hand#3# when next",
                    "{C:attention}Boss Blind{} is selected,",
                    "increases by {C:attention}#2#{} when hand",
                    "is played outside the {C:attention}Boss Blind{}"
                }
            },
            j_BfJ_barfbag = {
                name = "Barf Bag",
                text = {
                    "Gains {C:red}+#2#{} discard if no",
                    "{C:red}discards{} are used by the end of",
                    "the round, else loses {C:red}-#2#{} discard",
                    "{C:inactive}(Currently {C:red}+#1#{}{C:inactive} discard#3#){}"
                }
            },
            j_BfJ_fanny = {
                name = "Fanny",
                text = {
                    "Upgrades level of played",
                    "{C:attention}poker hand{} if it is",
                    "not your most played",
                    "{C:attention}poker hand{}"
                }
            },
            j_BfJ_pie = {
                name = "Pie",
                text = {
                    {
                        "{C:mult}+#1#{} Mult"
                    },
                    {
                        "If played hand is a",
                        "{C:attention}#4#{} of {C:clubs}#3#{}",
                        "{S:1.1,C:red,E:2}self destructs{}",
                        "and grants {C:money}$#2#{}"
                    }
                }
            },
            j_BfJ_gaty = {
                name = "Gaty",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "if played hand",
                    "contains a {C:attention}#2#{}",
                    "{C:inactive}(Currently {C:red}+#3#{}{C:inactive} Mult)"
                }
            },
            j_BfJ_robotflower = {
                name = "Robot Flower",
                text = {
                    "This Joker {C:attention}randomly{}",
                    "gives between",
                    "{X:chips,C:white}X#1#{} and {X:chips,C:white}X#2#{} Chips"
                }
            },
            j_BfJ_bracelety = {
                name = "Bracelety",
                text = {
                    {
                        "{C:mult}+#1#{} Mult if played",
                        "hand contains a {C:attention}#2#{}",
                    },
                    {
                        "{s:0.8}If {s:0.8,C:attention}Ice Cube{s:0.8} is owned:{}",
                        "{s:0.8}This Joker gives an{}",
                        "{s:0.8}additional {s:0.8,X:mult,C:white}X#3#{s:0.8} Mult"
                    }
                }
            },
            j_BfJ_cloudy = {
                name = "Cloudy",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "for each {C:attention}2{} cards above {C:attention}#3#{}",
                    "in your full deck, {C:red}lose{} {C:money}$#1#{}",
                    "for each {C:attention}2{} cards below",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
                }
            },
            j_BfJ_saw = {
                name = "Saw",
                text = {
                    "When playing a {C:attention}Boss Blind{},",
                    "sell this card to halve",
                    "its {C:attention}score{} requirement"
                }
            },
            j_BfJ_blackhole = {
                name = "Black Hole",
                text = {
                    "Zeroes all {C:attention}listed{}",
                    "{C:green,E:1,S:1.1}probabilities{}",
                    "{C:inactive}(ex: {C:green}1 in 4{C:inactive} -> {C:green}0 in 4{C:inactive}){}",
                }
            },
            j_BfJ_roboty = {
                name = "Roboty",
                text = {
                    "Retrigger each",
                    "played {C:attention}10{}"
                }
            },
            j_BfJ_remote = {
                name = "Remote",
                text = {
                    "Retriggers all compatible",
                    "{C:attention}mechanical minds{}",
                    "{s:0.8,C:inactive}(Robot Flower, Roboty, TV){}"
                }
            },
            j_BfJ_marker = {
                name = "Marker",
                text = {
                    "Every {C:attention}3{} {C:inactive}[#1#]{} hands played,",
                    "this Joker converts the",
                    "{C:attention}suits{} of all {C:attention}played{}",
                    "cards to {C:spades}Spades{}"
                }
            },
            j_BfJ_basketball = {
                name = "Basketball",
                text = {
                    "Earn {C:money}$#2#{} at end of round",
                    "for every {C:attention}5 times{} your most",
                    "played hand has been played",
                    "{C:inactive}(Currently {C:money}$#1#{C:inactive}){}"
                }
            },
            j_BfJ_stapy = {
                name = "Stapy",
                text = {
                    "When hand is played, {C:green}#2# in #1#{}",
                    "chance to convert the {C:attention}highest{}",
                    "ranked card into a {C:attention}Bonus Card{}",
                    "{s:0.8,C:inactive}(If tied, chooses the rightmost){}"
                }
            },
            j_BfJ_loser = {
                name = "Loser",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if all",
                    "{C:attention}Joker{} slots are full",
                    "{C:inactive}(#2#){}"
                }
            },
            j_BfJ_lightning = {
                name = "Lightning",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "for each {C:attention}consecutive{} hand",
                    "with exactly {C:attention}5{} cards",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
                }
            },
            j_BfJ_fireyjr = {
                name = "Firey Jr.",
                text = {
                    "This Joker gains {C:chips}+#2#{} Chips",
                    "if {C:attention}first{} hand of round",
                    "contains {C:attention}5{} cards",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}"
                }
            },
            j_BfJ_bell = {
                name = "Bell",
                text = {
                    "{C:green}#3# in #2#{} chance",
                    "to create a {C:planet}Planet{}",
                    "card if played hand",
                    "is a {C:attention}High Card{}",
                    "{C:inactive}(Must have room){}"
                }
            },
            j_BfJ_pricetag = {
                name = 'Price Tag',
                text = {
                    "This Joker gains {C:money}+$#1#{}",
                    "of {C:attention}sell value{} for",
                    "each card {C:attention}sold{}"
                }
            },
            j_BfJ_tree = {
                name = 'Tree',
                text = {
                    'After {C:attention}#1#{} {C:inactive}[#2#]{} rounds, this',
                    'Joker {C:attention}sells{} {C:attention}itself{} and',
                    'creates a copy of {C:spectral}The Soul{}',
                    "{C:inactive}(Must have room){}"
                }
            },
            j_BfJ_naily = {
                name = 'Naily',
                text = {
                    'Sell this card to',
                    'give a {C:attention}random{} Joker',
                    'an {C:eternal}Eternal{} Sticker'
                }
            },
            j_BfJ_liy = {
                name = 'Liy',
                text = {
                    {
                        "{C:mult}+#1#{} Mult,",
                        "{C:chips}+#2#{} Chips"
                    },
                    {
                        "After {C:attention}#3#{} {C:inactive}[#4#]{} hands",
                        "played, this Joker",
                        "{C:attention}flips her switch{}",
                        "{C:inactive}(Changes her ability){}"
                    }
                }
            },
            j_BfJ_liy2 = {
                name = 'Liy',
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult"
                    },
                    {
                        "After {C:attention}#2#{} {C:inactive}[#3#]{} hands",
                        "played, this Joker",
                        "{C:attention}flips her switch{}",
                        "{C:inactive}(Changes her ability){}",
                        "{s:0.7,C:inactive}(But why, Liy?){}"
                    }
                }
            },
            j_BfJ_blocky = {
                name = 'Blocky',
                text = {
                    "{C:attention}Pranks{} {C:inactive}(debuffs){} a random",
                    "{C:attention}Joker{} each round, and gains",
                    'an effect based on its rarity',
                    '{s:0.8,C:chips}+#3#{s:0.8} Chips for {s:0.8,C:common}Common{s:0.8}, {s:0.8,C:mult}+#1#{s:0.8} Mult for {s:0.8,C:uncommon}Uncommon{s:0.8},{}',
                    '{s:0.8,X:mult,C:white}X#2#{s:0.8} Mult for {s:0.8,C:rare}Rare{s:0.8}, and {s:0.8,C:attention}all{s:0.8} for {s:0.8,C:legendary}Legendary{s:0.8}{}',
                    '{C:inactive}(Can only hold one Blocky){}'
                }
            },
            j_BfJ_david = {
                name = 'David',
                text = {
                    '{E:2}Aw, seriously!{}'
                }
            },
            j_BfJ_rocky = {
                name = 'Rocky',
                text = {
                    'When {C:attention}Blind{} is selected, {C:green}#1# in #2#{}',
                    'chance to add a random {C:attention}playing{}',
                    '{C:attention}card{} with a random {C:attention}seal{}, {C:attention}edition{}',
                    'and {C:attention}enhancement{} to your hand'
                }
            },
            j_BfJ_teardrop = {
                name = 'Teardrop',
                text = {
                    'If {C:attention}poker hand{} is a',
                    '{C:attention}Five of a Kind{} that',
                    'contains a {C:blue}Club{}, create',
                    'a random {C:spectral}Spectral{} card',
                    '{C:inactive}(Must have room){}'
                }
            },
            j_BfJ_snowball = {
                name = 'Snowball',
                text = {
                    'Create {C:attention}2{} {C:dark_edition}Negative{} {C:tarot}Tarot{}',
                    'cards if poker hand',
                    'contains an {C:attention}Ace{} and',
                    'a {C:attention}Straight Flush{}'
                }
            },
            j_BfJ_eraser = {
                name = 'Eraser',
                text = {
                    "{C:attention}Destroys{} all cards",
                    "held in hand",
                    "at the end",
                    "of each {C:attention}round{}"
                }
            },
            j_BfJ_tennisball = {
                name = 'Tennis Ball',
                text = {
                    'If first hand of round',
                    'is a {C:attention}#1#{}, a',
                    'random {C:attention}seal{} is',
                    'applied to that card'
                }
            },
            j_BfJ_woody = {
                name = 'Woody',
                text = {
                    'Create a {C:tarot}Tarot{}, {C:planet}Planet{},',
                    'or {C:spectral}Spectral{} card when',
                    '{C:attention}Blind{} is selected',
                    '{C:inactive}(Must have room)'
                }
            },
            j_BfJ_purpleface = {
                name = 'Purple Face',
                text = {
                    "On {C:attention}first{} hand of round,",
                    "adds {C:purple}Purple{} seals",
                    "to all played and scored",
                    "cards without {C:attention}seals{}"
                }
            },
            j_BfJ_flower = {
                name = 'Flower',
                text = {
                    'This Joker gains {C:chips}+#2#{}',
                    'Chips at the end',
                    'of each {C:attention}round{}',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}'
                }
            },
            j_BfJ_profily = {
                name = 'Profily',
                text = {
                    "Copies the ability",
                    "of the {C:attention}Blueprint{}",
                    "to the right"
                }
            },
            j_BfJ_pen = {
                name = 'Pen',
                text = {
                    'If {C:attention}poker hand{} is a {C:attention}Royal Flush{}',
                    'create a copy of {C:tarot}The Hanged Man{}',
                    'and {C:tarot}Death{} and convert all cards',
                    '{C:attention}held in hand{} to the played {C:attention}suit{}',
                    '{C:inactive}(Must have room){}'
                }
            },
            j_BfJ_coiny = {
                name = 'Coiny',
                text = {
                    'Gives {X:mult,C:white}X#1#{} Mult',
                    'for each {C:hearts}Heart{} card',
                    '{s:0.7,C:inactive}(only real ones will get this){}',
                    'in your {C:attention}full deck{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}'
                }
            },
            j_BfJ_pin = {
                name = 'Pin',
                text = {
                    '{C:attention}Doubles{} the reward money',
                    'given by defeated {C:attention}Blinds{},',
                    'but {C:attention}doubles{} their',
                    '{C:red}score requirements{} too'
                }
            },
            j_BfJ_firey = {
                name = 'Firey',
                text = {
                    "If {C:attention}first discard{} of round",
                    "has only {C:attention}1{} card, destroy",
                    "it and gain {C:mult}+#2#{} Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}"
                }
            },
            j_BfJ_icecube = {
                name = 'Ice Cube',
                text = {
                    {
                        'Gain {C:blue}+#1#{} hands when',
                        'playing the {C:attention}second-last{}',
                        'hand of round'
                    },
                    {
                        'When triggered, {C:green}#2# in #3#{}',
                        'chance to {S:1.1,C:red,E:2}self destruct{}'
                    }
                }
            },
            j_BfJ_spongy = {
                name = 'Spongy',
                text = {
                    '{C:red}+#1#{} Mult',
                    'Creates a {C:dark_edition}Negative{}',
                    'copy of itself at the',
                    'end of the {C:attention}round{}'
                }
            },
            j_BfJ_spongy2 = {
                name = 'Spongy',
                text = {
                    '{C:red}+#1#{} Mult',
                    '{C:inactive}(Cannot produce duplicates){}'
                }
            },
            j_BfJ_pencil = {
                name = 'Pencil',
                text = {
                    'When a {C:planet}Planet{} card',
                    'is used, apply {C:attention}#1#{}',
                    'more hand levels',
                    '{C:red,E:2}self destructs{}'
                }
            },
            j_BfJ_needle = {
                name = 'Needle',
                text = {
                    {
                        'Played {C:attention}Steel Cards{}',
                        'give {X:mult,C:white}X#2#{} Mult',
                        'when scored'
                    },
                    {
                        'When {C:attention}Blind{} is selected,',
                        '{C:green}#3# in #4#{} chance to',
                        'give {C:blue}+#1#{} hands'
                    }
                }
            },
            j_BfJ_golfball = {
                name = 'Golf Ball',
                text = {
                    'Retrigger each',
                    'played {C:attention}Glass Card{}'
                }
            },
            j_BfJ_match = {
                name = 'Match',
                text = {
                    'This Joker gains {X:mult,C:white}X#2#{} Mult',
                    'for each played and',
                    'scored {C:hearts}Heart{} card',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
                }
            },
            j_BfJ_bubble = {
                name = 'Bubble',
                text = {
                    {
                        'This Joker gains {X:mult,C:white}X#2#{} Mult',
                        'at the {C:attention}end{} of every round',
                        '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
                    },
                    {
                        'At end of round,',
                        '{C:green}#3# in #4#{} chance to',
                        "{S:1.1,C:red,E:2}self destruct{}"
                    }
                }
            },
            j_BfJ_leafy = {
                name = 'Leafy',
                text = {
                    '{C:green}#1# in #2#{} chance',
                    'to retrigger any',
                    '{C:common}Common{} Jokers'
                }
            },
            j_BfJ_roottwo = {
                name = 'Root Two',
                text = {
                    'Played {C:attention}4s{} and {C:attention}9s{} give',
                    '{X:mult,C:white}X#1#{} Mult when scored'
                }
            },
            j_BfJ_tv = {
                name = 'TV',
                text = {
                    'Retrigger all',
                    '{C:uncommon}Uncommon{} Jokers',
                    '{C:inactive}(if compatible){}'
                }
            },
            j_BfJ_evilleafy = {
                name = 'Evil Leafy',
                text = {
                    {
                        'After {C:attention}scoring{}, each scored',
                        'card has a {C:green}#2# in #3#{} chance',
                        'to be {C:red}destroyed{}'
                    },
                    {
                        'Cards {C:red}destroyed{} by this',
                        'Joker add a {C:attention}tenth{} of',
                        "their ranks to its {X:mult,C:white}Xmult{}",
                        '{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult){}'
                    }
                }
            },
            j_BfJ_yellowface = {
                name = 'Yellow Face',
                text = {
                    {
                        'All items in shop are {C:attention}#1#%{} off'
                    },
                    {
                        'When {C:attention}Boss Blind{} is defeated,',
                        'creates a free {C:red}Coupon Tag{}'
                    }
                }
            },
            j_BfJ_ruby = {
                name = 'Ruby',
                text = {
                    'When {C:attention}Blind{} is selected, {C:green}#9# in #10#{} chance to add',
                    "between {C:attention}10{} and {C:attention}30{} to this Joker's {C:chips}Chips{} or {C:mult}Mult{}",
                    'or between {C:attention}1{} and {C:attention}3{} to its {X:mult,C:white}XMult{} or {C:money}end of round money{}',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult, {C:chips}+#2#{C:inactive} Chips, {X:mult,C:white}X#3#{C:inactive} Mult, {C:money}$#4#{C:inactive} bonus){}'
                }
            },
            j_BfJ_puffball = {
                name = 'Puffball',
                text = {
                    '{C:red}Disables{} all',
                    '{C:attention}Boss Blinds{} that',
                    '{C:red}debuff{} cards'
                }
            },
            j_BfJ_gelatin = {
                name = 'Gelatin',
                text = {
                    'Earn {C:money}$#1#{} at the',
                    'end of the round',
                    'and {C:attention}increase{} this',
                    'value by {C:money}$#2#{}'
                }
            },
            j_BfJ_fries = {
                name = 'Fries',
                text = {
                    'When {C:attention}Blind{} is defeated,',
                    'creates a random {C:attention}Tag{}',
                    '{s:0.7,C:inactive}(Get digging! The Tags are{}',
                    '{s:0.7,C:inactive}probably underground.){}'
                }
            },
            j_BfJ_dora = {
                name = 'Dora',
                text = {
                    {
                        'This Joker gains {X:mult,C:white}X#2#{} Mult',
                        'for each played and',
                        'scored {C:attention}Stone{} card',
                        '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
                    },
                    {
                        'Each played {C:attention}Stone{} card has',
                        'a {C:green}#4# in #5#{} chance to be {C:red}destroyed{},',
                        "increasing this Joker's",
                        '{X:mult,C:white}XMult{} gain by {X:mult,C:white}X#3#{} Mult'
                    }
                }
            },
            j_BfJ_donut = {
                name = 'Donut',
                text = {
                    {
                        'Played {C:attention}10s{} give',
                        '{X:red,C:white}X#1#{} Mult when scored'
                    },
                    {
                        '{X:red,C:white}X#2#{} Mult if {C:purple}Four {}and {C:purple}X {}are held'
                    }
                }
            },
            j_BfJ_nickel = {
                name = 'Nickel',
                text = {
                    'Gives {C:chips}+#1#{} Chips for',
                    'each {C:spades}Spade{} card',
                    'in your {C:attention}full deck{}',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}'
                }
            },
            j_BfJ_book = {
                name = 'Book',
                text = {
                    {
                        'Retrigger each played',
                        '{C:attention}Lucky Card{}'
                    },
                    {
                        'Gives {C:mult}+#1#{} Mult',
                        'and {C:money}$#2#{} every time',
                        'a {C:attention}Lucky{} card',
                        'randomly triggers',
                        "{s:0.7,C:inactive}(Well I'm actually a{}",
                        "{s:0.7,C:inactive}Lucky Card handbook...){}"
                    }
                }
            },
            j_BfJ_bomby = {
                name = 'Bomby',
                text = {
                    'Every played {C:attention}card{}',
                    'permanently gains',
                    '{C:red}+#1#{} Mult when scored'
                }
            },
            j_BfJ_one = {
                name = 'One',
                text = {
                    'If played hand is a',
                    '{C:attention}#3#{}, {C:red}destroys{} both cards',
                    'and {C:attention}gains{} {X:chips,C:white}X#2#{} Chips',
                    '{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips){}'
                }
            },
            j_BfJ_two = {
                name = 'Two',
                text = {
                    '{C:green}^#1#{} Mult'
                }
            },
            j_BfJ_four = {
                name = 'Four',
                text = {
                    'This Joker gains {X:mult,C:white}X#2#{} Mult',
                    'if played hand has',
                    'exactly {C:attention}4{} cards',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
                }
            },
            j_BfJ_x = {
                name = 'X',
                text = {
                    'Gives a {C:attention}random{}',
                    'multiplier between',
                    '{X:mult,C:white}X#1#{} and {X:mult,C:white}X#2#{} Mult'
                }
            },
            j_BfJ_announcer = {
                name = 'Announcer',
                text = {
                    'If {C:attention}poker hand{} contains a',
                    '{C:attention}Flush{} of {V:1}#2#s{}, make each',
                    'scored card {C:dark_edition}Polychrome{} and {C:attention}Lucky{}',
                    '{s:0.8}suit changes at end of round{}'
                }
            }
        },
        Planet = {
            c_BfJ_algebra = {
                name = 'Equation Playground',
                text = {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}2763{}",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                }
            }
        },
    },
    misc = {
        dictionary = {
            BfJ_active = "active",
            BfJ_inactive = "inactive",
        },
        poker_hands = {
            ["BfJ_twosevensixthree"] = "2763",
        },
        poker_hand_descriptions = {
            ["BfJ_twosevensixthree"] = {
                "A 2, 7, 6 and 3 of any suit.",
                "They may be in any order"
            }
        },
        v_dictionary = {
            a_discards = "+#1# Discards",
            s_discards = "-#1# Discards",
            a_discard = "+#1# Discard",
            s_discard = "-#1# Discard",
        }
    }
}
