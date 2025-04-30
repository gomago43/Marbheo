extends Node2D

@export var bala_scene : PackedScene

signal hit_z

func _on_jugador_shoot(pos, dir):
	$disparo.play()
	var bala = bala_scene.instantiate()
	add_child(bala)
	
	bala.position = pos
	bala.direction = ( get_local_mouse_position() - bala.position).normalized()
	bala.rotation = bala.direction.angle()
	bala.add_to_group("balas")
	bala.hit_zombie.connect(hit)

func hit():
	hit_z.emit()
