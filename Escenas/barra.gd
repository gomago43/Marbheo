extends ProgressBar

var tween: Tween

func barra():
	if tween and tween.is_valid():
		tween.kill()
	
	value = 100
	show()
	
	tween = create_tween()
	tween.tween_property(self, "value", 0.0, 4.0)
	await tween.finished
	
	hide()
