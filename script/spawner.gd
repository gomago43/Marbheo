extends Node2D

@onready var main = get_node("/root/Main")

var zombie_scene := preload("res://Escenas/zombie.tscn")
var spawn_points := []

signal hit_p

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout():
	var enemigos = get_tree().get_nodes_in_group("enemigos")
	if enemigos.size() < get_parent().max_enemigos:
		var spawn = spawn_points[randi() % spawn_points.size()]
		var zombie = zombie_scene.instantiate()
		zombie.position = spawn.position
		zombie.hit_player.connect(hit)
		main.add_child(zombie)
		zombie.add_to_group("enemigos")

func hit():
	hit_p.emit()
