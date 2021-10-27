extends Button

func _on_MessClose_pressed():
	SoundManager.playButton()
	SceneManager.paused = false
	self.get_parent().hide()
