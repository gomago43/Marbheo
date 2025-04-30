extends Area2D

@onready var main = get_node("/root/Main")
@onready var vidas = get_node("/root/Main/HUD/Vidas")

var objeto_type : int

var cocacola = preload("res://Zombie Apocalypse Tileset/Organized separated sprites/Shootable Coke Can Animation Frames/Zombie-Tileset---_0346_Capa-347.png")
var vida = preload("res://Zombie Apocalypse Tileset/Organized separated sprites/Pickable Items and Weapons/Zombie-Tileset---_0340_Capa-341.png")
var pistola = preload("res://Zombie Apocalypse Tileset/Organized separated sprites/Pickable Items and Weapons/Zombie-Tileset---_0344_Capa-345.png")
#"res://Zombie Apocalypse Tileset/Organized separated sprites/Pickable Items and Weapons/Zombie-Tileset---_0343_Capa-344.png"
#bala doble
var cajas = [cocacola, vida, pistola]

func _ready():
	$Sprite2D.texture = cajas[objeto_type]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if objeto_type == 0:
		body.cocacola()
	elif  objeto_type == 1:
		body.medicina()
		main.vidas += 1
		vidas.text = "X " + str(main.vidas)
	elif objeto_type == 2:
		body.pistola()
	queue_free()
