extends PlayerState


# functions below override functions from State.gd
func enter():
	player.animation_state.travel("Death")
	
	
func exit():
	pass

func physics_update(delta):
	pass
	# handle collisions
	
