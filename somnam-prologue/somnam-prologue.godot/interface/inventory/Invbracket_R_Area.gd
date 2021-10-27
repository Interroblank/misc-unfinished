extends Area2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() and PlayerManager.isItemInHand == true:
		Input.set_custom_mouse_cursor(SceneManager.cursorDefault)
		PlayerManager.inventory = PlayerManager.inventory + [PlayerManager.itemInHand]
		# print(PlayerManager.inventory)
		PlayerManager.isItemInHand = false
		PlayerManager.itemInHand = ''
		SoundManager.playInventory()
