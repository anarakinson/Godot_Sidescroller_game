extends Area2D


#export var next_scene : PackedScene
export(String, FILE, "*.tscn,*scn") var next_scene
#export var door_name : String
var player_inside : bool

func _ready():
	player_inside = false


func _on_Door_body_entered(body):
	if (body is Player):
		print("INSIDE")
		player_inside = true

func _on_Door_body_exited(body):
	if (body is Player):
		print("OUTSIDE")
		player_inside = false

func _process(delta):
	if player_inside && Input.is_action_just_pressed("player_up"):
		if !next_scene:
			print("NOTHING INSIDE")
			return
#		SoundManager.level_complete_sound.play()
		SceneManager.change_scene(next_scene, "DarkFade")
		print(name)
		DoorManager.door_name = name

