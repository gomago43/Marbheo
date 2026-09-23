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

signal damage


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
	$inicio.play_with_fade_out()
	max_enemigos = int(dificultad)
	enemigos = max_enemigos
	$Jugador.reset()
	get_tree().call_group("enemigos", "queue_free")
	get_tree().call_group("balas", "queue_free")
	$HUD/Vidas.text = "X " +str(vidas)
	$HUD/nOrda.text = ": " + str(ordas)
	$HUD/Enemigos.text = "X " + str(max_enemigos)
	$GameOver.hide()
	$Mira.show()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && !GAME_OVER:
		resume()

func resume():
	get_tree().paused = not get_tree().paused
	$Pausa.visible = get_tree().paused
	if get_tree().paused:
		$Mira.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_viewport().set_input_as_handled()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		$Mira.show()

func _process(_delta):
	if orda_acabada():
		ordas += 1
		dificultad *= aumento_dificultad
		zombie.probobjeto += 0.01
		$CambioHorda.modulate.a = 0.0
		$CambioHorda.show()
		var tween_flash = create_tween()
		tween_flash.tween_property($CambioHorda, "modulate:a", 1.0, 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween_flash.tween_property($CambioHorda, "modulate:a", 0.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		mostrar_texto_horda(ordas, $Horda)
		if ordas % 5 == 0 and aumento_dificultad > 1:
			aumento_dificultad -= 0.01
		if $Spawner/Timer.wait_time > 0.25:
			$Spawner/Timer.wait_time -= 0.05
		reset()
	if ordas-1 > Save.HORDA_MAX:
		Save.HORDA_MAX = ordas-1
		Save.save_data()

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
		$gameover.play()
		GAME_OVER = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$Mira.hide()
	else: 
		damage.emit()

func orda_acabada():
	var muertos = true
	var enemigo = get_tree().get_nodes_in_group("enemigos")
	if enemigo.size() == max_enemigos:
		for i in enemigo:
			if i.vivo:
				muertos = false
		return muertos
	else: 
		return false

func mostrar_texto_horda(numero_horda: int, label_horda: Label):
	label_horda.text = tr("dial14") + " " + str(numero_horda)
	label_horda.scale = Vector2(3.5, 3.5)
	label_horda.modulate.a = 0.0
	label_horda.visible = true
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(label_horda, "scale", Vector2(2.0, 2.0), 0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(label_horda, "modulate:a", 1.0, 0.3)
	
	await get_tree().create_timer(1.2).timeout
	
	var tween_out = create_tween()
	tween_out.tween_property(label_horda, "modulate:a", 0.0, 0.5)
