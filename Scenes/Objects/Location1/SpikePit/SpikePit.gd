extends StaticBody2D

#
#class_name SpikePit

func _ready():
	add_to_group("Traps")

func _on_Area2D_body_entered(body):
	if body is Player:
		body.get_node("StateMachine").transition_to("Death")
	
