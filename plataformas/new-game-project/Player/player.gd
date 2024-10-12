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
	if is_on_floor() and numSaltos != 2:
		numSaltos = 2


#
#func _physics_process(delta):
	#if estadoActual == estados.NORMAL:
		#procesarNormal(delta)
#
#
#func procesarNormal(delta):
	#direccion = Input.get_axis("ui_left","ui_right")
	#velocity.x = direccion * speed
	#
	#if direccion != 0:
		#anim.play("walk")
	#else:
		#anim.play("idle")
	#sprite.flip_h = direccion
	 #< 0 if direccion != 0 else sprite.flip_h
	#if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		#velocity.y -= jump
		#anim.play("jump")
		#$"Audio Salto".play()
	#
	#if !is_on_floor():
		#velocity.y += gravity
	#
	#
	#move_and_slide()
#
#func _process(delta):
	#for ray in raycastDmg.get_children():
		#if ray.is_colliding():
			#var colision = ray.get_collider()
			#if colision.is_in_group("Enemigos"):
				#if colision.has_method("takeDmg"):
					#colision.takeDmg(damage)
#
#
#
#
#func actualizaInterfazFrutas():
	#frutaslabel.text = str(Global.frutas)
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
