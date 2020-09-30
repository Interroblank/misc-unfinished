-- SettleSim (Tentative)
-- Interroblank, 2019

-- Loading necessary game script(s).
require('world')
require('game')
require('work')

-- Loading custom font(s).
font_sm = love.graphics.newFont('Elements/font/AthensClassic.ttf', 22)
font_lg = love.graphics.newFont('Elements/font/AthensClassic.ttf', 44)

-- Loading the 'LoveFrames' GUI library by Kenny Shields.
loveframes = require('LoveFrames/loveframes')

-- Loading the timer module from the 'hump' LÖVE library by Matthias Richter.
timer = require('hump.timer')

-- Setting window title and resolution.
love.window.setTitle('SettleSim (Tentative)')
love.window.setMode(1024, 768, {borderless = false})

function love.load()
	
-- Initializing the 'Menu' state.
	
	loveframes.SetState('menu')
	
	-- Initializing the background image.
	
	local menu_bg =  loveframes.Create('image')
	menu_bg:SetImage('Elements/menu/menu_bg.png')
	menu_bg:CenterWithinArea(0, 0, love.graphics.getDimensions())
	menu_bg:SetState('menu')
	
	-- Initializing the 'New Game' button.

	local menu_new = loveframes.Create('imagebutton')
	menu_new:SetImage('Elements/menu/menu_new.png')
	menu_new:SetText('')
	menu_new:SizeToImage()
	menu_new:CenterWithinArea(0, 100, love.graphics.getDimensions())
	menu_new:SetState('menu')
	
	menu_new.OnClick = function(object)
		buffer(0.2)
		timer.after(0.8, function()
			loveframes.SetState('main')
		end)
	end
	
	-- Initializing the 'Load Game' button.

	local menu_load = loveframes.Create('imagebutton')
	menu_load:SetImage('Elements/menu/menu_load.png')
	menu_load:SetText('')
	menu_load:SizeToImage()
	menu_load:CenterWithinArea(0, 200, love.graphics.getDimensions())
	menu_load:SetState('menu')
	
	-- Initializing the 'Quit Game' button.

	local menu_quit = loveframes.Create('imagebutton')
	menu_quit:SetImage('Elements/menu/menu_quit.png')
	menu_quit:SetText('')
	menu_quit:SizeToImage()
	menu_quit:CenterWithinArea(0, 300, love.graphics.getDimensions())
	menu_quit:SetState('menu')
	
	menu_quit.OnClick = function(object)
		love.event.quit()
	end
	
