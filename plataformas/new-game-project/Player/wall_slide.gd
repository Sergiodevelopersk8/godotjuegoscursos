extends PlayerState


func state_enter_state(msg :={}):
	player.velocity.y = 0
	anim_player.play("wallSlide")
	
	
	

func state_physics_process(delta):
	player.velocity.y += player.gravity*.05
	var direccion = Input.get_axis("ui_left","ui_right")
	player.velocity.x = direccion * player.speed
	player.move_and_slide()
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	elif !player.is_on_wall():
			state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("wallJump")
	
	
