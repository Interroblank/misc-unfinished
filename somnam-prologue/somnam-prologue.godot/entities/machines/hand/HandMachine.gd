extends KinematicBody2D

export (int) var speed = 35

var velocity = Vector2()
var currentRoom

func _ready():
	# print(currentRoom)
	currentRoom = self.get_parent().name
	if !WorldManager.posMasterDict[currentRoom].has(self.name):
		# print('Success.')
		WorldManager.posMasterDict[currentRoom][self.name] = self.position
		# print(WorldManager.posMasterDict[currentRoom])
	else:
		self.position = WorldManager.posMasterDict[currentRoom][self.name]
	$HandSprite.play('Down')
	# if Sounds.get_child(6).is_playing() == false:
		# SoundManager.playMachine_2()
	SoundManager.playMachine_2()

func get_input():
	velocity = Vector2()
	velocity = position.direction_to(PlayerManager.playerPos) * speed

func _physics_process(delta):
	if SceneManager.paused == false:
		get_input()
		velocity = move_and_slide(velocity)
	# if velocity != Vector2(0, 0):
		# $eye2.show()
		# Sound management goes here.
	# else:
		# $eye2.hide()
		# Sound management goes here.
	WorldManager.posMasterDict[currentRoom][self.name] = self.position
