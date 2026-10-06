extends OptionButton

func _ready():
	clear()
	
	add_item(tr("English"), 0)
	add_item(tr("Español"), 1)
	
	if TranslationServer.get_locale().begins_with("es"):
		selected = 1 # Español
	else:
		selected = 0 # Inglés

func _on_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("en")
	elif index == 1:
		TranslationServer.set_locale("es")
