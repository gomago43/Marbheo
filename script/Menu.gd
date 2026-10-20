extends Node2D

const JUEGO = preload("res://Escenas/Main.tscn")

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
	
	#Texto ampliado que ocupa toda la pantalla
	var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_label.tween_property($Label, "scale", Vector2(4.0, 4.0), 3.0)
	
	#var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#var tween_fondo = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#
	##Texto ampliado hasta el maximo
	#tween_label.tween_property($Label, "scale", Vector2(15.0, 15.0), 3.0)
	
	##Fondo ampliado
	#tween_fondo.tween_property($Sprite2D, "scale", Vector2(1.2, 1.2), 12)
	
	await tween_label.finished
	
	get_tree().change_scene_to_packed(JUEGO)
