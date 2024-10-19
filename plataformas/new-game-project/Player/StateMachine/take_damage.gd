extends PlayerState


func state_enter_state(msg:={}):
	anim_player.play("herido")
	player.dmgColision.set_deferred("disabled",true)
	$"../../AudioHerirse".play()
	#player.velocity = Vector2.ZERO
	player.velocity.y = -player.jump
	
	player.move_and_slide()
	

func state_physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
	
	player.velocity.x = direccion * player.speed
	player.velocity.y += player.gravity
	player.move_and_slide()




func _on_animation_player_animation_finished(anim_name) :
	if player.dmgColision.disabled:
		state_machine.transition_to("Idle")
		player.dmgColision.set_deferred("disabled",false)
	
	
