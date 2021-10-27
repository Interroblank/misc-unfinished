extends Area2D

func _ready():
	if WorldManager.opened_RustyDoor == true:
		self.get_parent().queue_free()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var distToPlayer = PlayerManager.distance(self.position)
		print(distToPlayer) # What's happening here?
		if PlayerManager.itemInHand == 'RustyKey' and distToPlayer <= 150:
			self.get_parent().queue_free()
			Input.set_custom_mouse_cursor(SceneManager.cursorDefault)
			PlayerManager.itemInHand = ''
			PlayerManager.inventory.erase('RustyKey')
			WorldManager.opened_RustyDoor = true
			SoundManager.playOpened()
