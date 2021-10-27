extends Area2D

export(String, FILE, '*.tscn') var next
export(String, 'U', 'D', 'L', 'R') var dir

# Called when the node enters the scene tree for the first time.
func _ready(): # TODO - Comment this code.
	if dir == 'U':
		SceneManager.incomingDoor_U = self.position
	if dir == 'D':
		SceneManager.incomingDoor_D = self.position
	if dir == 'L':
		SceneManager.incomingDoor_L = self.position
	if dir == 'R':
		SceneManager.incomingDoor_R = self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var entities = get_overlapping_bodies()
	# print(entities)
	for entity in entities:
		if entity.name == 'PlayerBody':
			SceneManager.lastExitFrom = dir
			SoundManager.playMoved()
			# Sound management for machines.
			if Sounds.get_child(5).is_playing() == true:
				Sounds.get_child(5).stop()
			if Sounds.get_child(6).is_playing() == true:
				Sounds.get_child(6).stop()
			get_tree().change_scene(next)
