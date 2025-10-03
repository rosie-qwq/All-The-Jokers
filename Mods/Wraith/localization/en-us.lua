return {
    descriptions = {
        Joker = {
            j_wrt_themoon = {
                name = "The Moon",
				text = {
					'Every used {C:planet}Planet{} card',
					'has a {C:green,E:1}#1# іn #2#{} chance',
					'to be duplicated',
					'{C:inactive,s:0.8}Unless higher lvl.101{}'
				},
				
				unlock = {
					"?????"
				}
            },
			
			j_wrt_watercooler = {
                name = "Watercooler",
				text = {
					'{X:mult,C:white}X#1#{} Mult{}, multiplied by {X:mult,C:white}X#2#{}{}',
					'when {C:attention}The Water{} is beaten'
				},
				
				unlock = {
					"?????"
				}
            },
			
			j_wrt_wraithJ = {
				name = "Wraith",
				text = {
					'This Joker gains {C:mult}+#2#{} Mult',
					'when a card is sold',
					'{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
				}
			},
			j_wrt_vouchJok = {
				name = "Voucher Joker",
				text = {
					'{C:attention}+#1#{} Voucher slot',
					'available in shop'
				}
			},
			j_wrt_nothJok = {
				name = "Nothing",
				text = {
					'{C:inactive}Does nothing?'
				}
			},
			j_wrt_smhJok = {
				name = "Something",
				text = {
					'{X:mult,C:white}X#1#{} Mult{} if played hand',
					'contains a card'
				}
			},
			j_wrt_fallSun = {
				name = "Falling Sun",
				text = {
					'{X:mult,C:white}X#2#{} Mult{} if {C:attention}scored hand',
					'contains more than {C:attention}#1#{} cards'
				},
				
				unlock = {
					"Play a hand that contains",
					"more than {C:attention}5{} cards"
				}
			},
			
			j_wrt_taxman = {
				name = "Taxman",
				text = {
					'Rental {C:attention}Jokers{} now take',
					'{C:gold}$#1#{}, and give {X:mult,C:white}X#2#{} Mult{}' 
				}
			},
			
			j_wrt_light = {
				name = "Light Joker",
				text = {
					'When {C:attention}#1#{} {C:inactive}(#2#){} cards are scored',
					'this Joker gains {X:mult,C:white}X#3#{} Mult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{} {C:inactive}Mult{})'
				}
			},
			
			j_wrt_golden = {
				name = "Golden Joker",
				text = {
					'Playing cards give', 
					'{C:gold}$#1#{} when scored'
				}
			},
        },
		
		Back = {
			b_wrt_tarot = {
				name = "Tarot Deck",
				text = {
					"Start with {C:tarot, T:v_tarot_merchant}Tarot Mechant,",
					"{C:attention}+1{} consumeable slot"
				},
				
				unlock = {
					"Discover all {C:tarot}Tarot{} cards"
				}
			}
		}
    },
    misc = {
        dictionary = {
            a_chips="+#1#",
            a_chips_minus="-#1#",
            a_hands="+#1# Hands",
            a_handsize="+#1# Hand Size",
            a_handsize_minus="-#1# Hand Size",
            a_mult="+#1# Mult",
            a_mult_minus="-#1# Mult",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# Mult",
            a_xmult_minus="-X#1# Mult",
        }
    }
}