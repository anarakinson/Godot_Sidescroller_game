extends Area2D


onready var animated_sprite = $AnimatedSprite

var is_switch_open = false


func _ready():
	switch_close()

func _on_Switch_area_entered(area):
	if area.owner is Player:
		if not is_switch_open:
			switch_open()
		else:
			switch_close()


func switch_open():
	is_switch_open = true
	animated_sprite.play("Open")
	open_stone_gate()
	
func switch_close():
	is_switch_open = false
	animated_sprite.play("Close")
	close_stone_gate()


func open_stone_gate():
	get_node("StoneGate").open_stone_gate()

func close_stone_gate():
	get_node("StoneGate").close_stone_gate()
