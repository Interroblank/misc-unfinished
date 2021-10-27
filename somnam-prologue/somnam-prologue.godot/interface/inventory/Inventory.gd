extends Control

const itemBaseScene = preload('res://entities/items/ItemBase.tscn')
var loopCount = 1

func _ready():
	var loopCount = 1
	self.get_child(1).position = InvManager.leftBracketPos(self.get_child(1).position)
	# InvManager.lastInvSize = PlayerManager.inventory.size()
	# Refreshing the inventory.
	refresh()

func _process(delta):
	if PlayerManager.inventory.size() != InvManager.lastInvSize: # When an item is added or removed.
		self.get_child(1).position = InvManager.leftBracketPos(self.get_child(1).position)
		InvManager.lastInvSize = PlayerManager.inventory.size()
		refresh()
			
func refresh():
	for i in PlayerManager.inventory:
		var newInvItem = itemBaseScene.instance()
		newInvItem.item = i
		var newTexture = StreamTexture.new()
		newTexture.load(InvManager.itemDict[i])
		newInvItem.icon = newTexture
		newInvItem.position = self.get_child(0).position + Vector2((loopCount * -64), 0)
		var newSprite = Sprite.new()
		newSprite.set_texture(newTexture)
		newSprite.set_scale(Vector2(1, 1))
		if newInvItem.item == 'Tonic':
			newSprite.set_scale(Vector2(0.5, 0.5))
		newInvItem.add_child(newSprite) # ?
		self.add_child(newInvItem)
		newInvItem.show()
		newSprite.show()
		loopCount = loopCount + 1
