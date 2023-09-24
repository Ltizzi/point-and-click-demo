extends Node2D

signal self_Light_intensity_changed(intensity)

@export var self_light_intensity: float
@export var light_texture_radius: float

var old_intensity_value: float
var old_radius: float

	

func _process(_delta):
	if self_light_intensity and light_texture_radius:
		float(self_light_intensity)
		float(old_intensity_value)				
		if old_intensity_value  and self_light_intensity != old_intensity_value or light_texture_radius != old_radius:
			handle_self_light()
	old_intensity_value = self_light_intensity

func handle_self_light():

	$PointLight2D.energy = self_light_intensity
	$PointLight2D.texture_scale = light_texture_radius + 0.5	
	$PointLight2D2.energy = self_light_intensity
	$PointLight2D2.texture_scale = abs(light_texture_radius - 0.2)
#	$PointLight2D3.energy = self_light_intensity - 0.01
#	$PointLight2D3.texture_scale = light_texture_radius
#	$PointLight2D4.energy = self_light_intensity - 0.01
#	$PointLight2D4.texture_scale = light_texture_radius
#	$PointLight2D5.energy = self_light_intensity- 0.01
#	$PointLight2D5.texture_scale = light_texture_radius
#	$PointLight2D6.energy = self_light_intensity - 0.01
#	$PointLight2D6.texture_scale = light_texture_radius
	$PointLight2D7.energy = self_light_intensity - 0.01
	$PointLight2D7.texture_scale = light_texture_radius


