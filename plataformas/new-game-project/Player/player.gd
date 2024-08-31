extends CharacterBody2D


var speed := 120
var direccion := 0.0
const jump := 250
var gravity := 9
@onready var anim = $AnimationPlayer
@onready var sprite :=$Sprite2D
func _physics_process(delta):
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
