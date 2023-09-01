extends KinematicBody2D


export var gravity : float = 1000

onready var raycast : RayCast2D = $RayCast2D

var is_stuck = true
var velocity : Vector2

#var raycast_size = 50
#raycast.cast_to(0, raycast_size, -1)

func apply_gravity(delta):
	velocity.y += gravity * delta

# Handle slopes
var snap_lenght : int = 2
var snap_direction : Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_lenght
var floor_max_angle = deg2rad(45)


func _ready():
	add_to_group("Traps")
	is_stuck = true


func _physics_process(delta):
	if not is_stuck:
		apply_gravity(delta)
#		velocity = move_and_slide(velocity, Vector2.UP).round()
		velocity = move_and_slide_with_snap(
			velocity,                # linear_velocity
			snap_vector,             # snap
			Vector2.UP,              # up_direction
			true,                    # stop_on_slope
			4,                       # max_slides
			floor_max_angle,         # floor_max_angle
			false                    # infinite_inertia
		)
	
	# raycast collision
	if raycast.is_colliding():
		if raycast.collide_with_bodies:
			var collider = raycast.get_collider()
			if (collider is Player) or (collider.is_in_group("Enemy")):
				is_stuck = false
				
	# kinematic body collision
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			if collider is TileMap:
				is_stuck = true
				# turn off raycast collision
				set_physics_process(false)
#			if collider is Player:
#				collider.get_node("StateMachine").transition_to("Death")
#			elif (collider.is_in_group("Enemy")):
#				collider.become_dead()
			
#	print(get_tree().get_nodes_in_group("Enemy"))
#


func _on_Area2D_body_entered(body):
	if body is Player:
		body.get_node("StateMachine").transition_to("Death")

