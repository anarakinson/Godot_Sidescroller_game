extends Control


export var level_scene : PackedScene
export var settings_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_up():
	SoundManager.stop_all_music()
	SceneManager.change_scene_to(level_scene, "LightFading")
	SoundManager.gameplay_music.play()


func _on_StartButton_button_down():
	SoundManager.button_sound.play()


func _on_SettingsButton_button_up():
	SceneManager.change_scene_to(settings_scene)


func _on_SettingsButton_button_down():
	SoundManager.button_sound.play()
