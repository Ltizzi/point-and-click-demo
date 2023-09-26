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

var changed_radius = false
var timer_running = false
var colores = [Color(0.937, 0.282, 0.98), Color(0.394, 0.65, 0.879), Color(0.676, 0.819, 0.955), Color(0.394, 0.65, 0.879)]

func _process(_delta):
	if not timer_running:
		timer()		
	if changed_radius:
		changed_radius = false
		var old_scale = $PointLight2D.texture_scale
		var old_intensity = $PointLight2D.energy
		$PointLight2D.texture_scale = randf_range(2.0, 5.4)
		await get_tree().create_timer(randf_range(0.12, 0.5)).timeout
		$PointLight2D.color = colores[randi_range(0, colores.size() -1)]
		await get_tree().create_timer(randf_range(0.15, 0.55)).timeout
		$PointLight2D.energy = randf_range(1.2, 5.0)
		#await get_tree().create_timer(randf_range(0.9,5.5)).timeout
		$PointLight2D.texture_scale = old_scale
		$PointLight2D.energy = old_intensity
	
func timer():
	timer_running = true
	await get_tree().create_timer(randf_range(0.2, 1.272)).timeout
	timer_running = false
	changed_radius = true
	

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


func pick(item):
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

