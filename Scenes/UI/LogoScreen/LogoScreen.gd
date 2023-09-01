extends TextureRect


export var next_scene : PackedScene
var duration : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.stop_all_music() # when game loop back from end to title all music stops
	SoundManager.logo_sound.play()
	$Timer.wait_time = SceneManager.get_anim_duration() + duration
	$Timer.start()


func _on_Timer_timeout():
	SceneManager.change_scene_to(next_scene)
