extends PlayerState


# functions below override functions from State.gd
func enter():
	player.is_attacking = true
	player.animation_state.travel("Attack")
	SoundManager.attack_sound.play()


func exit():
	pass

func physics_update(delta):
	if player.is_on_floor():
		player.velocity.x = 0
	
	if !player.is_attacking:
		state_machine.transition_to("Idle")
		return

	player.apply_gravity(delta)
	player.velocity = player.players_move_and_slide(player.velocity, Vector2.UP)


	# handle collisions
#	if player.get_slide_count() > 0:
#		for i in player.get_slide_count():
#			var collision = player.get_slide_collision(i)
#			var collider = collision.collider
##			if (collider is Enemy1) or (collider is Enemy2):
##				state_machine.transition_to("Death")
##				return
