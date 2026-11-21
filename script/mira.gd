extends Sprite2D

@export var limites_mundo := Rect2(Vector2(0, 0), Vector2(1152, 648)).grow(-6.5)

func _process(_delta: float) -> void:
	var pos: Vector2 = get_global_mouse_position()
	pos.x = clamp(pos.x, limites_mundo.position.x, limites_mundo.end.x)
	pos.y = clamp(pos.y, limites_mundo.position.y, limites_mundo.end.y)
	global_position = pos
