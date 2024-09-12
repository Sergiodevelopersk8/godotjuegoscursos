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

@onready var anim = $AnimationPlayer
@onready var sprite :=$Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RayCastDmg

enum estados  {NORMAL, HERIDO}
var estadoActual = estados.NORMAL



func _ready():
	$PlayerGUI/HPProgressBar.value = vida
	Global.player = self



func _physics_process(delta):
	if estadoActual == estados.NORMAL:
		procesarNormal(delta)


func procesarNormal(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	if direccion != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
		anim.play("jump")
	
	if !is_on_floor():
		velocity.y += gravity
	
	
	move_and_slide()

func _process(delta):
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Enemigos"):
				if colision.has_method("takeDmg"):
					colision.takeDmg(damage)




func actualizaInterfazFrutas():
	frutaslabel.text = str(Global.frutas)

func takeDamage(dmg):
	if estadoActual != estados.HERIDO:
		vida -= dmg
		anim.play("herido")
		estadoActual = estados.HERIDO
		if vida <= 0:
			morir()
	


func morir():
	get_tree().reload_current_scene()


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"herido":
			estadoActual = estados.NORMAL
