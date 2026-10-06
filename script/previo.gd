extends CanvasLayer

func _ready() -> void:
	
	await get_tree().create_timer(1.2).timeout
	
	get_tree().change_scene_to_file("res://Escenas/Main.tscn")
