extends Node2D



var isInteractive = true
var firstUse = true
var isPlayingMusic = false
var musicTime: float = 0.0

var getActionStrings: Dictionary = {
	"look": {
		"before_use": [
			"Es un monitor de computadora. Tiene abierto el winamp", "Debería actualizar Windows"
		],
		"after_use": "Tremendo solo"
	},
	"use": "A ver...",
	"talk": "No puedo hablar con eso.",
	"pick": "Necesitaría bolsillos más amplios."
}

func look():
	if not isPlayingMusic:
		var index = getActionStrings["look"]["before_use"].size() - 1
		Globals.interactive_obj = null
		return getActionStrings["look"]["before_use"][randi_range(0,index )]
	else:
		Globals.interactive_obj = null
		return getActionStrings["look"]["after_use"]


func use():
	print("playing: ", isPlayingMusic)
	if firstUse or not isPlayingMusic:
		firstUse = false
		isPlayingMusic = true
		print($AudioStreamPlayer2D)
		if $AudioStreamPlayer2D:
			$AudioStreamPlayer2D.play(musicTime)
			Globals.interactive_obj = null
			return "FUUUUCKKK YEAHHHH!!!!"
	if isPlayingMusic and not firstUse and $AudioStreamPlayer2D:
		isPlayingMusic = false
		musicTime = $AudioStreamPlayer2D.get_playback_position()
		$AudioStreamPlayer2D.stop()
		Globals.interactive_obj = null
		return "Bueno, estaba un poco fuerte..."


func pick():
	return getActionStrings["pick"]


func _on_texture_button_mouse_entered():
	Globals.is_mouse_over_interactive_obj = true
	Globals.interactive_obj = self


func _on_texture_button_mouse_exited():
	Globals.is_mouse_over_interactive_obj = false
#	if not Globals.mouse_over_gui:
#		Globals.interactive_obj = null




func _on_texture_button_pressed():
	Globals.interactive_obj = self

