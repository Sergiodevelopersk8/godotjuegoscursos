extends CharacterBody2D
class_name Player

var speed := 120
var direccion := 0.0
const jump := 250
var gravity := 9
var damage = 1
var vidasMaximas = 10
var numSaltos =  2
var canDash = true
@onready var anim = $AnimationPlayer
@onready var sprite :=$Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RayCastDmg
@onready var state_machine = $StateMachine
@onready var dmgColision := $RecibirDanio/CollisionShape2D
@onready var hpbar := $PlayerGUI/HPProgressBar
@onready var gui_animation_player: AnimationPlayer = $PlayerGUI/GUIAnimationPlayer
@onready var vidas_label = $PlayerGUI/VidasHBoxContainer/VidasLabel



var vida := 3 : 
	set(val):
		vida = val
		hpbar.value = vida

func _ready():
	vidas_label.text = "x" + str(Save.game_data.VidasJugador)
	gui_animation_player.play("TransitionAnim")
	hpbar.max_value = vida
	hpbar.value = vida
	Global.connect("fruitCollected",actualizaInterfazFrutas)


func _process(delta):
	
	
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
	frutaslabel.text = ("x"+str(Global.frutas))
	
	
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
	Global.vidas -= 1
	Save.game_data.VidasJugador -=1
	Save.save_data()
	if Save.game_data.VidasJugador <= 0:
		Save.game_data.VidasJugador = vidasMaximas
		Save.save_data()
		Transition_to_scene("res://Maps/main_menu.tscn")
	
	else:
		gui_animation_player.play_backwards("TransitionAnim")
		get_tree().paused = true
		await(gui_animation_player.animation_finished)
		get_tree().paused = false
		get_tree().reload_current_scene()




func Transition_to_scene(scene : String):
	gui_animation_player.play_backwards("TransitionAnim")
	get_tree().paused = true
	await(gui_animation_player.animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)
#
