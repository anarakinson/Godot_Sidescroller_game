extends PlayerState


# functions below override functions from State.gd
func enter():
	player.num_dashes -= 1
	player.is_dashing = true
	player.is_attacking = false
	player.animation_state.travel("Dash")
	SoundManager.dash_sound.play()

	
func exit():
	pass

func physics_update(delta: float):
	player.velocity.y = 0
	
	if player.direction == "right":
		player.velocity.x = player.dash_speed
	elif player.direction == "left":
		player.velocity.x = -player.dash_speed
	
	
	if !player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Fall")
		return
		
	player.velocity = player.players_move_and_slide(player.velocity, Vector2.UP)
	
	
	# handle collisions
#	if player.get_slide_count() > 0:
#		for i in player.get_slide_count():
#			var collision = player.get_slide_collision(i)
#			var collider = collision.collider
#			if (collider is Enemy1) or (collider is Enemy2):
#				state_machine.transition_to("Death")
#				return
