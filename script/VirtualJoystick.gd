extends CanvasLayer
#
#@onready var base = $Base
#@onready var stick = $Stick
#
#var joystick_radius = 64
#var center_position = Vector2()
#var input_vector = Vector2()
#var active_touch_id = -1
#var pressed : bool = false
#
#signal joystick_moved(direction: Vector2)
#
#func _ready():
	#
	#if OS.get_name() != "Android":
		#self.visible = false
	#
	#await get_tree().process_frame
	#
	#center_position = base.get_global_rect().position + base.get_global_rect().size / 2
	#center_position =  center_position + Vector2(17.5,17.5)
	#_reset_stick()
#
#
#func _unhandled_input(event):
	#if event is InputEventScreenTouch:
		#if event.pressed:
			#if base.get_global_rect().has_point(event.position) and active_touch_id == null:
				#active_touch_id = event.index
		#else:
			#if event.index == active_touch_id:
					#active_touch_id = null
					#_reset_stick()
					#emit_signal("joystick_moved", Vector2.ZERO)
#
	#elif event is InputEventScreenDrag:
		#if event.index == active_touch_id:
			#var dir = event.position - center_position
			#if dir.length() > joystick_radius:
				#dir = dir.normalized() * joystick_radius
#
			#stick.global_position = center_position + dir - stick.size / 2.0
			#input_vector = dir / joystick_radius
			#emit_signal("joystick_moved", input_vector)
#
#func _input(event):
	#if event is InputEventScreenTouch:
		#if event.pressed and is_point_in_joystick(event.position):
			#active_touch_id = event.index
		#elif not event.pressed and event.index == active_touch_id:
			#active_touch_id = -1
#
##func is_touch_on_joystick(touch_index: int) -> bool:
	##if Input.get_current_mouse_button_mask() != 0:
		##return _is_touch_inside(get_global_mouse_position())
	##return touch_index == active_touch_id
	#
	#
#func _reset_stick():
	#stick.global_position = center_position - stick.size / 2.0
	#input_vector = Vector2.ZERO
##
#func is_touch_on_joystick(touch_index: int) -> bool:
	#return touch_index == active_touch_id
#
#func is_point_in_joystick(point: Vector2) -> bool:
	#var base_rect = base.get_global_rect()
	#return base_rect.has_point(point)
#
##func _on_button_button_down():
	##pressed = true
##
##func _on_button_button_up():
	##pressed = false
#
#
#
##func _process(_delta):
	##if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		##var global_mouse = get_viewport().get_mouse_position()
		##var direction = global_mouse - center_position_position
##
		##if direction.length() > joystick_radius:
			##direction = direction.normalized() * joystick_radius
##
		##stick.global_position = center_position_position + direction - stick.size / 2
		##input_vector = direction / joystick_radius
##
		##emit_signal("joystick_moved", input_vector)
	##else:
		##_reset_stick()
		##emit_signal("joystick_moved", Vector2.ZERO)
##
##func _reset_stick():
	##stick.global_position = center_position_position - stick.size / 2
	##input_vector = Vector2.ZERO
##
