-- SettleSim (Tentative)
-- Interroblank, 2019

-- Initializing 'find' functions.

function findFood()

	if en.rabbits > 0 then
		if el.trap > 0 then
			if roll(100) > 70 then
				en.rabbits = en.rabbits - 1
				food = food + 5
				main_food:SetText('FOOD = ' .. food)
				turn_log = turn_log.. '\n	A rabbit has wandered into a trap!'
				turn_log = turn_log.. '\n	Settler harvested rabbit (x1) and converted to food (x5).'
				main_wlog:SetText(turn_log)
				work_s = work_s.. '\nA rabbit has wandered into a trap!'
				work_s = work_s.. '\nSettler harvested rabbit (x1) and converted to food (x5).'
				work_t:SetText(work_s)
				work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
				return true
			else
				turn_log = turn_log.. '\n	Settler checks a trap, but finds nothing.'
				main_wlog:SetText(turn_log)
				work_s = work_s.. '\nSettler checks a trap, but finds nothing.'
				work_t:SetText(work_s)
			end
		else
			buildTrap()
		end
	end

	if re.berries > 0 then
		-- Converting one berry 'bush' to two units of food.
		re.berries = re.berries - 1
		food = food + 2
		main_food:SetText('FOOD = ' .. food)
		turn_log = turn_log.. '\n	Settler harvested berries (x1) and converted to food (x2).'
		main_wlog:SetText(turn_log)
		work_s = work_s .. '\nSettler harvested berries (x1) and converted to food (x2).'
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		return true
	end

	return false

end

function findWood()

	if re.twigs > 5 then
		-- Converting five 'twigs' to five units of wood.
		re.twigs = re.twigs - 5
		re.wood = re.wood + 5
		turn_log = turn_log.. '\n	Settler harvested twigs (x5) and converted to wood (x5).'
		main_wlog:SetText(turn_log)
		work_s = work_s.. '\nSettler harvested twigs (x5) and converted to wood (x5).'
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		return true
	end

	return false

end

-- Initializing 'build' functions.

function buildHut()

	if el.hut < settlers then
		if re.thatch >= 25 and re.mud >=25 then
			-- Beginning construction of a hut.
			re.thatch = re.thatch - 25
			re.mud = re.mud - 25
			el.hut = el.hut + 0.25
			turn_log = turn_log .. '\n	Settler began construction of a hut using thatch (x25) and mud (x25).'
			main_wlog:SetText(turn_log)
			work_s = work_s .. '\nSettler began construction of a hut using thatch (x25) and mud (x25).'
			work_t:SetText(work_s)
			work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
			return true
		elseif re.reed >= 5 then
			-- Converting five units of reed to five units of thatch.
			re.reed = re.reed - 5
			re.thatch = re.thatch + 5
			turn_log = turn_log .. '\n	Settler harvested reed (x5) and converted into thatch (x5).'
			main_wlog:SetText(turn_log)
			work_s = work_s .. '\nSettler harvested reed (x5) and converted into thatch (x5).'
			work_t:SetText(work_s)
			work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
			return true
		end
	end
	
	return false
	
end

function buildTrap()

	if re.thatch >= 5 then
		-- Constructing a trap out of thatch.
		re.thatch = re.thatch - 5
		el.trap = el.trap + 1
		turn_log = turn_log .. '\n	Settler constructed a trap using thatch (x5).'
		main_wlog:SetText(turn_log)
		work_s = work_s .. '\nSettler constructed a trap using thatch (x5).'
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		return true
	elseif re.wood >= 2 then
		-- Constructing a trap out of wood.
		re.wood = re.wood - 2
		el.trap = el.trap + 1
		turn_log = turn_log .. '\n	Settler constructed a trap using wood (x2).'
		main_wlog:SetText(turn_log)
		work_s = work_s .. '\nSettler constructed a trap using wood (x2).'
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		return true
	elseif re.reed >= 5 then
		-- Converting five units of reed to five units of thatch.
		re.reed = re.reed - 5
		re.thatch = re.thatch + 5
		turn_log = turn_log .. '\n	Settler harvested reed (x5) and converted into thatch (x5).'
		main_wlog:SetText(turn_log)
		work_s = work_s .. '\nSettler harvested reed (x5) and converted into thatch (x5).'
		work_t:SetText(work_s)
		work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
		return true
	elseif re.wood >= 2 then
		findWood()
	end
	
	return false
	
end

-- Initializing tool fashioning functions.

function makeSimpleTool()

	

end

-- Initializing miscellaneous work functions.

function makeRepairs()

	for i, j in pairs(el) do
		-- Testing to see if any elements are incomplete.
		if j ~= math.ceil(j) then
		
			-- Repairing hut.
			if i == 'hut' then
				el.hut = el.hut + 0.25
				turn_log = turn_log .. '\n	Settler worked on the construction of a hut.'
				main_wlog:SetText(turn_log)
				work_s = work_s .. '\nSettler worked on the construction of a hut.'
				work_t:SetText(work_s)
				work_t:CenterWithinArea(0, 0, love.graphics.getDimensions())
				return true
			end
		
		end
	end
	
	return false
	
end

-- Initializing random roll function.

math.randomseed(os.time())

function roll(lim)
	return math.random(0, lim)
end