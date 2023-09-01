extends Node2D


func _ready():
	print(DoorManager.door_name)

	# find the door location
	if DoorManager.door_name:
		var door_node = find_node(DoorManager.door_name)
		if door_node:
			$Player/Player.global_position = door_node.global_position
