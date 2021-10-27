extends Node

var health = 3

var canDamage = true
var lastButtonPressed = ''

var isItemInHand = false
var itemInHand = ''
var inventory = []

var playerPos = Vector2(0, 0)
var cannotMove = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func distance(entityPosition):
	return sqrt(pow((entityPosition.x - playerPos.x), 2) + pow((entityPosition.y - playerPos.y), 2))