-- Initializing the 'Main' state.
	
	-- Initializing all 'Main' state counters and buttons.
	
	main_bg =  loveframes.Create('image')
	main_settlers_b = loveframes.Create('image')
	main_settlers = loveframes.Create('text')
	main_faith_b = loveframes.Create('image')
	main_faith = loveframes.Create('text')
	main_food_b = loveframes.Create('image')
	main_food = loveframes.Create('text')
	main_turn_b = loveframes.Create('image')
	main_turn = loveframes.Create('text')
	main_actions_b = loveframes.Create('image')
	main_actions = loveframes.Create('text')
	main_log = loveframes.Create('imagebutton')
	main_world = loveframes.Create('imagebutton')
	main_bless = loveframes.Create('imagebutton')
	main_smite = loveframes.Create('imagebutton')
	main_storm = loveframes.Create('imagebutton')
	main_end = loveframes.Create('imagebutton')
	main_save = loveframes.Create('imagebutton')
	main_load = loveframes.Create('imagebutton')
	main_quit = loveframes.Create('imagebutton')
	main_wlog_b = loveframes.Create('image')
	main_wlog = loveframes.Create('text')
	main_w = loveframes.Create('text')
	
	-- Initializing resource buttons.
	
	bless_trees = loveframes.Create('imagebutton')
	bless_berries = loveframes.Create('imagebutton')
	bless_stone = loveframes.Create('imagebutton')
	bless_reed = loveframes.Create('imagebutton')
	bless_twigs = loveframes.Create('imagebutton')
	bless_mud = loveframes.Create('imagebutton')
	bless_hemp = loveframes.Create('imagebutton')
	bless_rabbits = loveframes.Create('imagebutton')
	
	-- Defining the parameters of the background image.
	
	main_bg:SetImage('Elements/main/main_bg.png')
	main_bg:CenterWithinArea(0, 0, love.graphics.getDimensions())
	main_bg:SetState('main')
	
	-- Defining the parameters of the 'Settlers' counter.
	
	main_settlers_b:SetImage('Elements/main/main_settlers_b.png')
	main_settlers_b:CenterWithinArea(-330, -325, love.graphics.getDimensions())
	main_settlers_b:SetState('main')
	
	main_settlers:SetFont(font_lg)
	main_settlers:SetText('SETTLERS = ' .. settlers)
	main_settlers:CenterWithinArea(-330, -325, love.graphics.getDimensions())
	main_settlers:SetState('main')
	
	main_settlers:SetParent(main_settlers_b)
	
	-- Defining the parameters of the 'Faith' counter.
	
	main_faith_b:SetImage('Elements/main/main_faith_b.png')
	main_faith_b:CenterWithinArea(0, -325, love.graphics.getDimensions())
	main_faith_b:SetState('main')
	
	main_faith:SetFont(font_lg)
	main_faith:SetText('FAITH = ' .. faith)
	main_faith:CenterWithinArea(0, -325, love.graphics.getDimensions())
	main_faith:SetState('main')
	
	main_faith:SetParent(main_faith_b)
	
	-- Defining the parameters of the 'Food' counter.
	
	main_food_b:SetImage('Elements/main/main_food_b.png')
	main_food_b:CenterWithinArea(330, -325, love.graphics.getDimensions())
	main_food_b:SetState('main')
	
	main_food:SetFont(font_lg)
	main_food:SetText('FOOD = ' .. food)
	main_food:CenterWithinArea(330, -325, love.graphics.getDimensions())
	main_food:SetState('main')
	
	main_food:SetParent(main_food_b)
	
	-- Defining the parameters of the turn counter.
	
	main_turn_b:SetImage('Elements/main/main_turn_b.png')
	main_turn_b:CenterWithinArea(-412, -239, love.graphics.getDimensions())
	main_turn_b:SetState('main')
	
	main_turn:SetFont(font_sm)
	main_turn:SetText('TURN: ' .. turn)
	main_turn:CenterWithinArea(-412, -239, love.graphics.getDimensions())
	main_turn:SetState('main')
	
	main_turn:SetParent(main_turn_b)
	
	-- Defining the parameters of the action counter.
	
	main_actions_b:SetImage('Elements/main/main_actions_b.png')
	main_actions_b:CenterWithinArea(-247, -239, love.graphics.getDimensions())
	main_actions_b:SetState('main')
	
	main_actions:SetFont(font_sm)
	main_actions:SetText('ACTIONS: ' .. actions)
	main_actions:CenterWithinArea(-247, -239, love.graphics.getDimensions())
	main_actions:SetState('main')
	
	main_actions:SetParent(main_turn_b)
	
	-- Defining the parameters of the 'Log' Button.

	main_log:SetImage('Elements/main/main_log.png')
	main_log:SetText('')
	main_log:SizeToImage()
	main_log:CenterWithinArea(-330, -163, love.graphics.getDimensions())
	main_log:SetState('main')
	
	main_log.OnClick = function(object)
		toLog()
	end
	
	-- Defining the parameters of the 'World' button.

	main_world:SetImage('Elements/main/main_world.png')
	main_world:SetText('')
	main_world:SizeToImage()
	main_world:CenterWithinArea(-330, -99, love.graphics.getDimensions())
	main_world:SetState('main')
	
	main_world.OnClick = function(object)
		toWorld()
		world = 'YOUR WORLD CONTAINS: '
		worldRefresh()
		main_w:SetFont(font_sm)
		main_w:SetText(world)
		main_w:CenterWithinArea(165, 42, love.graphics.getDimensions())
		main_w:SetState('main')
	end
	
	-- Defining the parameters of the 'Bless' button.

	main_bless:SetImage('Elements/main/main_bless.png')
	main_bless:SetText('')
	main_bless:SizeToImage()
	main_bless:CenterWithinArea(-330, -38, love.graphics.getDimensions())
	main_bless:SetState('main')
	
	main_bless.OnClick = function(object)
		toBless()
	end
	
	-- Defining the parameters of the 'Smite' button.

	main_smite:SetImage('Elements/main/main_smite.png')
	main_smite:SetText('')
	main_smite:SizeToImage()
	main_smite:CenterWithinArea(-330, 23, love.graphics.getDimensions())
	main_smite:SetState('main')
	
	-- Defining the parameters of the 'Storm' button.

	main_storm:SetImage('Elements/main/main_storm.png')
	main_storm:SetText('')
	main_storm:SizeToImage()
	main_storm:CenterWithinArea(-330, 85, love.graphics.getDimensions())
	main_storm:SetState('main')
	
	-- Defining the parameters of the 'End Turn' Button.

	main_end:SetImage('Elements/main/main_end.png')
	main_end:SetText('')
	main_end:SizeToImage()
	main_end:CenterWithinArea(-330, 147, love.graphics.getDimensions())
	main_end:SetState('main')
	
	main_end.OnClick = function(object)
		turnCycle()
	end
	
	-- Defining the parameters of the 'Save Game' button.

	main_save:SetImage('Elements/main/main_save.png')
	main_save:SetText('')
	main_save:SizeToImage()
	main_save:CenterWithinArea(-330, 210, love.graphics.getDimensions())
	main_save:SetState('main')
	
	-- Defining the parameters of the 'Load Game' button.

	main_load:SetImage('Elements/main/main_load.png')
	main_load:SetText('')
	main_load:SizeToImage()
	main_load:CenterWithinArea(-330, 273, love.graphics.getDimensions())
	main_load:SetState('main')
	
	-- Defining the parameters of the 'Quit Game' button.
	
	main_quit:SetImage('Elements/main/main_quit.png')
	main_quit:SetText('')
	main_quit:SizeToImage()
	main_quit:CenterWithinArea(-330, 336, love.graphics.getDimensions())
	main_quit:SetState('main')
	
	main_quit.OnClick = function(object)
		love.event.quit()
	end
	
	-- Defining the parameters of the 'World Log' frame.
	
	main_wlog_b:SetImage('Elements/main/main_log_b.png')
	main_wlog_b:CenterWithinArea(165, 42, love.graphics.getDimensions())
	main_wlog_b:SetState('main')
	
	-- Defining the parameters of the 'World Log'.
	
	main_wlog:SetFont(font_sm)
	main_wlog:CenterWithinArea(-150, -265, love.graphics.getDimensions())
	
	if turn == 1 then
		turn_log = turn_log .. [[ 	
	A small band of your faithful worshippers has, after a long and arduous 
	trek, finally arrived in your holy domain. With your divine guidance 
	behind them, they will surely prosper in this great land. Your followers
	are a simple people. They have arrived in your domain with little more
	than the ragged clothes on their backs. They possess no tools, and
	have no food left from the journey. Bless this land and let them thrive! ]]
	end
	
	main_wlog:SetText(turn_log)
	main_wlog:SetState('main')
	
