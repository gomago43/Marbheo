extends Node2D

var music_player: AudioStreamPlayer

func _ready():
	get_tree().paused = false
	$maxima.text = "Max: " + str(Save.HORDA_MAX)
	music_player = Musica.music_player
	
	if not music_player.playing:
			Musica.music_player.play()

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Escenas/Main.tscn")

func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/opciones.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Escenas/tutorial.tscn")

func _on_salir_pressed():
	get_tree().quit()
