extends Control

# List of all potential notes.
export (String,
	'BaseNote',
	'Note1', 
	'Note2',
	'Note3'
	) var note
	
func _ready():
	$NoteText.text = NoteManager.noteDict[note]
