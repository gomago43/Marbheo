extends CanvasLayer


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")


func _on_option_button_item_selected(index):
	match index:
		0: 
			TranslationServer.set_locale("es")
		1:
			TranslationServer.set_locale("en")
