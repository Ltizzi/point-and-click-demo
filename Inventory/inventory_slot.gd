extends CenterContainer

@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $ItemSprite


func update(item: InventoryItem):
	if !item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		backgroundSprite.frame = 1.0
		itemSprite.visible = true
		itemSprite.texture = item.texture


