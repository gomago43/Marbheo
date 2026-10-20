extends Node2D

var music_player: AudioStreamPlayer

func _ready():
	get_tree().paused = false
	$maxima.text = "Max: " + str(Save.HORDA_MAX)
	music_player = Musica.music_player
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if not music_player.playing:
			Musica.music_player.play()

func _on_jugar_pressed():
	_start()
	preload("res://Escenas/Main.tscn")

func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Escenas/tutorial.tscn")

func _on_salir_pressed():
	get_tree().quit()

func _start():
	$VBoxContainer.hide()
	$VBoxContainer2.hide()
	$VBoxContainer3.hide()
	$VBoxContainer4.hide()
	$maxima.hide()
	
	$Label.pivot_offset = $Label.size / 2
	
	#var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween_label.tween_property($Label, "scale", Vector2(4.0, 4.0), 3.0)
	
	var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween_fondo = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween_label.tween_property($Label, "scale", Vector2(15.0, 15.0), 3.0)
	
	#await get_tree().create_timer(1.5).timeout
	
	tween_fondo.tween_property($Sprite2D, "scale", Vector2(5.0, 5.0), 1.5)
	
	await tween_label.finished
	
	get_tree().change_scene_to_file("res://Escenas/Main.tscn")
