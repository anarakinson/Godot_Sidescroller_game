extends KinematicBody2D


#############
# Declare member variables here

class_name Enemy1

export var gravity : float= 800
export var walk_speed : int = 23

var velocity : Vector2
var direction : String = "right" # which way 
var state # state of 

var randgen = RandomNumberGenerator.new()
var input_direction_x # actual direction in code


enum states {
	WALK,
	DEATH,
} # constants

# Handle slopes
var snap_lenght : int = 2
var snap_direction : Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_lenght
var floor_max_angle = deg2rad(65)

#############
# Functions

func get_random_direction():
	var random_number = randgen.randi_range(0, 1)
	return [-1, 1][random_number]
	
func set_direction_right():
	direction = "right"
	$AnimatedSprite.flip_h = false
	
func set_direction_left():
	direction = "left"
	$AnimatedSprite.flip_h = true
	
func update_direction(direction_x):
	if direction_x > 0:
		set_direction_right()
	elif direction_x < 0:
		set_direction_left()
	
func apply_gravity(delta):
	velocity.y += gravity * delta
	
func handle_collision():
	pass

func become_dead():
	$Hitbox/CollisionShape2D.disabled = true
	$AnimatedSprite.play("Death")
	$CollisionShape2D.disabled = true
	yield($AnimatedSprite, "animation_finished")
	queue_free()

#############
# Main Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemy")
	
	randgen.randomize() # set random number seed
	
	input_direction_x = 1
	state = states.WALK
	
	# get_node("MoveTimer") or
	$MoveTimer.start()

# delta is time beetwen previous and current frames
func _physics_process(delta):
	
	match state:
		states.WALK:
			$AnimatedSprite.play("Walk")
			update_direction(input_direction_x)
			velocity.x = walk_speed * input_direction_x #* delta
			apply_gravity(delta)
			
#			velocity = move_and_slide(velocity, Vector2.UP)
			velocity = move_and_slide_with_snap(
				velocity,                # linear_velocity
				snap_vector,             # snap
				Vector2.UP,              # up_direction
				true,                    # stop_on_slope
				4,                       # max_slides
				floor_max_angle,         # floor_max_angle
				false                    # infinite_inertia
			)
			
#			# handle collision
#			if get_slide_count() > 0:
#				for i in get_slide_count():
#					var collision = get_slide_collision(i)
#					var collider = collision.collider
#					if collider is Player:
#						collider.get_node("StateMachine").transition_to("Death")
		
		states.DEATH:
			become_dead()


#############
# Signals

func _on_MoveTimer_timeout():
	input_direction_x = get_random_direction()

func _on_Hurtbox_area_entered(area):
	# check if player attack the area
	if area.owner is Player or (area.owner.is_in_group("Traps")):
		state = states.DEATH


func _on_Hitbox_body_entered(body):
	if body is Player:
		body.get_node("StateMachine").transition_to("Death")
