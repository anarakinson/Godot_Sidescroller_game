extends PlayerState


# functions below override functions from State.gd
func enter():
	player.animation_state.travel("Fall")


func exit():
	SoundManager.land_sound.play()

func physics_update(delta):
	if player.is_on_floor():
		state_machine.transition_to("Idle")
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
#
	
	# handle other transitions
	if Input.is_action_just_pressed("player_attack") and !player.is_attacking:
		print("ATTACK")
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("player_dash") and player.has_dashes():
		state_machine.transition_to("Dash")
