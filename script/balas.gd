extends Area2D

var speed : int = 750 #igual mejor en 1000
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
	if body.name == "World":
		queue_free()
	else :
		if body.vivo:
			body.muerte()
			queue_free()
			hit_zombie.emit()
