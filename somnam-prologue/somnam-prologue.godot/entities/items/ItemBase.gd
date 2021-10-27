extends Area2D

# List of all potential notes.
export (String,
	'BaseItem', 
	'RustyKey',
	'CogKey',
	'Tonic',
	'GoldCoin'
	) var item
	
export(Texture) var icon

func _ready():
	if WorldManager.pickedUp.has(item):
		if WorldManager.pickedUp[item] == true:
			self.hide()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var distToPlayer = PlayerManager.distance(self.position)
		if PlayerManager.isItemInHand == true:
			Input.set_custom_mouse_cursor(SceneManager.cursorDefault)
			PlayerManager.inventory = PlayerManager.inventory + [PlayerManager.itemInHand]
			# print(PlayerManager.inventory)
			PlayerManager.isItemInHand = false
			PlayerManager.itemInHand = ''
			SoundManager.playInventory()
		elif distToPlayer <= 150:
			Input.set_custom_mouse_cursor(icon)
			PlayerManager.isItemInHand = true
			PlayerManager.itemInHand = item
			if WorldManager.pickedUp.has(item):
				WorldManager.pickedUp[item] = true
			SoundManager.playHand()
			hide()
