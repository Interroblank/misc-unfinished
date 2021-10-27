extends Area2D

func _ready():
	if WorldManager.opened_VentCover == true:
		self.get_parent().queue_free()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if PlayerManager.itemInHand == 'GoldCoin':
			self.get_parent().queue_free()
			Input.set_custom_mouse_cursor(SceneManager.cursorDefault)
			PlayerManager.itemInHand = ''
			PlayerManager.inventory.erase('GoldCoin')
			WorldManager.opened_VentCover = true
			SoundManager.playOpened()
		else:
			self.get_parent().get_child(3).displayMessage()
