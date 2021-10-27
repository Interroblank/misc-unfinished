extends Button

func _on_NoteClose_pressed():
	SoundManager.playButton()
	SceneManager.paused = false
	self.get_parent().hide()
