-- SettleSim (Tentative)
-- Interroblank, 2019

-- Initializing master world string.
world = 'YOUR WORLD CONTAINS: '

-- Initializing default values for settler, faith, and food counters.
settlers = 10
faith = 50
food = 0

-- Initializing maximum values for settler and faith counters. (?)
settlers_max = 10
settlers_min = 1
faith_max = 100
faith_min = 20

-- Initializing turn and action counters.
actions = math.floor(faith / 20)
turn = 1

-- Initializing maximum value for turn counter. (?)
turn_max = 365

-- Initializing the log string.
turn_log = 'WORLD LOG: '

-- Initializing resource table.
re = {

	-- 'Raw' resources.
	trees = 0,
	berries = 0,
	stone = 0,
	herbs = 0,
	flowers = 0,
	reed = 0,
	twigs = 0,
	wheat = 0,
	mud = 0,
	hemp = 0,
	
	-- 'Refined' resources.
	wood = 0,
	thatch = 0,
	
}

-- Initializing element table.
el = {

	-- Buildings.
	hut = 0,
	
	-- Other structures.
	trap = 0,
	
	-- Tools.
	axe = 0,
	pick = 0,
	hoe = 0,

}

-- Initializing entity table.
en = {

	-- Animals.
	rabbits = 0,

}