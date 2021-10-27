extends KinematicBody2D

export (int) var speed = 175

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
	SoundManager.playMachine_1()

func get_input():
	velocity = Vector2()
	if PlayerManager.lastButtonPressed == 'right':
		velocity.x += 1
	if PlayerManager.lastButtonPressed == 'left':
		velocity.x -= 1
	if PlayerManager.lastButtonPressed == 'down':
		velocity.y += 1
	if PlayerManager.lastButtonPressed == 'up':
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if SceneManager.paused == false:
		get_input()
		velocity = move_and_slide(velocity)
	if velocity != Vector2(0, 0):
		$eye2.show()
		# Sound management goes here.
		# if Sounds.get_child(5).is_playing() == false:
			# SoundManager.playMachine_1()
	else:
		$eye2.hide()
		# Sound management goes here.
		# if Sounds.get_child(5).is_playing() == true:
			# Sounds.get_child(5).stop()
	WorldManager.posMasterDict[currentRoom][self.name] = self.position
