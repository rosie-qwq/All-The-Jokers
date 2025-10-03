return {
    descriptions = {
        Joker = {
            j_fmod_generator = {
                name = "发生器",
                text = {
                        "重新触发",
                        "所有{C:attention}已打出的牌{}",
                        "{C:red}摧毁{}{C:attention}最左侧{}的消耗品",
                        "若无可摧毁的消耗品",
                        "在回合开始时{C:red}自毁{}"
                },
            },
            j_fmod_fennex = {
                name = "幸运兔",
                text = {
                    "每{C:attention}#1#{}次重掷",
                    "添加一张",
                    "{C:attention}优惠券{}到商店",
                    "{C:inactive,s:0.8}(剩余#2#次触发)"
                }
            },
            j_fmod_terminal_velocity = {
                name = "终端速度",
                text = {
                    "打出的{C:attention}万能牌{}",
                    "永久获得{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_fmod_low_hanging_fruit = {
                name = "唾手可得的果实",
                text = {
                    "每次打出的{C:attention}6{}或{C:attention}9",
			        "计分时获得",
			        "{C:mult}+#2#{}倍率 {C:chips}+#1#{}筹码"
                }
            },
            j_fmod_nerdcubed = {
                name = "书呆子方块",
                text = {
                    "每次打出的{C:attention}3{}",
			        "将被重新触发{C:attention}3{}次"
                }
            },
            j_fmod_penny_joker = {
                name = "便士小丑",
                text = {
                    "每张计分牌",
                    "获得{C:chips}+2筹码{}",
			        "{C:inactive}(当前{C:chips}+#1#{C:inactive}筹码)"
                }
            },
            j_fmod_countdown = {
                name = "倒计时",
                text = {
                    "下个记分的{C:attention}#1#{}",
			        "将获得{C:mult}+#2#{}倍率",
                    "且点数{C:attention}-1{}",
                    "当一张{C:attention}#3#{}计分后",
                    "获得{X:mult,C:white}X#4#{}倍率",
                    "且重置为{C:attention}K{}"
                }
            },
            j_fmod_despicable_bear = {
                name = "可憎熊",
                text = {
                    "打出的{C:attention}两对{}",
                    "恰好由{C:attention}4{}张牌组成",
                    "则视为{C:attention}四条{}"
                }
            },
            j_fmod_nerothefool = {
                name = "愚人尼禄",
                text = {
                    "若回合的{C:attention}第一手牌{}",
                    "恰好是{C:attention}2{}张牌",
                    "则摧毁它们"
                }
            },
            j_fmod_negativejoker = {
                name = "负片小丑",
                text = {
                    "{C:chips}+#1#{}筹码",
                    "在{C:attention}#2#{}回合后",
                    "变为{C:attention}负片{}{C:inactive}",
                    "{C:inactive,s:0.8}(剩余回合数:{C:attention}#3#"
                }
            },
            j_fmod_passport = {
                name = "通行证",
                text = {
                    "打出的每种",
                    "单独花色的{C:attention}游戏牌{}",
                    "提供{C:mult}+#1#{}倍率",
                    "{C:inactive}(当前:{C:mult}+#2#{C:inactive}倍率)"
                }
            },
            j_fmod_steve = {
                name = "史蒂夫",
                text = {
                    "每回合开始时",
                    "创建一张随机的",
                    "{C:dark_edition}负片{C:attention}食物{C:attention}小丑{}"
                }
            },
            j_fmod_blue_angel_mushroom = {
                name = "蓝色蘑菇",
                text = {
                    "若触发死亡事件",
                    "给予{C:red}+1{}次出牌并恢复回合",
                    "使用{C:attention}#1#{}次后自毁",
                    "{C:inactive}(剩余使用次数: {C:attention}#2#{C:inactive})",
                }
            },
            j_fmod_impractical_joker = {
                name = "搞怪小丑",
                text = {
                    "打出的牌中",
                    "点数{C:attention}最低{}的第一张牌",
                    "计分时提供{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_fmod_ferromancy = {
                name = "金属占卜",
                text = {
                    "手中持有的{C:attention}黄金{}牌",
                    "提供{X:mult,C:white}X#1#{}倍率",
                    "而{C:attention}钢铁{}牌在",
                    "回合结束时提供{C:money}$#2#{}",
                    "{C:inactive}(覆盖默认规则)"
                }
            },
            j_fmod_jazzercise = {
                name = "爵士小丑",
                text = {
                    "本局中每摧毁",
                    "{C:attention}#2#{C:inactive}[#3#]{}张牌",
                    "{C:attention}手牌上限+#1#{}",
                    "{C:inactive}(当前{C:attention}+#4#{C:inactive})"
                }
            },
            j_fmod_pomni = {
                name = "庞米",
                text = {
                    "跳过{C:attention}#2#{}个盲注后",
                    "{C:attention}底注-#1#{}",
                    "{C:green}#3#/#4#{}的概率使{C:attention}底注-#5#{}",
                    "{C:inactive}(当前{C:attention}#6#{C:inactive}/#2#)"
                }
            },
            j_fmod_loonette = {
                name = "卢内特",
                text = {
                    "{C:attention}数字{}牌计分时",
                    "提供{X:mult,C:white}X#1#{}倍率",
                    "每张连续计分的{C:attention}数字{}牌",
                    "提供{X:mult,C:white}X#2#{}倍率",
                    "{C:inactive}(出牌后重置)"
                }
            }
        },
        Tag = {
            tag_fmod_appraisal = {
                name = "评估标签",
                text = {
                    "完整牌组中的",
                    "每张{C:attention}强化{C:attention}卡牌",
                    "可以提供{C:money}$#1#{}",
                    "{C:inactive}(将获得{C:money}$#2#{C:inactive})"
                }
            },
            tag_fmod_lunchbreak = {
                name = "午休标签",
                text = {
                    "创建一张随机的",
                    "{C:dark_edition}负片{C:attention}食物小丑牌{}"
                }
            },
            tag_fmod_boost = {
                name = "强化标签",
                text = {
                    "为下一家商店",
                    "添加{C:attention}两个",
                    "免费的{C:attention}强化包{}"
                }
            },
            tag_fmod_goofy = {
                name = "高飞标签",
                text = {
                    "获得一个免费的",
                    "{V:1}超级愚蠢包{}"
                }
            }
        },
        Blind = {
            bl_fmod_hoard = {
                name = "宝藏堆",
                text = {
                    "所有数字牌",
                    "均为背面朝上抽取"
                }
            },
            bl_fmod_tool = {
                name = "工具盲注",
                text = {
                    "所有消耗品",
                    "均被减益"
                }
            },
            bl_fmod_baby = {
                name = "婴儿盲注",
                text = {
                    "所有强化卡牌",
                    "均为背面朝上抽取"
                }
            },
            bl_fmod_priest = {
                name = "牧师盲注",
                text = {
                    "出牌数量",
                    "不得超过4张"
                }
            },
            bl_fmod_dice = {
                name = "骰子盲注",
                text = {
                    "所有概率",
                    "降为零"
                }
            },
            bl_fmod_final_sword = {
                name = "象牙剑盲注",
                text = {
                    "无法打出",
                    "#1#"
                }
            },
            bl_fmod_light = {
                name = "光芒盲注",
                text = {
                    "打出的强化卡牌",
                    "失去强化效果"
                }
            },
            bl_fmod_elder = {
                name = "长者盲注",
                text = {
                    "所有未强化卡牌",
                    "均为背面朝上抽取"
                }
            },
            bl_fmod_flux = {
                name = "通量盲注",
                text = {
                    "每回合有两个",
                    "随机花色被减益"
                }
            },
            bl_fmod_final_shield = {
                name = "藏红花护盾盲注",
                text = {
                    "#1#",
                    "均被减益"
                }
            },
            bl_fmod_final_horn = {
                name = "薰衣草号角盲注",
                text = {
                    "所有卡牌",
                    "均背面朝上抽取"
                }
            }
        },
        Back = {
            b_fmod_recursive = {
                name = "递归牌组",
                text = {
                    "{C:attention}小丑牌{}、{C:tarot}塔罗牌{}",
                    "{C:planet}星球牌{}和{C:spectral}幽灵牌{}",
                    "可多次出现"
                }
            },
            b_fmod_fennex = {
                name = "幸运兔牌组",
                text = {
                    "游戏开始时",
                    "携带{C:attention,T:j_fmod_fennex}幸运兔{}小丑",
                    "{C:legendary}幸运兔模组{C:attention}小丑{}",
                    "出现概率{X:green,C:white}X3倍{}"
                }
            },
            b_fmod_clown = {
                name = "小丑牌组",
                text = {
                    "游戏开始时携带",
                    "{V:1,T:v_fmod_circus}#1#{}优惠券"
                }
            },
            b_fmod_reaper = {
                name = "收割者牌组",
                text = {
                    "每个BOSS盲注",
                    "都是一个{C:attention}终结盲注{}",
                    "{C:attention}盲注{}基础规模为{X:mult,C:white,s:1.2}2倍{}{C:red}",
                    "{C:chips}+1{}出牌、{C:red}+1{}弃牌",
                    "{C:chips}+1{}手牌上限",
                    "{C:attention}+1{}小丑牌槽位"
                }
            },
            b_fmod_harmony = {
                name = "和谐牌组",
                text = {
                    "牌组中的所有卡牌",
                    "具有相同的{C:attention}点数{}和{C:attention}花色{}",
                    "{C:red}-2{}弃牌"
                }
            }
        },
        Silly = {
            c_fmod_pie = {
                name = "派",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:attention}左侧{}牌的{C:attention}点数",
                    "复制到{C:attention}右侧{}牌上"
                }
            },
            c_fmod_clown_car = {
                name = "小丑车",
                text = {
                    "生成一张随机的",
                    "{C:dark_edition}负片{}{C:attention}小丑牌{}",
                    "每张拥有的{C:dark_edition}负片{}小丑牌{C:money}-$#1#{}",
                    "{C:inactive}(该小丑无{C:attention}出售价值{C:inactive})"
                }
            },
            c_fmod_bang_gun = {
                name = "砰砰枪",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:attention}左侧{}牌的{C:attention}花色",
                    "复制到{C:attention}右侧{}牌上"
                }
            },
            c_fmod_squirt_flower = {
                name = "喷水花",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:attention}左侧{}牌的{C:attention}蜡封",
                    "复制到{C:attention}右侧{}牌上"
                }
            },
            c_fmod_whoopie_cushion = {
                name = "放屁坐垫",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:attention}左侧{}牌的{C:attention}强化效果{}",
                    "复制到{C:attention}右侧{}牌上"
                }
            },
            c_fmod_joy_buzzer = {
                name = "电击器",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "将{C:dark_edition}左侧{}牌的{C:dark_edition}版本{}",
                    "复制到{C:attention}右侧{}牌上"
                }
            },
            c_fmod_midway_games = {
                name = "中途游戏",
                text = {
                    "获得一个{C:attention}标准标签{}、",
                    "{C:tarot}魅力标签{}、{C:planet}流星标签{}",
                    "或{C:inactive}小丑标签{}"
                }
            },
            c_fmod_juggler = {
                name = "杂耍者",
                text = {
                    "获得{C:money}$#1#{}",
                    "每次使用杂耍者牌时",
                    "增加{C:money}$#2#{}"
                }
            },
            c_fmod_balloons = {
                name = "气球",
                text = {
                    "将手中每张牌的",
                    "{C:chips}筹码{}翻倍"
                }
            },
            c_fmod_split_pants = {
                name = "破裤子",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "点数{C:attention}-1{}"
                }
            },
            c_fmod_balloon_animal = {
                name = "气球动物",
                text = {
                    "手中的每种单独{C:attention}点数{}",
                    "提供{C:money}$#1#{}",
                    "{C:inactive}(当前{C:money}$#2#{C:inactive})"
                }
            },
            c_fmod_soully = {
                name = "灵魂",
                text = {
                    "创建一张",
                    "幸运兔模组的",
                    "{C:legendary,E:1}传奇{}小丑",
                    "{C:inactive}(必须有槽位)"
                }
            },
            c_fmod_tightrope = {
                name = "走钢丝",
                text = {
                    "{C:green}1/2{}的概率创建",
                    "{C:attention}1张{}所选卡牌的副本",
                    "{C:green}1/4{}的概率创建",
                    "{C:attention}2{}张副本",
                    "{C:green}1/4{}的概率{C:red}摧毁{}",
                    "所选卡牌",
                    "{C:inactive}(概率无法改变)"
                }
            },
            c_fmod_fire_breath = {
                name = "喷火",
                text = {
                    "选择一张{C:attention}小丑牌{}摧毁",
                    "并将其{C:dark_edition}版本{}复制到",
                    "右侧的{C:attention}小丑牌{}上"
                }
            },
            c_fmod_rodeo = {
                name = "牛仔竞技",
                text = {
                    "选择{C:attention}#1#{}张牌",
                    "其中一张将获得",
                    "{C:dark_edition}闪箔{}、{C:dark_edition}镭射{}",
                    "或{C:dark_edition}多彩{}效果",
                    "另一张被{C:attention}摧毁"
                }
            },
            c_fmod_endless_scarf = {
                name = "无尽围巾",
                text = {
                    "手牌上限{C:attention}+#1#{}"
                }
            },
            c_fmod_knife_throw = {
                name = "飞刀",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "随机附加一个{C:attention}蜡封{}效果",
                    "或者将其{C:red}摧毁{}"
                }
            },
            c_fmod_trapeze = {
                name = "空中飞人",
                text = {
                    "此牌使用{C:attention}#2#{}次后",
                    "下次出现时",
                    "将被一张{C:attention}灵魂{}卡牌替换",
                    "{C:inactive}(当前{C:attention}#1#{C:inactive}/#2#)"
                }
            },
            c_fmod_greasepaint = {
                name = "油彩",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "用{C:attention}墨水{}标记"
                }
            },
            c_fmod_unicycle = {
                name = "独轮车",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "用{C:attention}折痕{}标记"
                }
            },
            c_fmod_cannon = {
                name = "加农炮",
                text = {
                    "选择最多{C:attention}#1#{}张牌",
                    "用{C:attention}针孔{}标记",
                }
            }
        },
        Voucher = {
            v_fmod_circus = {
                name = "马戏团",
                text = {
                    "{V:1}愚蠢卡牌{}可能",
                    "出现在任何",
                    "{C:tarot}塔罗牌{}牌组中"
                }
            },
            v_fmod_showtime = {
                name = "演出时刻",
                text = {
                    "{V:1}愚蠢卡牌{}可以",
                    "在{C:attention}商店{}中购买"
                }
            },
            v_fmod_reroll_superfluity = {
                name = "重掷过剩",
                text = {
                    "重掷价格仅在",
                    "{C:attention}每隔一次",
                    "重掷时增加"
                }
            },
            v_fmod_buffet = {
                name = "自助餐",
                text = {
                    "每回合永久获得",
                    "{C:blue}+#1#{}手牌上限"
                }
            },
            v_fmod_dumpster_ritual = {
                name = "垃圾桶仪式",
                text = {
                    "每回合永久获得",
                    "{C:red}+#1#{}弃牌次数"
                }
            },
            v_fmod_anti_higgs_boson = {
                name = "反希格斯玻色子",
                text = {
                    "额外增加{C:dark_edition}+1{}个小丑牌槽位",
                    "{C:inactive}空白{}和{C:dark_edition}反物质{}优惠券",
                    "将重新加入卡池",
                }
            },
            v_fmod_big_bang = {
                name = "大爆炸",
                text = {
                    "{C:attention}-#1#{}底注",
                    "{C:attention}-#2#{}手牌上限"
                }
            },
            v_fmod_color_swatches = {
                name = "色板",
                text = {
                    "永久{C:attention}+#1#{}",
                    "手牌上限"
                }
            },
            v_fmod_fire_sale = {
                name = "大甩卖",
                text = {
                    "商店中",
                    "{C:attention}+#1#{}卡牌槽位",
                    "{C:attention}+#2#{}卡包槽位"

                }
            },
            v_fmod_coupon = {
                name = "优惠券",
                text = {
                    "{C:attention}+#1#{}消耗品槽位"
                }
            },
            v_fmod_extreme_couponing = {
                name = "极限优惠券",
                text = {
                    "{C:attention}+#1#{}额外消耗品槽位"
                }
            },
            v_fmod_shopaholic = {
                name = "购物狂",
                text = {
                    "商店添加一个",
                    "{C:attention}免费的{C:attention}强化包{}"
                }
            }
        },
        Other = {
            p_fmod_silly_small = {
                name = "小型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_small_2 = {
                name = "小型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_small_3 = {
                name = "小型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_small_4 = {
                name = "小型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_jumbo = {
                name = "巨型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_jumbo_2 = {
                name = "巨型愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_mega = {
                name = "超级愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            p_fmod_silly_mega_2 = {
                name = "超级愚蠢包",
                text = {
                    "从最多{C:attention}#2#张{}",
                    "{V:1}愚蠢{}卡牌中",
                    "选择{C:attention}#1#{}张",
                    "立即使用"
                }
            },
            fmod_ink_mark = {
                name = "墨水标记",
                text = {
                    "此牌无法",
                    "再被{C:attention}翻转{}"
                }
            },
            fmod_crease_mark = {
                name = "折痕标记",
                text = {
                    "此牌在抽牌顺序中",
                    "优先位于{C:attention}顶部{}"
                }
            },
            fmod_pinhole_mark = {
                name = "针孔标记",
                text = {
                    "此牌在打出时",
                    "{C:attention}返回{}牌堆",
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_fmod_fuel = "充能完毕！",
            k_fmod_drained = "能量耗尽！",
            k_fmod_sillypack = "愚蠢包",
            r_fmod_mostplayed = "(最常使用的牌型)",
            k_fmod_config_restart = "重启后生效",
            k_fmod_config_jokers = "启用小丑牌",
            k_fmod_config_silly = "启用愚蠢卡牌",
            k_fmod_config_vouchers = "启用优惠券",
            k_fmod_config_blinds = "启用盲注",
            k_fmod_config_tags = "启用标签",
            k_fmod_config_decks = "启用牌组",
        },
        labels = {
            fmod_ink_mark = "墨水标记",
            fmod_crease_mark = "折痕标记",
            fmod_pinhole_mark = "针孔标记"
        },
    }
}