extends StaticBody2D


onready var collision_shape = $CollisionShape2D
onready var animated_sprite = $AnimatedSprite


var state
var is_opened = false
var state_queue = []

enum states {
	IDLE,
	CLOSE,
	OPEN,
}

#############
# Functions

func close_stone_gate():
	print("gates close")
	state_queue.append(states.CLOSE)
	

func open_stone_gate():
	print("gates open")
	state_queue.append(states.OPEN)


###############
# Main Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.IDLE

func _process(delta):
	match state:
		states.IDLE:
			animated_sprite.play("Idle")
			
		states.OPEN:
			if not is_opened:
				animated_sprite.play("Open")
				collision_shape.scale.y -= 0.007
				collision_shape.position.y += 0.2
				yield(animated_sprite, "animation_finished")
				collision_shape.disabled = true
				is_opened = true
			
		states.CLOSE:
			if is_opened:
				collision_shape.disabled = false
				animated_sprite.play("Close")
				collision_shape.scale.y += 0.007
				collision_shape.position.y -= 0.2
				yield(animated_sprite, "animation_finished")
				is_opened = false
	
	####
	# queue processing
	if state_queue.size() > 0:
		# next state is the last element of array
		var next_state = state_queue.back()
		if state == next_state:
			return
		if next_state == states.CLOSE:
			if state == states.IDLE:
				state_queue.clear()
				return
			if state == states.OPEN:
				state = states.CLOSE
				state_queue.clear()
				return
		if next_state == states.OPEN:
			state = states.OPEN
			state_queue.clear()
			return
			

func _on_AnimatedSprite_animation_finished():
	if state == states.CLOSE:
		state = states.IDLE
		
