extends Node


class_name StateMachine
# generate StateMachine. 
# initialize states and delegate engines callbacks to the active state

# emmited when transitioning to a new state occures
signal transitioned(state_name)

# path to the state node
export var initial_state := NodePath()

# set state to initial state
onready var state : State = get_node(initial_state)

func _ready():
	# owner is the parent node refers to Player
	# yield waits until player state is ready
	yield(owner, "ready")
	# StateMachine assigns itself to the State's state_machine property
	for child in get_children():
		child.state_machine = self
	state.enter()
	
# the state machine subscribes to node objects and delegates them to various state objects
func _unhandled_input(event):
	state.handle_input(event)
	
func _process(delta):
	state.update(delta)
	
func _physics_process(delta):
	state.physics_update(delta)
	
# handle transitioning to new state. there is option to pass in msg
func transition_to(target_state_name):
	# if there is no new state
	if not has_node(target_state_name):
		return
		
	# if new state - ends current state and begin new one
	state.exit()
	state = get_node(target_state_name)
	state.enter()
	emit_signal("transitioned", state.name)

