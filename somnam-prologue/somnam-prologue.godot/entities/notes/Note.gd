extends Area2D

const noteInterfaceScene = preload('res://interface/notes/NoteInterface.tscn')

# List of all potential notes.
export (String,
	'BaseNote', 
	'Note1', 
	'Note2',
	'Note3'
	) var note

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var distToPlayer = PlayerManager.distance(self.position)
		if distToPlayer <= 150:
			var newNote = noteInterfaceScene.instance()
			newNote.note = note
			self.get_parent().add_child(newNote)
			newNote.show()
			SoundManager.playNote()
			SceneManager.paused = true
