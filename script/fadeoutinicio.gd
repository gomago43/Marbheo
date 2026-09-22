extends AudioStreamPlayer2D

func play_with_fade_out():
	volume_db = 9.97 # Restablece el volumen a su nivel normal (0 dB)
	play()
	
	# Espera 1.5 segundos a volumen normal
	await get_tree().create_timer(1.5).timeout
	
	# Crea un Tween para bajar el volumen a -80 dB en los últimos 0.5 segundos
	var tween = create_tween()
	tween.tween_property(self, "volume_db", 0.0, 0.5)
	
	# Detiene el audio cuando termina el desvanecimiento
	await tween.finished
	stop()
