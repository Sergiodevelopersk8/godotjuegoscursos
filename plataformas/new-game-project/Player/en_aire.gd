extends PlayerState


func state_enter_state(msg := {}):
	if msg.has("Salto"):
		player.numSaltos -= 1
		$"../../Audio Salto".play()
		anim_player.play("jump")
		player.velocity.y = -player.jump
		if player.numSaltos == 0:
			anim_player.play("jumpDouble")
	else:
		anim_player.play("jumpCaer")



func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity 
	player.move_and_slide()
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept") and player.numSaltos > 0:
		state_machine.transition_to("enAire",{Salto = true})
	
	
	
	
	
	
