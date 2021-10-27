extends KinematicBody2D

export(int) var speed = 200

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready(): # TODO - Comment this code.
	if SceneManager.firstSpawn == true:
		self.position = Vector2(640, 512)
		SceneManager.firstSpawn = false
	if SceneManager.lastExitFrom == 'U':
		self.position = SceneManager.incomingDoor_D + Vector2(0, -100)
	if SceneManager.lastExitFrom == 'D':
		self.position = SceneManager.incomingDoor_U + Vector2(0, 100)
	if SceneManager.lastExitFrom == 'L':
		self.position = SceneManager.incomingDoor_R + Vector2(-100, 0)
	if SceneManager.lastExitFrom == 'R':
		self.position = SceneManager.incomingDoor_L + Vector2(100, 0)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
		PlayerManager.lastButtonPressed = 'right'
		if Sounds.get_child(2).is_playing() == false and PlayerManager.cannotMove == false:
			SoundManager.playGrit()
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		PlayerManager.lastButtonPressed = 'left'
		if Sounds.get_child(2).is_playing() == false and PlayerManager.cannotMove == false:
			SoundManager.playGrit()
	if Input.is_action_pressed('down'):
		velocity.y += 1
		PlayerManager.lastButtonPressed = 'down'
		if Sounds.get_child(2).is_playing() == false and PlayerManager.cannotMove == false:
			SoundManager.playGrit()
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		PlayerManager.lastButtonPressed = 'up'
		if Sounds.get_child(2).is_playing() == false and PlayerManager.cannotMove == false:
			SoundManager.playGrit()
	if PlayerManager.lastButtonPressed == 'right':
		$PlayerSprite.play('Right')
	if PlayerManager.lastButtonPressed == 'left':
		$PlayerSprite.play('Left')
	if PlayerManager.lastButtonPressed == 'down':
		$PlayerSprite.play('Down')
	if PlayerManager.lastButtonPressed == 'up':
		$PlayerSprite.play('Up')
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if SceneManager.paused == false:
		get_input()
		velocity = move_and_slide(velocity)
		if velocity == Vector2(0, 0):
			stopPlayer()
			if Sounds.get_child(2).is_playing() == true:
				Sounds.get_child(2).stop()
				PlayerManager.cannotMove = true
		else:
			PlayerManager.cannotMove = false
		PlayerManager.playerPos = self.position
	else:
		stopPlayer()
		Sounds.get_child(2).stop()

func _on_InvFrames_timeout():
	PlayerManager.canDamage = true
	
func stopPlayer():
	if PlayerManager.lastButtonPressed == 'right':
		$PlayerSprite.play('IdleR')
	if PlayerManager.lastButtonPressed == 'left':
		$PlayerSprite.play('IdleL')
	if PlayerManager.lastButtonPressed == 'down':
		$PlayerSprite.play('IdleD')
	if PlayerManager.lastButtonPressed == 'up':
		$PlayerSprite.play('IdleU')
