return {
    descriptions = {
        Joker = {
            j_fmod_generator = {
                name = "Generador",
                text = {
                        "Reactiva todas las {C:attention}cartas jugadas{},",
                        "{C:red}destruye{} el consumible más a la {C:attention}izquierda{}",
                        "cuando comienza la ronda",
                        "{C:red}Se destruye{} si ningún consumible",
                        "puede destruirse"
                },
            },
            j_fmod_fennex = {
                name = "Fennex",
                text = {
                    "Cada {C:attention}#1#{} renovaciones, agrega",
                    "un {C:attention}Vale{} a la tienda",
                    "{C:inactive,s:0.8}(#2# restantes)"
                }
            },
            j_fmod_terminal_velocity = {
                name = "Caida libre",
                text = {
                    "Las cartas {C:attention}versátiles{} ganan",
                    "para siempre {X:mult,C:white}X#1#{} multi cuando anotan"
                }
            },
            j_fmod_low_hanging_fruit = {
                name = "Fruta a tu alcance",
                text = {
                    "Cada {C:attention}6{} o {C:attention}9 jugado",
			        "otorga {C:mult}+#2#{} multi y",
			        "{C:chips}+#1#{} fichas cuando anota"
                }
            },
            j_fmod_nerdcubed = {
                name = "Cuatro ojos",
                text = {
                    "Cada {C:attention}3{} jugado",
			        "se reactiva {C:attention}3{} veces"
                }
            },
            j_fmod_penny_joker = {
                name = "Comodín Penny",
                text = {
                    "Este comodín obtiene {C:chips}+2 fichas{} por",
			        "cada carta anotada.",
                    "{C:inactive}(Actual {C:chips}+#1#{C:inactive} fichas)"
                }
            },
            j_fmod_countdown = {
                name = "Cuenta regresiva",
                text = {
                    "El próximo {C:attention}#1#{} que anota otorga",
			        "{C:mult}+#2#{} multi, y disminuye el requisito de categoría en 1.",
                    "Cuando un {C:attention}#3#{} anota, otorga {X:mult,C:white}X#4#{}",
                    "multy y se restablece a {C:attention}Rey{}"
                }
            },
            j_fmod_despicable_bear = {
                name = "Mi oso favorito",
                text = {
                    "Las manos de {C:attention}Doble par{} son",
                    "consideradas como {C:attention}Póker{}",
                    "si la mano jugada tiene exáctamente {C:attention}4{} cartas",
                }
            },
            j_fmod_nerothefool = {
                name = "Neró el tonto",
                text = {
                    "Si la {C:attention}primera{} mano de la ronda",
                    "tiene exáctamente {C:attention}2{} cartas,",
                    "destrúyelas"
                }
            },
            j_fmod_negativejoker = {
                name = "Comodín negativo",
                text = {
                    "{C:chips}+#1#{} Fichas, se vuelve",
                    "{C:attention}Negativo{} después de {C:attention}#2#{} rondas",
                    "{C:inactive}(Rondas restantes: {C:attention}#3#{C:inactive})",
                }
            },
            j_fmod_passport = {
                name = "Pasaporte",
                text = {
                    "{C:mult}+#1#{} multi por cada",
                    "{C:attention}mano de póker{} única jugada",
                    "{C:inactive}(Actual: {C:mult}+#2#{C:inactive} multi)",
                }
            },
            j_fmod_steve = {
                name = "Steve",
                text = {
                    "Creates un {C:attention}comodín{} {C:dark_edition}Negativo{} de",
                    "{C:attention}comida{} al inicio de la ronda",
                }
            },
            j_fmod_blue_angel_mushroom = {
                name = "Hongo Ángel Azul",
                text = {
                    "Si se queda sin manos",
                    "otorga {C:red}+1{} mano y continua la ronda",
                    "Se destruye después de {C:attention}#1#{} usos",
                    "{C:inactive}(Usos restantes: {C:attention}#2#{C:inactive})",
                }
            },
            j_fmod_impractical_joker = {
                name = "Bromista improvisado",
                text = {
                    "La primera carta con la",
                    "{C:attention}categoría más baja{} jugada",
                    "otorga {X:mult,C:white}X#1#{} multi",
                    "cuando anota"
                }
            },
            j_fmod_ferromancy = {
                name = "Ferromancia",
                text = {
                    "Las cartas de {C:attention}Oro{} otorgan {X:mult,C:white}X#1#{} multi",
                    "mientras estén en tu mano, mientras que",
                    "las cartas de {C:attention}Acero{} otorga {C:money}$#2#{}",
                    "al final de la ronda",
                    "{C:inactive}(Reemplaza el comportamiento original)"
                }
            },
            j_fmod_jazzercise = {
                name = "Comodín Jazzercista",
                text = {
                    "{C:attention}+#1#{} de tamaño de mano por cada {C:attention}#2# {C:inactive}[#3#]",
                    "cartas destruidas en esta partida",
                    "{C:inactive}(Actual {C:attention}+#4#{C:inactive})"
                }
            },
            j_fmod_pomni = {
                name = "Pomni",
                text = {
                    "Después de omitir {C:attention}#2#{} ciegas, {C:attention}-#1#{} Apuesta inicial",
                    "{C:green}#3# en #4#{} probabilidades de {C:attention}-#5#{} apuestas iniciales",
                    "{C:inactive}(Actual {C:attention}#6#{C:inactive}/#2#)"
                }
            },
            j_fmod_loonette = {
                name = "Loonette",
                text = {
                    "Las cartas {C:attention}numéricas{} otorgan {X:mult,C:white}X#1#{} multi cuando",
                    "anotan, aumenta por {X:mult,C:white}X#2#{} multi por",
                    "cada carta {C:attention}numérica{} consecutiva que anota",
                    "{C:inactive}(Se reestablece después de jugar una mano)"
                }
            }
        },
        Tag = {
            tag_fmod_appraisal = {
                name = "Etiqueta de valoración",
                text = {
                    "Otorga {C:money}$#1#{} por cada {C:attention}carta{}",
                    "{C:attention}mejorada{} en tu baraja completa",
                    "{C:inactive}(Otorgará {C:money}$#2#{C:inactive})"
                }
            },
            tag_fmod_lunchbreak = {
                name = "Etiqueta de almuerzo",
                text = {
                    "Crea un {C:attention}comodín de comida{}",
                    "{C:dark_edition}Negativo{}"
                }
           },
            tag_fmod_boost = {
                name = "Etiqueta potenciadora",
                text = {
                    "Agrega 2 {C:attention}Paquetes potenciadores{}",
                    "{C:attention}gratis",
                    "a la próxima tienda"
                }
            },
            tag_fmod_goofy = {
                name = "Etiqueta tonta",
                text = {
                    "Otorga un",
                    "{V:1}Paquete tontillo Mega{} gratis"
                }
            }
        },
        Blind = {
            bl_fmod_hoard = {
                name = "La reserva",
                text = {
                    "Todas las cartas numéricas",
                    "boca abajo"
                }
            },
            bl_fmod_tool = {
                name = "La herramienta",
                text = {
                    "Todos los consumibles",
                    "son debilitados"
                }
            },
            bl_fmod_baby = {
                name = "El bebé",
                text = {
                    "Todas las cartas mejoradas",
                    "boca abajo"
                }
            },
            bl_fmod_priest = {
                name = "El sacerdote",
                text = {
                    "No puedes jugar más",
                    "de 4 cartas"
                }
            },
            bl_fmod_dice = {
                name = "El dado",
                text = {
                    "Todas las probablidades",
                    "caen en cero"
                }
            },
            bl_fmod_final_sword = {
                name = "Espada de marfil",
                text = {
                    "No puedes jugar",
                    "#1#"
                }
            },
            bl_fmod_light = {
                name = "La luz",
                text = {
                    "Las cartas mejoradas jugadas",
                    "pierden sus mejoras"
                }
            },
            bl_fmod_elder = {
                name = "El anciano",
                text = {
                    "Todas las cartas no mejoradas",
                    "boca abajo"
                }
            },
            bl_fmod_flux = {
                name = "El flujo",
                text = {
                    "Dos palos aleatorios",
                    "son debilitados en cada mano",
                }
            },
            bl_fmod_flux_alt = {
                name = "El flujo",
                text = {
                    "Dos palos aleatorios",
                    "son debilitados en cada mano",
                    "(#1# y #2#)"
                }
            },
            bl_fmod_final_shield = {
                name = "Escudo de azafrán",
                text = {
                    "Todos los #1#s son",
                    "debilitados"
                }
            },
            bl_fmod_final_horn = {
                name = "Cuerno de lavanda",
                text = {
                    "Todas las cartas",
                    "boca abajo"
                }
            }
        },
        Back = {
            b_fmod_recursive = {
                name = "Baraja recursiva",
                text = {
                    "Los {C:attention}comodines{}, cartas de {C:tarot}Tarot{}, {C:planet}Planeta{},",
                    "y {C:spectral}Espectrales{} pueden",
                    "aparecer varias veces",
                }
            },
            b_fmod_fennex = {
                name = "Baraja Fennex",
                text = {
                    "Comienza la partida con el comodín {C:attention,T:j_fmod_fennex}Fennex{},",
                    "Los {C:attention}comodines{} {C:legendary}Lucky Rabbit{C:attention} son ",
                    "{X:green,C:white}3X{} veces más probables de aparecer"
                }
            },
            b_fmod_clown = {
                name = "Baraja de payaso",
                text = {
                    "Comienza la partida con",
                    "el vale {V:1,T:v_fmod_circus}#1#{}"
                }
            },
            b_fmod_reaper = {
                name = "Baraja mortal",
                text = {
                    "Cada ciega jefe es una {C:attention}Ciega jefe{}",
                    "{C:attention}FINAL{} con {X:mult,C:white,s:1.2}X2{} {C:red}tamaño base{}",
                    "{C:chips}+1{} mano, {C:red}+1{} descarte, {C:chips}+1{} de tamaño",
                    "de mano, {C:attention}+1{} ranura de comodín"
                }
            },
            b_fmod_harmony = {
                name = "Baraja armónica",
                text = {
                    "Todas las cartas en tu baraja",
                    "comparten misma {C:attention}categoría{} y {C:attention}palo{}",
                    "{C:red}-2{} Descartes"
                }
            }
        },
        Silly = {
            c_fmod_pie = {
                name = "Pie",
                text = {
                    "Selecciona {C:attention}#1#{} cartas, copia la {C:attention}categoría",
                    "de la carta {C:attention}izquierda{} a la carta {C:attention}derecha{}"
                }
            },
            c_fmod_clown_car = {
                name = "Auto de payaso",
                text = {
                    "Crea un comodín {C:dark_edition}Negativo{}"
                }
            },
            c_fmod_bang_gun = {
                name = "Arma falsa",
                text = {
                    "Selecciona {C:attention}#1#{} cartas, copia el {C:attention}palo",
                    "de la carta {C:attention}izquierda{} a la carta {C:attention}derecha{}"
                }
            },
            c_fmod_squirt_flower = {
                name = "Flor lanza agua",
                text = {
                    "Selecciona {C:attention}#1#{} cartas, copia el {C:attention}sello",
                    "de la carta {C:attention}izquierda{} a la carta {C:attention}derecha{}"
                }
            },
            c_fmod_whoopie_cushion = {
                name = "Bolsa de aire",
                text = {
                    "Selecciona {C:attention}#1#{} cartas, copia la",
                    "{C:attention}mejora{} de la carta {C:attention}izquierda",
                    "a la carta {C:attention}derecha{}"
                }
            },
            c_fmod_joy_buzzer = {
                name = "Apretón eléctrico",
                text = {
                    "Selecciona {C:attention}#1#{} cartas, copia",
                    "la {C:dark_edition}edición{} de la carta {C:attention}izquierda",
                    "a la carta {C:attention}derecha{}"
                }
            },
            c_fmod_midway_games = {
                name = "Juegos al paso",
                text = {
                    "Otorga una etiqueta {C:attention}Estándar{},",
                    "{C:tarot}Encantada{}, {C:planet}Meteoro{},",
                    "o de {C:inactive}Bufón{}"
                }
            },
            c_fmod_juggler = {
                name = "Malabarista",
                text = {
                    "Otorga {C:money}$#1#{}. Aumenta",
                    "por +{C:money}$#2#{} cada vez",
                    "que una carta malabarista es",
                    "usada en esta partida"
                }
            },
            c_fmod_balloons = {
                name = "Globos",
                text = {
                    "Duplica el {C:chips}valor de fichas{}",
                    "de todas las manos que tienes en tu mano"
                }
            },
            c_fmod_split_pants = {
                name = "Pantalones rotos",
                text = {
                    "Disminuye la categoría",
                    "de hasta {C:attention}#1#{} cartas",
                    "seleccionadas por {C:attention}1",
                }
            },
            c_fmod_balloon_animal = {
                name = "Animalillo de globo",
                text = {
                    "Otorga {C:money}$#1#{} por cada",
                    "{C:attention}categoría{} única en tu mano",
                    "{C:inactive}(Actual {C:money}$#2#{C:inactive})"
                }
            },
            c_fmod_soully = {
                name = "El almilla",
                text = {
                    "Crea un comodín {C:legendary,E:1}Legendario{}",
                    "del mod Lucky Rabbit",
                    "{C:inactive}(Debe haber espacio)"
                }
            },
            c_fmod_tightrope = {
                name = "Cuerda floja",
                text = {
                    "{C:green}1 en 2{} probabilidades de crear",
                    "{C:attention}1{} copia de {C:attention}1{} carta seleccionada",
                    "{C:green}1 en 4{} probabilidades de crear",
                    "{C:attention}2{} copias",
                    "{C:green}1 en 4{} probabilidades de {C:red}destruir{}",
                    "la carta seleccionada",
                    "{C:inactive}(Las probablidades no pueden alterarse)"
                }
            },
            c_fmod_fire_breath = {
                name = "Aliento de fuego",
                text = {
                    "Destruye un {C:attention}comodín{} seleccionado",
                    "y copia su {C:dark_edition}edición{} al",
                    "{C:attention}comodín{} de su derecha"
                }
            },
            c_fmod_rodeo = {
                name = "Rodeo",
                text = {
                    "Selecciona {C:attention}#1#{} cartas. a una carta aleatoria",
                    "se le agregará {C:dark_edition}Laminado{}, {C:dark_edition}Holográfico{},",
                    "o {C:dark_edition}Policromo{}, y la otra",
                    "se {C:attention}destruirá"
                }
            },
            c_fmod_endless_scarf = {
                name = "Bufanda infinita",
                text = {
                    "{C:attention}+#1#{} tamaño de mano",
                    "en la siguiente, o actual, ronda"
                }
            },
            c_fmod_knife_throw = {
                name = "Lanzamiento de cuchillo",
                text = {
                    "Selecciona hasta {C:attention}#1#{} cartas,",
                    "a cada carta seleccionada",
                    "se le agregará un {C:attention}sello{}",
                    "aleatorio, o se destruirá"
                }
            },
            c_fmod_trapeze = {
                name = "Trapeze",
                text = {
                    "Despúes de usar esta carta",
                    "{C:attention}#2#{} veces, su próxima aparición",
                    "será reemplazada por la carta {C:attention}El alma{}",
                    "{C:inactive}(Actual {C:attention}#1#{C:inactive}/#2#)"
                }
            }
        },
        Voucher = {
            v_fmod_circus = {
                name = "Circo",
                text = {
                    "Las {V:1}cartas tontillas{} pueden",
                    "aparecer en cualquier",
                    "Paquete {C:tarot}Arcano{}"
                }
            },
            v_fmod_showtime = {
                name = "Hora del show",
                text = {
                    "Las {V:1}cartas tontillas{} pueden",
                    "comprarse en",
                    "la {C:attention}tienda{}"
                }
            },
            v_fmod_reroll_superfluity = {
                name = "Superfluidad de renovación",
                text = {
                    "Las renovaciones solo",
                    "aumentan de precio {C:attention}cada",
                    "{C:attention}otra{} renovación"
                }
            },
            v_fmod_buffet = {
                name = "Buffet",
                text = {
                    "Gana para siempre",
                    "otras {C:blue}+#1#{}",
                    "manos por ronda"
                }
            },
            v_fmod_dumpster_ritual = {
                name = "Barco basurero",
                text = {
                    "Gana para siempre",
                    "otros {C:red}+#1#{}",
                    "descartes cada ronda"
                }
            },
            v_fmod_anti_higgs_boson = {
                name = "Bosón de Higgs",
                text = {
                    "{C:dark_edition}+1{} Ranura de comodín extra",
                    "El vale {C:inactive}En blanco{} y {C:dark_edition}Antimateria{}",
                    "pueden volver a aparecer en la tienda"
                }
            },
            v_fmod_big_bang = {
                name = "Big Bang",
                text = {
                    "{C:attention}-#1#{} Apuestas iniciales,",
                    "{C:attention}-#2#{} de tamaño de mano"
                }
            },
            v_fmod_color_swatches = {
                name = "Muestras de color",
                text = {
                    "Gana para siempre",
                    "otros",
                    "{C:attention}+#1#{} de tamaño de mano"
                }
            },
            v_fmod_fire_sale = {
                name = "Oferta única",
                text = {
                    "{C:attention}+#1#{} ranura de carta,",
                    "{C:attention}+#2#{} ranura de paquete",
                    "disponible en la tienda",
                }
            },
            v_fmod_coupon = {
                name = "Cupón",
                text = {
                    "{C:attention}+#1#{} ranura de consumible"
                }
            },
            v_fmod_extreme_couponing = {
                name = "Cupón extremo",
                text = {
                    "{C:attention}+#1#{} ranura de consumible adicional"
                }
            },
            v_fmod_shopaholic = {
                name = "Adicto a las compras",
                text = {
                    "Agrega un {C:attention}paquete potenciador{}",
                    "{C:attention}gratis{} extra",
                    "a la tienda"
                }
            }
        },
        Other = {
            p_fmod_silly_small = {
                name = "Paquete tontillo",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_small_2 = {
                name = "Paquete tontillo",
                text = {
                     "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_small_3 = {
                name = "Paquete tontillo",
                text = {
                     "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_small_4 = {
                name = "Paquete tontillo",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_jumbo = {
                name = "Paquete tontillo Jumbo",
                text = {
                     "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_jumbo_2 = {
                name = "Paquete tontillo Jumbo",
                text = {
                     "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_mega = {
                name = "Paquete tontillo Mega",
                text = {
                     "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
            p_fmod_silly_mega_2 = {
                name = "Paquete tontillo Mega",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "{C:attention}#2# cartas {V:1}tontillas{} para",
                    "usar de inmediato"
                }
            },
        }
    },
    misc = {
        dictionary = {
            k_fmod_fuel = "Recargado!",
            k_fmod_drained = "Agotado!",
            k_fmod_sillypack = "Paquete tontillo",
            r_fmod_mostplayed = "(Categoría más jugada)"
        }
    }
}