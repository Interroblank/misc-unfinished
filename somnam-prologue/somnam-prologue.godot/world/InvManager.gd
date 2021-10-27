extends Node

var lastInvSize = 0

var itemDict = { # Master item list.
	'RustyKey': 'res://entities/items/key-rusty.stex',
	'CogKey': 'res://entities/items/key-rusty.stex',
	'Tonic': 'res://entities/items/tonic.stex',
	'GoldCoin': 'res://entities/items/coin.stex'
}

func _ready():
	pass
	
func leftBracketPos(currentPos):
	var invCount = PlayerManager.inventory.size()
	return Vector2(currentPos.x - ((invCount + 1) * 64), currentPos.y)
