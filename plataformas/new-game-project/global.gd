extends Node
signal fruitCollected
var frutas := 0 : 
	set(val):
		frutas = val
		emit_signal("fruitCollected")
		$frutasSonido.play()
	get:
		return frutas

var vidas : int

func _ready():
	await Save.ready
	vidas = Save.game_data.VidasJugador
