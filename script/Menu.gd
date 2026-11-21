extends Node2D

var juego : PackedScene = null
const TUTORIAL = preload("res://Escenas/tutorial.tscn")

var music_player: AudioStreamPlayer

func _ready():
	get_tree().paused = false
	$maxima.text = "Max: " + str(Save.HORDA_MAX)
	music_player = Musica.music_player
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Camera2D.position = get_viewport_rect().size / 2
	if not music_player.playing:
			Musica.music_player.play()

func _on_jugar_pressed():
	await _start()
	if juego == null:
		juego = load("res://Escenas/Main.tscn")
	get_tree().change_scene_to_packed(juego)
	#get_tree().change_scene_to_file("res://Escenas/Main.tscn")

func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")

func _on_tutorial_pressed():
	#get_tree().change_scene_to_file("res://Escenas/tutorial.tscn")
	get_tree().change_scene_to_packed(TUTORIAL)

func _on_salir_pressed():
	get_tree().quit()

func _start():
	$intro.play()
	music_player.stop()
	$VBoxContainer.hide()
	$VBoxContainer2.hide()
	$VBoxContainer3.hide()
	$VBoxContainer4.hide()
	$maxima.hide()
	$Label.hide()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	#$Label.pivot_offset = $Label.size / 2
	
	#Texto ampliado que ocupa toda la pantalla
	#var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween_label.tween_property($Label, "scale", Vector2(4.0, 4.0), 2)

	#var tween_label = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tween_fondo = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	##Texto ampliado hasta el maximo
	#tween_label.tween_property($Label, "scale", Vector2(15.0, 15.0), 3.0)
	
	##Fondo ampliado
	tween_fondo.tween_property($Camera2D, "zoom", Vector2(2.5, 2.5), 3.0)
	tween_fondo.parallel().tween_property($Camera2D, "position", Vector2(600, 475), 2.0)
	
	#await tween_label.finished
	await tween_fondo.finished
	
	
