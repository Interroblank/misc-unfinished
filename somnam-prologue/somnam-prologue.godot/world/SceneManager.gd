extends Node

var firstSpawn = true
var cursorDefault = load('res://interface/cursor5.png')

var lastExitFrom = '' # U, D, L, R

var incomingDoor_U = Vector2()
var incomingDoor_D = Vector2()
var incomingDoor_L = Vector2()
var incomingDoor_R = Vector2()

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
