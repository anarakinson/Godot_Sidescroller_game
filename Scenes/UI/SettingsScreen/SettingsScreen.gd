extends Control


var next_scene : String = "res://Scenes/UI/TitleScreen/TitleScreen.tscn"
var music_vol_range : float
var sound_vol_range : float

onready var music_scrollbar = $VBoxContainer/MusicScrollBar
onready var sound_scrollbar = $VBoxContainer/SoundScrollBar


func get_scrollbar_range(min_val, max_val):
	return (max_val - min_val) / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	music_vol_range = get_scrollbar_range(music_scrollbar.min_value, music_scrollbar.max_value)
	sound_vol_range = get_scrollbar_range(sound_scrollbar.min_value, sound_scrollbar.max_value)
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()
	if SoundManager.music_scroll_vol_current != null:
		music_scrollbar.value = SoundManager.music_scroll_vol_current
	if SoundManager.sound_scroll_vol_current != null:
		sound_scrollbar.value = SoundManager.sound_scroll_vol_current


func _on_Button_button_up():
	SceneManager.change_scene(next_scene, "LightFading")


func _on_Button_button_down():
	SoundManager.button_sound.play()


func _on_MusicScrollBar_scrolling():
	SoundManager.update_sound_volume(music_scrollbar.value, music_vol_range, "Music")


func _on_SoundScrollBar_scrolling():
	SoundManager.update_sound_volume(sound_scrollbar.value, sound_vol_range, "SoundEffects")
