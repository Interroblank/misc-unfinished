extends Control

# List of all potential notes.
export (String,
	'BaseMessage',
	'VentMessage1', 
	'VentMessage2'
	) var message
	
func _ready():
	$MessText.text = NoteManager.messageDict[message]
