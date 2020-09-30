-- SettleSim (Tentative)
-- Interroblank, 2019

-- Initializing turn cycle function.

work_s = ''

function turnCycle()

	-- Shifting to state 'Turn'.
	loveframes.SetState('turn')
	
	-- Wiping the world log.
	turn_log = 'WORLD LOG: '
	main_wlog:SetText(turn_log)
	
	-- Eating food.
	-- food = food - settlers
	if food < 0 then
		food = 0
		-- TODO - Add settler attrition.
	end
	main_food:SetText('FOOD = ' .. food)
	
	-- Losing faith.
	-- faith = faith - 5
	main_faith:SetText('FAITH = ' .. faith)
	
	-- Incrementing turn counter.
	turn = turn + 1
	main_turn:SetText('TURN: ' .. turn)
	
	-- Resetting action counter.
	actions = math.floor(faith / 20)
	main_actions:SetText('ACTIONS: ' .. actions)
	
	-- Performing settler work.
	work_s = ''
	settlerWork(settlers)
	
	-- Determining random events.
	-- TODO - Random event functionality.
	
end

-- Initializing settler work function.

function settlerWork(count)

	if count > 0 then
		
		-- Creating work cycle graphics.
		
		work_b = loveframes.Create('image')
		work_b:SetImage('Elements/work/work_buff.png')
		work_b:CenterWithinArea(0, 0, love.graphics.getDimensions())
		work_b:SetState('turn')
		
		work_t = loveframes.Create('text')
		work_t:SetDefaultColor(0, 0, 0)
		work_t:SetFont(font_sm)
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		work_t:SetState('turn')
		
		bufferString_w = 'Working'
		
		buffer_w = loveframes.Create('text')
		buffer_w:SetDefaultColor(0, 0, 0)
		buffer_w:SetFont(font_lg)
		buffer_w:SetText(bufferString_w)
		buffer_w:CenterWithinArea(0, 300, love.graphics.getDimensions())
		buffer_w:SetState('turn')
		
		-- Performing settler work.
		
		timer.after(0.6, function()
			
			local worked = false
			
			-- Searching for food.
			
			if worked == false then
				worked = findFood() end
				
			-- Looking to repair.
			
			if worked == false then
				worked = makeRepairs() end
				
			-- Looking to construct.
			
			if worked == false then
				worked = buildHut() end
				
			-- Looking to create.
			
			if worked == false then
				worked = makeSimpleTool() end
				
			-- Looking to build walls.
			-- TODO.
			
			-- Looking to harvest.
			-- TODO.
				
			settlerWork(count - 1)
		
		end)
		
		-- Animating the 'bufferString'.
		
		timer.every(0.15, function() 
			bufferString_w = bufferString_w .. '. '
			buffer_w:SetText(bufferString_w)
			buffer_w:CenterWithinArea(0, 300, love.graphics.getDimensions())
		end, 3)
	
	else
		-- Returning to state 'Main'.
		loveframes.SetState('main')
		toLog()
	end
	
end

-- Initializing 'world refresh' function.

function worldRefresh()
	world = world .. '\n	' .. 'Settlers' .. ' x' .. settlers
	for i, j in pairs(re) do
		if j > 0 then
			world = world .. '\n	' .. i:sub(1, 1):upper() .. i:sub(2) .. ' x' .. j
		end
	end
	for i, j in pairs(el) do
		if j > 0 then
			world = world .. '\n	' .. i:sub(1, 1):upper() .. i:sub(2) .. ' x' .. j
		end
	end
	for i, j in pairs(en) do
		if j > 0 then
			world = world .. '\n	' .. i:sub(1, 1):upper() .. i:sub(2) .. ' x' .. j
		end
	end
end

-- Initializing 'buffer' function(s).

function buffer(sec)

	local bufferString = 'Working'
	
	local buffer_b = loveframes.Create('image')
	buffer_b:SetImage('Elements/work/work_buff.png')
	buffer_b:CenterWithinArea(0, 0, love.graphics.getDimensions())
	buffer_b:SetState('buffer')
	
	local buffer_t = loveframes.Create('text')
	buffer_t:SetFont(font_lg)
	buffer_t:SetDefaultColor(0, 0, 0)
	buffer_t:SetText(bufferString)
	buffer_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
	buffer_t:SetState('buffer')
	
	loveframes.SetState('buffer')
	
	timer.every(sec, function() 
		bufferString = bufferString .. '. '
		buffer_t:SetText(bufferString)
		buffer_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
	end, 3)
	
end

-- Initializing visibility management functions.

function toLog()

	-- Setting other elements to 'invisible'.
		
		bless_trees:SetVisible(false)
		bless_berries:SetVisible(false)
		bless_stone:SetVisible(false)
		bless_reed:SetVisible(false)
		bless_twigs:SetVisible(false)
		bless_mud:SetVisible(false)
		bless_hemp:SetVisible(false)
		bless_rabbits:SetVisible(false)
		
		main_w:SetVisible(false)
		
	-- Setting the world log to 'visible'.
	
		main_wlog:SetVisible(true)
		
end

function toWorld()

	-- Setting other elements to 'invisible'.
		
		bless_trees:SetVisible(false)
		bless_berries:SetVisible(false)
		bless_stone:SetVisible(false)
		bless_reed:SetVisible(false)
		bless_twigs:SetVisible(false)
		bless_mud:SetVisible(false)
		bless_hemp:SetVisible(false)
		bless_rabbits:SetVisible(false)
		
		main_wlog:SetVisible(false)
		
	-- Setting the master world string to 'visible'.
	
		main_w:SetVisible(true)
		
end

function toBless()
	
	-- Setting other elements to 'invisible'.
		
	main_wlog:SetVisible(false)
	main_w:SetVisible(false)
	
	-- Setting the resource buttons to 'visible'.
	
	bless_trees:SetVisible(true)
	bless_berries:SetVisible(true)
	bless_stone:SetVisible(true)
	bless_reed:SetVisible(true)
	bless_twigs:SetVisible(true)
	bless_mud:SetVisible(true)
	bless_hemp:SetVisible(true)
	bless_rabbits:SetVisible(true)
		
end

