extends PlayerState
var canChangeState = false
var direccion : float


func state_enter_state(msg :={}):
	canChangeState = false
	direccion = Input.get_axis("ui-left","ui_right")
	$"../../Audio Salto".play()
	#player.velocity = Vector2.ZERO

func state_physics_process(delta):
	player.velocity.y = lerpf(player.velocity.y, -player.jump, .8)
	player.velocity.x = lerpf(player.velocity.x, -direccion * player.jump, .8)
	
	if player.velocity.y == -player.jump:
		canChangeState = true
	player.move_and_slide() 
	
	if canChangeState and !player.is_on_floor():
		state_machine.transition_to("enAire")
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
