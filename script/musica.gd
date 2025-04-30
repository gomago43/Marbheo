extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	music_player.stream = preload("res://musica/MUSICA_MENU.mp3")
	music_player.bus = "musica"
	music_player.play()
	var current_scene = get_tree().current_scene.name

func _exit_tree():
	if music_player and music_player.playing:
		music_player.stop()
