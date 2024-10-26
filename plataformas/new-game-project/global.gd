extends Node
signal fruitCollected
var frutas := 0 : 
	set(val):
		frutas = val
		emit_signal("fruitCollected")
		$frutasSonido.play()
	get:
		return frutas
