extends PlayerState


# functions below override functions from State.gd
func enter():
	player.animation_state.travel("Walk")
	if not player.has_dashes() and player.is_on_floor():
		player.reset_dash_counter(1)


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
				if player.raycast.is_colliding():
					if player.raycast.collide_with_bodies:
						var collider_ray = player.raycast.get_collider()
						if not (collider_ray is RigidBox):
							state_machine.transition_to("Push")


	# handle other transitions
	if Input.is_action_just_pressed("player_jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(input_direction_x, 0.0): 	# if direction is basically 0 then character stay idle
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("player_attack") and !player.is_attacking:
		print("ATTACK")
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("player_dash") and player.has_dashes():
		print("DASH")
		state_machine.transition_to("Dash")