-- Defining the parameters of resource buttons.
	
	-- Resource 'trees'.
	bless_trees:SetImage('Elements/bless/bless_trees.png')
	bless_trees:SetText('')
	bless_trees:SizeToImage()
	bless_trees:CenterWithinArea(-50, -128, love.graphics.getDimensions())
	bless_trees:SetState('main')
	bless_trees:SetVisible(false)
	
	bless_trees.OnClick = function(object)
		if actions > 0 then
			re.trees = re.trees + 5
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with beautiful oak trees!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'berries'.
	bless_berries:SetImage('Elements/bless/bless_berries.png')
	bless_berries:SetText('')
	bless_berries:SizeToImage()
	bless_berries:CenterWithinArea(-50, -244, love.graphics.getDimensions())
	bless_berries:SetState('main')
	bless_berries:SetVisible(false)
	
	bless_berries.OnClick = function(object)
		if actions > 0 then
			re.berries = re.berries + 5
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with troves of berry bushes!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'stone'.
	bless_stone:SetImage('Elements/bless/bless_stone.png')
	bless_stone:SetText('')
	bless_stone:SizeToImage()
	bless_stone:CenterWithinArea(165, -128, love.graphics.getDimensions())
	bless_stone:SetState('main')
	bless_stone:SetVisible(false)
	
	bless_stone.OnClick = function(object)
		if actions > 0 then
			re.stone = re.stone + 10
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with mounds of stone!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'reed'.
	bless_reed:SetImage('Elements/bless/bless_reed.png')
	bless_reed:SetText('')
	bless_reed:SizeToImage()
	bless_reed:CenterWithinArea(165, -244, love.graphics.getDimensions())
	bless_reed:SetState('main')
	bless_reed:SetVisible(false)
	
	bless_reed.OnClick = function(object)
		if actions > 0 then
			re.reed = re.reed + 10
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with reed along the river!'

			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'twigs'.
	bless_twigs:SetImage('Elements/bless/bless_twigs.png')
	bless_twigs:SetText('')
	bless_twigs:SizeToImage()
	bless_twigs:CenterWithinArea(380, -244, love.graphics.getDimensions())
	bless_twigs:SetState('main')
	bless_twigs:SetVisible(false)
	
	bless_twigs.OnClick = function(object)
		if actions > 0 then
			re.twigs = re.twigs + 5
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with piles of twigs!'

			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'mud'.
	bless_mud:SetImage('Elements/bless/bless_mud.png')
	bless_mud:SetText('')
	bless_mud:SizeToImage()
	bless_mud:CenterWithinArea(-50, -186, love.graphics.getDimensions())
	bless_mud:SetState('main')
	bless_mud:SetVisible(false)
	
	bless_mud.OnClick = function(object)
		if actions > 0 then
			re.mud = re.mud + 10
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with patches of mud!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'hemp'.
	bless_hemp:SetImage('Elements/bless/bless_hemp.png')
	bless_hemp:SetText('')
	bless_hemp:SizeToImage()
	bless_hemp:CenterWithinArea(165, -186, love.graphics.getDimensions())
	bless_hemp:SetState('main')
	bless_hemp:SetVisible(false)
	
	bless_hemp.OnClick = function(object)
		if actions > 0 then
			re.hemp = re.hemp + 10
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with stalks of hemp!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
	-- Resource 'rabbits'.
	bless_rabbits:SetImage('Elements/bless/bless_rabbits.png')
	bless_rabbits:SetText('')
	bless_rabbits:SizeToImage()
	bless_rabbits:CenterWithinArea(380, -186, love.graphics.getDimensions())
	bless_rabbits:SetState('main')
	bless_rabbits:SetVisible(false)
	
	bless_rabbits.OnClick = function(object)
		if actions > 0 then
			en.rabbits = en.rabbits + 3
			actions = actions - 1
			main_actions:SetText('ACTIONS: ' .. actions)
			turn_log = turn_log .. '\n	Your land has been blessed with a family of rabbits!'
			main_wlog:SetText(turn_log)
			toLog()
		end
	end
	
end
 
function love.update(dt)
	loveframes.update(dt)
	timer.update(dt)
end

function love.draw()
	loveframes.draw()
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x , y , button)
end

function love.keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end