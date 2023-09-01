extends KinematicBody2D


# Declare member variables here.

class_name Player

#onready var animation_player = $AnimationPlayer
onready var animation_state = $AnimationTree.get("parameters/playback")
onready var raycast = $RayCast2D

export var gravity : float = 800
export var walk_speed : int = 75
export var jump_speed : int = -250
var lowJumpModifier: int = 10
export var dash_speed : int = 150
export var num_dashes : int = 1


var rigid_push : Vector2 = Vector2(255, 0)
var velocity : Vector2
var direction = "right"
var is_attacking = false
var is_dashing = false

var state
enum states {
	IDLE,
	WALK,
	JUMP,
	DASH,
	FALL,
	ATTACK,
}


# Handle slopes
var snap_lenght : int = 2
var snap_direction : Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_lenght
var floor_max_angle = deg2rad(50)

###########
#  Functions

func set_direction_right():
	direction = "right"
	$Sprite.flip_h = false
	$HitboxPosition.rotation_degrees = 0
	
func set_direction_left():
	direction = "left"
	$Sprite.flip_h = true
	$HitboxPosition.rotation_degrees = 180
	
func update_direction(direction_x):
	if direction_x > 0:
		set_direction_right()
	elif direction_x < 0:
		set_direction_left()
		
func apply_gravity(delta):
	velocity.y += gravity * delta
	
func on_attack_finished():
	is_attacking = false
	
func on_dash_finished():
	is_dashing = false

func reset_dash_counter(value):
	num_dashes = value
	
func has_dashes():
	if num_dashes > 0:
		return true
	return false
	
func play_death_sound():
	$CollisionShape2D.disabled = true
	SoundManager.death_sound.play()
	
func players_move_and_slide(velocity, up_direction):
	return move_and_slide_with_snap(
		velocity,                # linear_velocity
		snap_vector,             # snap
		up_direction,            # up_direction
		true,                    # stop_on_slope
		4,                       # max_slides
		floor_max_angle,         # floor_max_angle
		false                    # infinite_inertia
	)

	
func restart_level():
	print("YOU ARE DEAD")
#	yield(animation_player, "animation_finished")
	var current_level = get_parent().get_parent().name
	var path = "res://Scenes/Levels/" + current_level + ".tscn"
	print(path)
	DoorManager.player_dead = true
	SceneManager.change_scene(path, "RestartLevelFade")
	return

###########
# Main Functions

# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.IDLE
	get_node("HitboxPosition/Hitbox/CollisionShape2D").disabled = true



#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Enemy"):
#		restart_level()
#		print(body)
