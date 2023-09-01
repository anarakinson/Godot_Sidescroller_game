extends PlayerState


# functions below override functions from State.gd
func enter():
	player.animation_state.travel("Push")

	
func exit():
	pass

func physics_update(delta):
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return
	
	# action strenght will be either 0 or 1, so minus return (-1 or 0 or 1)
	var input_direction_x : float = (
		Input.get_action_strength("player_right") -
		Input.get_action_strength("player_left")
	)

	# change facing direction if button pressed
	if Input.is_action_pressed("player_left") && Input.is_action_pressed("player_right"):
		if player.direction == "right":
			input_direction_x = 1
		else:
			input_direction_x = -1


	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
#	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	player.velocity = player.players_move_and_slide(player.velocity, Vector2.UP)

	
	# handle collisions
	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.collider
			if collider is RigidBox:
				collider.apply_central_impulse(-collision.normal * player.rigid_push)
		
	# handle other transitions
	if Input.is_action_just_pressed("player_jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(input_direction_x, 0.0): 	# if direction is basically 0 then character stay idle
		state_machine.transition_to("Idle")

	
