extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_FS_pressed():
	# $ClickSound.play()
	SoundManager.playButton()
	OS.window_fullscreen = !OS.window_fullscreen
