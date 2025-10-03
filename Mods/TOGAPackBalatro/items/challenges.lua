sendInfoMessage("Loading Challenges...", "TOGAPack")

SMODS.Challenge{
    key = 'jokerful',
    rules = {
		custom = {
            { id = 'toga_noplayedscore' },
            { id = 'toga_nohandscore' },
        },
		modifiers = {
            { id = 'joker_slots', value = 7 },
        },
	},
}