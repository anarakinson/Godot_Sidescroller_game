extends Position2D


export var rotation_speed : int = 50
export var left : bool = false
export var right : bool = false
export var up : bool = false
export var down : bool = false
export var pendullum_modifier : int = 30

var starting_rotation
var ending_rotation
var direction : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Traps")
	
	if left:
		starting_rotation = 0
		ending_rotation = 180
	elif right:
		starting_rotation = 180
		ending_rotation = 360
	elif up:
		starting_rotation = 90
		ending_rotation = 270
	elif down:
		starting_rotation = -90
		ending_rotation = 90
	self.rotation_degrees = starting_rotation
		
func _physics_process(delta):
	if self.rotation_degrees < starting_rotation + pendullum_modifier:
		direction = 1
	elif self.rotation_degrees > ending_rotation - pendullum_modifier:
		direction = -1
	self.rotation_degrees += rotation_speed * direction * delta


func _on_Area2D_body_entered(body):
	if body is Player:
		body.get_node("StateMachine").transition_to("Death")

