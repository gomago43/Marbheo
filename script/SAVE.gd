extends Node
const SAVEFILE = "user://SAVEFILE.save"

var HORDA_MAX = 0

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open(SAVEFILE , FileAccess.READ)
	if file == null: 
		save_data()
	else:
		HORDA_MAX = file.get_var()
	file = null

func save_data():
	var file = FileAccess.open(SAVEFILE ,FileAccess.WRITE)
	file.store_var(HORDA_MAX)
	file = null
