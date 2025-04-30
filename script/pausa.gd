#extends CanvasLayer
#
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("pause"):
		#queue_free()
#
#
#func _notification(what):
	#match what:
			#NOTIFICATION_ENTER_TREE:
				#get_tree().paused = true
			#NOTIFICATION_EXIT_TREE:
				#get_tree().paused = false
#extends Control  # ⚠️ IMPORTANTE: este script debe estar en el nodo Control del menú de pausa
#
#func _ready():
	#set_process_unhandled_input(true)  # Permite que el menú reciba input aunque el juego esté pausado
	#visible = false  # Ocultar el menú al inicio
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("pause"):
		#toggle_pause()
#
#func toggle_pause():
	#get_tree().paused = not get_tree().paused
	#visible = get_tree().paused
#
	#if get_tree().paused:
		#get_viewport().set_input_as_handled()
		
#extends Control  # Este script debe estar en el nodo Control del menú de pausa
#
#func _ready():
	#set_process_unhandled_input(true)  # Asegura que este menú reciba los inputs
	#$Button.pressed.connect(resume_game)  # Conectar el botón de reanudar
	#$Button2.pressed.connect(exit_game)  # Conectar el botón de salir
#
## Este input captura cualquier tecla que no haya sido manejada
#func _unhandled_input(event: InputEvent) -> void:
	### Si presionamos 'Esc', reanudamos el juego
	#if event is InputEventKey and event.keycode == KEY_ESCAPE:
		#resume_game()
##
## Función para reanudar el juego
#func resume_game():
	#get_tree().paused = false  # Despausa el juego
	#visible = false  # Oculta el menú de pausa
#
## Función para salir al menú principal (o lo que prefieras)
#func exit_game():
	#get_tree().paused = false  # Despausa el juego
	#get_tree().change_scene("res://menu_principal.tscn") 
