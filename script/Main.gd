extends Node

@onready var zombie = get_node("Zombie")

var ordas : int
var dificultad: float
var aumento_dificultad : float = 1.2
var vidas : int
var max_enemigos : int 
var enemigos : int 
var HORDA_MAX : int
var NUEVA_ORDA : bool
var GAME_OVER : bool


func _ready():
	HORDA_MAX = Save.HORDA_MAX
	Musica.music_player.stop()
	$musica.play()
	volver_a_jugar()
	$GameOver/Button.pressed.connect(volver_a_jugar)
	$GameOver/Button2.pressed.connect(salir_menu)
	$GameOver/Button3.pressed.connect(salir_juego)
	$Pausa/Button.pressed.connect(resume)
	$Pausa/Button2.pressed.connect(salir_menu)
	$Pausa/Button3.pressed.connect(salir_juego)
func salir_juego():
	get_tree().quit()

func salir_menu():
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")

func volver_a_jugar():
	ordas = 1
	vidas = 1
	dificultad = 10.0
	max_enemigos = 10
	GAME_OVER = false
	$Spawner/Timer.wait_time = 1.0
	$Jugador.start()
	get_tree().call_group("objetos", "queue_free")
	get_tree().paused = false
	reset()

func reset():
	NUEVA_ORDA = false
	$inicio.play()
	max_enemigos = int(dificultad)
	enemigos = max_enemigos
	$Jugador.reset()
	get_tree().call_group("enemigos", "queue_free")
	get_tree().call_group("balas", "queue_free")
	$HUD/Vidas.text = "X " +str(vidas)
	$HUD/nOrda.text = ": " + str(ordas)
	$HUD/Enemigos.text = "X " + str(max_enemigos)
	$GameOver.hide()


#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey:
		#if event.keycode == KEY_ESCAPE:
			#resume()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && !GAME_OVER:
		resume()

func resume():
	get_tree().paused = not get_tree().paused
	$Pausa.visible = get_tree().paused
	if get_tree().paused:
		get_viewport().set_input_as_handled()


func _process(_delta):
	if orda_acabada():
		ordas += 1
		dificultad *= aumento_dificultad
		zombie.objeto += 0.01
		if ordas % 5 == 0 and aumento_dificultad > 1:
			aumento_dificultad -= 0.01
		if $Spawner/Timer.wait_time > 0.25:
			$Spawner/Timer.wait_time -= 0.05
		reset()
	if ordas-1 > Save.HORDA_MAX:
		Save.HORDA_MAX = ordas-1
		Save.save_data()


#func _process(_delta):
	#if orda_acabada():
	##enemigos == 0:
		#ordas += 1
		#dificultad *= aumento_dificultad
		#if $Spawner/Timer.wait_time > 0.25:
			#$Spawner/Timer.wait_time -= 0.05
		#nueva_orda()
		#
		##if (NUEVA_ORDA):
			##$Orda.start()
			##print("empezado")
			##NUEVA_ORDA = false
		##else:
			##NUEVA_ORDA = true
		##reset()

	#if ordas-1 > Save.HORDA_MAX:
		#Save.HORDA_MAX = ordas-1
		#Save.save_data()

func _on_bala_hit_z():
	enemigos -= 1
	$HUD/Enemigos.text = "X " + str(enemigos)

func _on_spawner_hit_p():
	$"vida-1".play()
	vidas -= 1
	$HUD/Vidas.text = "X " + str(vidas)
	if vidas <= 0:
		get_tree().paused = true
		$GameOver/Ordas2.text = str(ordas- 1)
		$GameOver.show()
		GAME_OVER = true



func orda_acabada():
	var muertos = true
	var enemigos = get_tree().get_nodes_in_group("enemigos")
	if enemigos.size() == max_enemigos:
		for i in enemigos:
			if i.vivo:
				muertos = false
		return muertos
	else: 
		return false
