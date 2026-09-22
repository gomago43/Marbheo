extends AudioStreamPlayer2D

func play_with_fade_out():
	volume_db = 9.97
	play()
	
	await get_tree().create_timer(1.5).timeout
	
	var tween = create_tween()
	tween.tween_property(self, "volume_db", 0.0, 0.5)
	
	await tween.finished
	stop()
