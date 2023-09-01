extends CanvasLayer


var last_animation = null
#                 RGBA
var color_dark = Color(75, 85, 95, 255)
var color_light = Color(250, 250, 250, 255)

onready var LogoScreen = load("res://Scenes/UI/LogoScreen/LogoScreen.tscn")
#onready var LogoScreen = load("res://Scenes/Levels/Location1/Level1/Level0.tscn")


func change_scene_to(new_scene, animation=null):
	if animation:
		reset_color_rect(animation)
		$AnimationPlayer.play(animation)
	get_tree().change_scene_to(new_scene)
	last_animation = animation

func change_scene(new_scene_str, animation=null):
	if animation:
		reset_color_rect(animation)
		$AnimationPlayer.play(animation)
	get_tree().change_scene(new_scene_str)
	last_animation = animation
	
func get_anim_duration():
	if last_animation == null:
		return 0.0
	return $AnimationPlayer.get_animation(last_animation).length

func reset_color_rect(animation):
	match animation:
		"DarkFade":
			$ColorRect.color = color_dark
		"LightFade":
			$ColorRect.color = color_light
		"RestartLevelFade":
			$ColorRect.color = color_dark

# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene_to(LogoScreen, "DarkFade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
