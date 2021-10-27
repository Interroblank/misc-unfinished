extends Area2D

const messInterfaceScene = preload('res://interface/messages/MessInterface.tscn')

# List of all potential notes.
export (String,
	'BaseMessage', 
	'VentMessage1', 
	'VentMessage2'
	) var message
		
func displayMessage():
	var newMessage = messInterfaceScene.instance()
	newMessage.message = message
	self.get_parent().add_child(newMessage)
	newMessage.show()
	SoundManager.playNote()
	SceneManager.paused = true
