extends PlayerState


# functions below override functions from State.gd
func enter():
	player.velocity.y = player.jump_speed
	player.animation_state.travel("Jump")
	SoundManager.jump_sound.play()

	
func exit():
	pass

func physics_update(delta):
	var jump_released = false
	if Input.is_action_just_released("player_jump"):
		jump_released = true
	
	if player.velocity.y > 0:
		# in higher point jump turns to fall
		state_machine.transition_to("Fall")
		return
	elif player.velocity.y < 0 && jump_released:
		# if button released jump turns to fall
		player.apply_gravity(delta * player.lowJumpModifier)
		state_machine.transition_to("Fall")
		return

	# action strenght will be either 0 or 1, so minus return (-1 or 0 or 1)
	var input_direction_x : float = (
		Input.get_action_strength("player_right") -
		Input.get_action_strength("player_left")
	)

	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
	player.velocity = player.players_move_and_slide(player.velocity, Vector2.UP)

	
	# handle other transitions
	if Input.is_action_just_pressed("player_attack") and !player.is_attacking:
		print("ATTACK")
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("player_dash") and player.has_dashes():
		state_machine.transition_to("Dash")
