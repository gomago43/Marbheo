extends Node
const SAVEFILE = "user://SAVEFILE.save"

var HORDA_MAX = 0

# Called when the node enters the scene tree for the first time.
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



#func _process(delta):
	#pass
