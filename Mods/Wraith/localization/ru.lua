return {
    descriptions = {
        Joker = {
            j_wrt_themoon = {
                name = "Луна",
				text = {
					'Каждая использованная {C:planet}Планета{}',
					'имеет шанс{C:green,E:1}#1# из #2#{}',
					'быть дублированной',
					'{C:inactive,s:0.8}Если не выше ур.101{}'
				},
				
				unlock = {
					"?????"
				}
            },
			
			j_wrt_watercooler = {
                name = "Кулер для воды",
				text = {
					'{X:mult,C:white}X#1#{} множ.{}, умножается на {X:mult,C:white}X#2#{}{}',
					'когда {C:attention}Вода{} повержена',
				},
				
				unlock = {
					"?????"
				}
            },
			
			j_wrt_wraithJ = {
				name = "Призрак",
				text = {
					'Этот Джокер дает {C:mult}+#2#{} множ.',
					'когда продается карта',
					'{C:inactive}(Сейчас {C:mult}+#1#{C:inactive} множ.)'
				}
			},
			j_wrt_vouchJok = {
				name = "Ваучер Джокер",
				text = {
					'{C:attention}+1{} слот для ваучера',
					'доступен в магазине'
				}
			},
			j_wrt_nothJok = {
				name = "Ничего",
				text = {
					'{C:inactive}Ничего не делает?'
				}
			},
			j_wrt_smhJok = {
				name = "Что-то",
				text = {
					'{X:mult,C:white}X#1#{} множ.{} если сыгранная рука',
					'содержит карту'
				}
			},
			j_wrt_fallSun = {
				name = "Падающее солнце",
				text = {
					'{X:mult,C:white}X#2#{} множ.{} если {C:attention}засчитанная рука',
					'содержит больше {C:attention}#1#{} карт' 
				},
				
				unlock = {
					'Сыграйте руку которая содержит',
					'больше {C:attention}5{} карт'
				}
			},
			j_wrt_taxman = {
				name = "Сборщик налогов",
				text = {
					'Прокатные {C:attention}джокеры{} теперь берут',
					'{C:gold}#1#${}, и дают {X:mult,C:white}X#2#{} множ.{}' 
				}
			},
			
			j_wrt_light = {
				name = "Светлый джокер",
				text = {
					'Когда {C:attention}#1#{} {C:inactive}(#2#){} карт засчитано',
					'этот джокер дает на {X:mult,C:white}X#3#{} множ. больше{}',
					'{C:inactive}(Сейчас {X:mult,C:white}X#4#{} {C:inactive}множ.{})'
				}
			},
			
			j_wrt_golden = {
				name = "Золотой джокер",
				text = {
					'Игральные карты дают',
					'{C:gold}$#1#{} когда засчитаны'
				}
			},
        },
		
		Back = {
			b_wrt_tarot = {
				name = "Колода Таро",
				text = {
					"Начните с ваучером {C:tarot, T:v_tarot_merchant}Торговец Таро,",
					"{C:attention}+1{} слот для расходуемых предметов"
				},
				
				unlock = {
					"Разблокируйте все карты {C:tarot}Таро"
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
            a_mult="+#1# множ.",
            a_mult_minus="-#1# множ.",
            a_remaining="#1# Remaining",
            a_sold_tally="#1#/#2# Sold",
            a_xmult="X#1# множ.",
            a_xmult_minus="-X#1# множ.",
        }
    }
}