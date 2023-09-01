extends State

class_name PlayerState
# Boilerplate class to get full autocompletion and type checks for the player
# when coding the player states

# player node
var player : Player

func _ready():
	# owner refers to Player
	yield(owner, "ready")
	# "as" casts owner to the Player type, if "owner" is not Player type - return null
	player = owner as Player
	# check if player is from "Player" scene
	assert(player != null)
