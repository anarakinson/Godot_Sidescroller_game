extends StaticBody2D

class_name GroundButton

onready var animated_sprite = $AnimatedSprite
onready var unpressed_collision = $UnpressedCollision
onready var pressed_collision = $PressedCollision

var is_button_pressed : bool = false

func _ready():
	unpress_button()

func press_button():
	print("pressed")
	is_button_pressed = true
	unpressed_collision.set_deferred("disabled", true)
	pressed_collision.set_deferred("disabled", false)
	animated_sprite.play("Pressed")
	open_stone_gate()

func unpress_button():
	print("unpressed")
	is_button_pressed = false
	unpressed_collision.set_deferred("disabled", false)
	pressed_collision.set_deferred("disabled", true)
	animated_sprite.play("Unpressed")
	close_stone_gate()


func open_stone_gate():
	get_node("StoneGate").open_stone_gate()

func close_stone_gate():
	get_node("StoneGate").close_stone_gate()


func _on_PressDetector_body_entered(body):
#	if body is RigidBox or body is Player:
	if is_button_pressed == false:
		press_button()
			

func _on_PressDetector_body_exited(body):
#	if body is RigidBox or body is Player:
	if is_button_pressed == true:
		unpress_button()
	
