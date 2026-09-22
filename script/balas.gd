extends Area2D

var speed : int = 750
var direction : Vector2

signal hit_zombie

func _process(delta):
	position += speed * direction * delta

func _ready():
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.name == "Jugador": 
		return
		
	if body is TileMapLayer or body.name == "World":
		queue_free()
	elif body.has_method("muerte"):
		body.muerte()
		queue_free()
		emit_signal("hit_zombie")
