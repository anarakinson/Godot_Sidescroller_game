extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player =  $Player/Player
onready var respawn =  $Respawn


# Called when the node enters the scene tree for the first time.
func _ready():	
	
	# find the door location
	if DoorManager.door_name:
		print(DoorManager.door_name)
		var door_node = find_node(DoorManager.door_name)
		if door_node:
			player.global_position = door_node.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DoorManager.player_dead == true:
		print("AWAKE")
		player.global_position = respawn.global_position
		player.get_node("CollisionShape2D").disabled = false
		player.get_node("StateMachine").transition_to("Idle")
		DoorManager.player_dead = false
	
