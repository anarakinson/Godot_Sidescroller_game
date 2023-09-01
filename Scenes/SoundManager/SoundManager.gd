extends Node2D


# Singleton


# Music
onready var music_list = $Music
onready var title_screen_music = $Music/TitleScreenMusic
onready var gameplay_music = $Music/GameMusic
onready var ending_music = $Music/EndingMusic

# Sound effects
onready var sound_effect_list = $SoundEffects
onready var attack_sound = $SoundEffects/AttackSound
onready var dash_sound = $SoundEffects/DashSound
onready var death_sound = $SoundEffects/DeathSound
onready var jump_sound = $SoundEffects/JumpSound
onready var land_sound = $SoundEffects/LandSound
onready var level_complete_sound = $SoundEffects/LevelCompleteSound
onready var logo_sound = $SoundEffects/LogoSound
onready var button_sound = $SoundEffects/ButtonSound


# Scroll bar properties
var music_scroll_vol_current = null
var sound_scroll_vol_current = null
var previous_music_val = 0
var previous_sound_val = 0

# sound setting screen and update music/sound effects
func update_sound_volume(value, vol_range, type):
	match type:
		"Music":
			for i in music_list.get_child_count():
				var music = music_list.get_child(i)
				music.volume_db += value - vol_range - previous_music_val
			previous_music_val = value - vol_range
			music_scroll_vol_current = value
		"SoundEffects":
			for i in sound_effect_list.get_child_count():
				var sound_eff = sound_effect_list.get_child(i)
				sound_eff.volume_db += value - vol_range - previous_sound_val
			previous_sound_val = value - vol_range
			sound_scroll_vol_current = value
			
			
# sound setting screen to stop music
func stop_all_music():
	for i in music_list.get_child_count():
		var music = music_list.get_child(i)
		if music.playing:
			music.playing = false
	
