extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var entities = get_overlapping_bodies()
	for entity in entities:
		if entity.name == 'PlayerBody':
			if PlayerManager.canDamage == true:
				PlayerManager.canDamage = false
				# $DamageSound.play()
				SoundManager.playDamage()
				PlayerManager.health = PlayerManager.health - 1
				var playerChildren = entity.get_children()
				for child in playerChildren:
					if child.name == 'InvFrames':
						child.start()
