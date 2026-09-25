extends CanvasLayer

const ESCENA_MENU = preload("res://Escenas/menu.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_packed(ESCENA_MENU)
