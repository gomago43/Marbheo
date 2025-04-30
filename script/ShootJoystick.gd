extends CanvasLayer
#
#signal aim_changed(direction: Vector2)
#signal shoot_held(direction: Vector2)
#signal shoot_released()
#
#@onready var base := $Base
#@onready var stick = $Stick
#
#var joystick_radius = 64.0
#var center_position = Vector2()
#var input_vector = Vector2.ZERO
#var active_touch_id = null
#
#func _ready():
	#if OS.get_name() != "Android":
		#self.visible = false
	#
	#await get_tree().process_frame
	##center_position = base.global_position + base.size / 2.0
	#center_position = base.get_global_rect().position + base.get_global_rect().size / 2
	#center_position =  center_position + Vector2(17.5,17.5)
	#_reset_stick()
#
#func _unhandled_input(event):
	#if event is InputEventScreenTouch:
		#if event.pressed:
			#if base.get_global_rect().has_point(event.position) and active_touch_id == null:
				#active_touch_id = event.index
#
		#else:
			#if event.index == active_touch_id:
				#active_touch_id = null
				#_reset_stick()
				#emit_signal("aim_changed", Vector2.ZERO)
				#emit_signal("shoot_released")
#
	#elif event is InputEventScreenDrag and event.index == active_touch_id:
		#var dir = event.position - center_position
		#if dir.length() > joystick_radius:
			#dir = dir.normalized() * joystick_radius
#
		#stick.global_position = center_position + dir - stick.size / 2.0
		#input_vector = dir / joystick_radius
		#emit_signal("aim_changed", input_vector)
		#emit_signal("shoot_held", input_vector)
#
#func _reset_stick():
	#stick.global_position = center_position - stick.size / 2.0
	#input_vector = Vector2.ZERO
#
#func is_touch_on_joystick(touch_index: int) -> bool:
	#return touch_index == active_touch_id
