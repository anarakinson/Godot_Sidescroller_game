extends PlayerState


# functions below override functions from State.gd
func enter():
	player.velocity.x = 0
	player.animation_state.travel("Idle")
	if not player.has_dashes() and player.is_on_floor():
		player.reset_dash_counter(1)
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		player.state = player.states.WALK

	
func exit():
	pass

func physics_update(delta):
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return

	player.apply_gravity(delta)
#	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	player.velocity = player.players_move_and_slide(player.velocity, Vector2.UP)
	
	
	# handle collisions
	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.collider
			if collider is RigidBox:
				pass
	
	
	# handle other transitions
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("player_jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_just_pressed("player_attack") and !player.is_attacking:
		print("ATTACK")
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("player_dash") and player.has_dashes():
		print("DASH")
		state_machine.transition_to("Dash")
	elif Input.is_action_just_pressed("player_position"):
		print("position", player.position)
