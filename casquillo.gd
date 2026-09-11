extends RigidBody2D

func _ready():
	await get_tree().create_timer(1.5).timeout
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	
	await tween.finished
	queue_free()
