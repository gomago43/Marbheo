extends Camera2D

@export var target: Node2D 
@export var smooth_speed: float = 5.0 

var shake_intensity: float = 0.0
var shake_decay: float = 15.0

func _process(delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position, smooth_speed * delta)
	
	
	if shake_intensity > 0:
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		shake_intensity = move_toward(shake_intensity, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO

func apply_shake(amount: float) -> void:
	shake_intensity = amount
