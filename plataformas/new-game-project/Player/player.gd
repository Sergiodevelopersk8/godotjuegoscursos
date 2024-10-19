extends CharacterBody2D
class_name Player

var speed := 120
var direccion := 0.0
const jump := 250
var gravity := 9
var damage = 1
var vida := 10 : 
	set(val):
		vida = val
		$PlayerGUI/HPProgressBar.value = vida
var numSaltos =  2
var canDash = true
@onready var anim = $AnimationPlayer
@onready var sprite :=$Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RayCastDmg
@onready var state_machine = $StateMachine
@onready var dmgColision := $RecibirDanio/CollisionShape2D



func _ready():
	$PlayerGUI/HPProgressBar.value = vida
	Global.player = self


func _process(delta):
	
	$LabelState.text = $StateMachine.state.name
	if is_on_floor() and numSaltos != 2 and state_machine.state.name != "enAire":
		reiniciarSalto()
	#leer los raycast
	
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Enemigos") and colision.has_method("takeDmg"):
					colision.takeDmg(damage)
					state_machine.transition_to("enAire",{Salto = true})
					numSaltos += 1
	if is_on_floor():
		canDash = true


func reiniciarSalto():
	numSaltos = 2


func actualizaInterfazFrutas():
	frutaslabel.text = ("x" + str(Global.frutas))
#
func takeDamage(dmg):
	
	vida -= dmg
	state_machine.transition_to("takeDamage")
	
	if vida <= 0:
		morir()
	#
#
#
func morir():
	get_tree().reload_current_scene()

#
