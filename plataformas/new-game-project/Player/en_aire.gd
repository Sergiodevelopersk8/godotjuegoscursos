extends PlayerState

var hasJump = false
var isFalling = false
func state_enter_state(msg := {}):
	if msg.has("Salto"):
		hasJump = true
		player.numSaltos -= 1
		$"../../Audio Salto".play()
		anim_player.play("jump")
		player.velocity.y = -player.jump
		if player.numSaltos == 0:
			anim_player.play("jumpDouble")
	else:
		anim_player.play("jumpCaer")
	
	if isFalling:
		$CoyoteTimer.start()
	



func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity 
	
	if player.velocity.y > 0:
		isFalling = true
	else:
		isFalling = false
	
	
	player.move_and_slide()
	if player.is_on_wall():
		state_machine.transition_to("wallSlide")
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	
	if !$BufferjumpTimer.is_stopped() and player.is_on_floor():
		$BufferjumpTimer.stop()
		player.reiniciarSalto()
		state_machine.transition_to("enAire",{Salto = true})
	#entrada a doble salto
	elif hasJump and Input.is_action_just_pressed("ui_accept") and player.numSaltos > 0:
		state_machine.transition_to("enAire",{Salto = true})
	elif !$CoyoteTimer.is_stopped() and Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("enAire",{Salto = true})
	elif Input.is_action_just_pressed("ui_accept"):
		
		$BufferjumpTimer.start()
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")





func state_exit():
	pass
	
	
	
