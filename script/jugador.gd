extends CharacterBody2D

@onready var move_joystick = $"Joystick/Virtual Joystick"
@onready var shoot_joystick = $ShootJoystick

@export var casquillo_scene: PackedScene

signal shoot

const START_SPEED : int = 200
const COCACOLA_SPEED : int = 400
const START_SHOOT: float = 0.5
const PISTOLA_SHOOT : float = 0.15

var speed : int
var can_shoot : bool
var screen_size : Vector2
var input_dir = Vector2.ZERO
var shoot_direction = Vector2.ZERO
var damaged : bool = false

func _ready():
	screen_size = get_viewport_rect().size
	reset()

func _on_joystick_moved(dir):
	input_dir = dir

func start():
	reset()
	position = screen_size/2

func reset():
	can_shoot = true
	speed = START_SPEED
	$Cooldown.wait_time = START_SHOOT
	
	
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot and not get_tree().paused:
		disparar()

func disparar():
	can_shoot = false
	$Cooldown.start()
	
	var mouse_pos = get_global_mouse_position()
	var dir = mouse_pos - position
	shoot.emit(position, dir)
	
	var cam = get_viewport().get_camera_2d()
	if cam and cam.has_method("apply_shake"):
		cam.apply_shake(5.0)
	
	if casquillo_scene != null:
		var casquillo = casquillo_scene.instantiate() as RigidBody2D
		get_tree().current_scene.add_child(casquillo)
		
		var angulo_disparo = dir.angle()
		var offset = Vector2(10, 0).rotated(angulo_disparo)
		casquillo.global_position = global_position + offset
		casquillo.global_rotation = angulo_disparo
		
		var direccion_expulsion = Vector2.RIGHT.rotated(angulo_disparo + PI / 2)
		casquillo.apply_central_impulse(direccion_expulsion * randf_range(80.0, 130.0))
		casquillo.apply_torque_impulse(randf_range(-40.0, 40.0))

func get_input():
	var dir := Input.get_vector("left", "right", "up", "down")
	
	input_dir = dir
	velocity = input_dir.normalized() * speed


func _physics_process(_delta):
	get_input()
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI/4)/(PI/4)
	angle = wrapi(int(angle), 0, 3)
	
	if not damaged:
		$AnimatedSprite2D.animation = "andar" + str(angle)
		
		if velocity.length() > 0:
			$AnimatedSprite2D.play()
			$GPUParticles2D.emitting = true
		else :
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.frame = 0
			$GPUParticles2D.emitting = false

func cocacola():
	$objeto.play()
	$Cocacola.start()
	speed = COCACOLA_SPEED

func pistola():
	$objeto.play()
	$Pistola.start()
	$Cooldown.wait_time = PISTOLA_SHOOT

func medicina():
	$objeto.play()

func _on_cooldown_timeout():
	can_shoot = true


func _on_cocacola_timeout():
	speed = START_SPEED


func _on_pistola_timeout():
	$Cooldown.wait_time = START_SHOOT

func _on_main_damage() -> void:
	damaged = true
	$AnimatedSprite2D.play("daño")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "daño":
		damaged = false
