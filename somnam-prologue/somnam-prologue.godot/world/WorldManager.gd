extends Node

# This singleton will be used to determine if events are happening for the first time.
# It will also store machine positions.

# Machine position dictionaries.
var posMasterDict = {
	'Room1' : {},
	'Room2' : {},
	'Room3' : {},
	'Room4' : {},
	'Room5' : {},
	'Room6' : {},
	'Room7' : {},
	'Room8' : {},
	'Room9' : {},
	'Room10' : {}
}

# Event booleans.

var pickedUp = {
	'RustyKey' : false,
	'CogKey' : false
}

var opened_RustyDoor = false
var opened_VentCover = false
