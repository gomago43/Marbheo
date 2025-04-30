extends HSlider

@export
var nombre : String

var indice : int

func _ready() -> void:
	indice = AudioServer.get_bus_index(nombre)
	value_changed.connect(valor_cambiado)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(indice)
	)

func valor_cambiado(valor: float) -> void:
	AudioServer.set_bus_volume_db(
		indice,
		linear_to_db(value)
	)
	
