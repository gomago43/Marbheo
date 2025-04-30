extends CharacterBody2D


@onready var main = get_node("/root/Main")
@onready var jugador = get_node("/root/Main/Jugador")

var objeto_scene := preload("res://Escenas/Objeto.tscn")

var vivo : bool
var entered : bool
var speed : int = 100
var direction : Vector2
@export var objeto : float = 0.2

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

func muerte():
	vivo = false
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.animation = "muerte"
	$AnimatedSprite2D.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	if randf() <= objeto:
		drop_item()

func drop_item():
	var objeto = objeto_scene.instantiate()
	objeto.position = position
	objeto.objeto_type = randi_range(0,2)
	main.call_deferred("add_child", objeto)
	objeto.add_to_group("objetos")


func _on_timer_timeout():
	entered = true

func _on_area_2d_body_entered(_body):
	hit_player.emit()
