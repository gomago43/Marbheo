extends CharacterBody2D


@onready var main = get_node("/root/Main")
@onready var jugador = get_node("/root/Main/Jugador")

var objeto_scene := preload("res://Escenas/Objeto.tscn")

var vivo : bool
var entered : bool
var speed : int = 100
var direction : Vector2
var sonido : int
@export var probobjeto : float = 0.2
@export var sonidos_zombie: Array[AudioStream] = [] 
@export_range(0.0, 1.0) var probabilidad_sonido: float = 0.20
@export var cooldown_min: float = 3.5
@export var cooldown_max: float = 6

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var intervalo_chequeo: float = 2.0 

var _acumulador_tiempo: float = 0.0
var _puede_sonar: bool = true
signal hit_player


func _ready():
	var screen_rect = get_viewport_rect()
	entered = false
	vivo = true

	var dist = screen_rect.get_center() - position

	if abs(dist.x) > abs(dist.y):
		direction.x = dist.x
		direction.y = 0
	else:
		direction.x = 0
		direction.y = dist.y

func _physics_process(_delta):
	if vivo:
		$AnimatedSprite2D.animation = "andar"
		$AnimatedSprite2D.play()

		if entered:
			direction = (jugador.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()

		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		pass

func _process(delta: float) -> void:
	_acumulador_tiempo += delta
	if _acumulador_tiempo >= intervalo_chequeo:
		_acumulador_tiempo = 0.0
		try_sound()

func muerte():
	vivo = false
	$AnimatedSprite2D.stop()
	$AudioStreamPlayer2D.stop()
	$AnimatedSprite2D.animation = "muerte"
	$AnimatedSprite2D.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	$muerte.play()
	z_index = -2
	if randf() <= probobjeto:
		drop_item()

func drop_item():
	var objeto = objeto_scene.instantiate()
	objeto.position = position
	objeto.objeto_type = randi_range(0,2)
	main.call_deferred("add_child", objeto)
	objeto.add_to_group("objetos")

func try_sound() -> void:
	if not _puede_sonar or sonidos_zombie.is_empty() or !vivo:
		return

	if randf() <= probabilidad_sonido:
		var sonido_elegido: AudioStream = sonidos_zombie.pick_random()
		audio_player.stream = sonido_elegido
		
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()

		_puede_sonar = false
		var tiempo_espera := randf_range(cooldown_min, cooldown_max)
		await get_tree().create_timer(tiempo_espera).timeout
		_puede_sonar = true


func _on_timer_timeout():
	entered = true

func _on_area_2d_body_entered(_body):
	hit_player.emit()
