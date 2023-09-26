extends CollectableItem

func _ready():
	
#	$Sprite2D.texture = itemRes.texture
#	$Sprite2D.frame = 1.0
#	$TextureButton.size = $Sprite2D.texture.get_size()
#	$TextureButton.global_position = $Sprite2D.global_position
	$TextureButton.texture_normal = itemRes.texture
	alreadyPicked = false
	getActionStrings = {
		"look": [ "Es un objeto de ejemplo"],
		"pick": "Objecto de ejemplo agarrado"
	}	

func look():
	var index = getActionStrings["look"].size() - 1
	return getActionStrings["look"][randi_range(0, index)]
	
func pick(inventory: Inventory):
	super(inventory)
	clear()
	return getActionStrings["pick"]

func _on_texture_button_pressed():
	Globals.interactive_obj = self
