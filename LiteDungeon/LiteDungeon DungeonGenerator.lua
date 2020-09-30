-- LiteDungeon DungeonGenerator
-- TurquoiseLazarus

local generated = false

-- Insert relevant dungeon information into the tables below.
-- Make sure that all appropriate naming conventions are followed for the dungeon rooms.

-- 'dungeonSize' refers to vertical size, i.e. the distance from the starting room to the boss room in a straight line.
-- The starting room will always be numbered '1', and there should only ever be one starting room.
-- The boss rooms should be numbered at the very end, after all other rooms.
-- 'genericRooms' will account for the combined total of all basic rooms and item rooms.

local dungeonSize = 5

local startingRoom = {1}
local basicRooms = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
local itemRooms = {21, 22, 23, 24}
local bossRooms = {25}

local genericRooms = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}

local identifier = 'A'
local itemRoomMax = 1

-- -- -- -- --

-- -- -- -- --

-- -- -- -- --

local totalGenericRooms = 0

for _ in pairs(genericRooms) do
	totalGenericRooms = totalGenericRooms + 1
end

math.randomseed(tick() * 1000)

local function coinToss(coinTossThreshold)
	math.randomseed(tick() * 1000)
	local coinTossResult = (math.random(1, 100))
	if coinTossResult <= coinTossThreshold then
		return true
	else
		return false
	end
end

local function generate(touched)
	if touched.Parent:FindFirstChild('Humanoid') and generated == false then
		
		script.Parent.BrickColor = BrickColor.new('Maroon')
		generated = true
		
		local mainDungeonPath = {}
		local dungeonSizeCounter = dungeonSize - 2
		
		local itemRoomChecker = 0
		
	-- The code below fetches the rooms for the dungeon's main path by pulling 'dungeonSize - 2' rooms from the 'genericRooms' table.
		
		while dungeonSizeCounter ~= 0 do
			
			local randomRoom = genericRooms[math.random(2, totalGenericRooms)]
			local dupeChecker = false
			
			-- Filtering out duplicate values.
			
			for _ , r in pairs(mainDungeonPath) do
				if r == randomRoom then
					dupeChecker = true
				end
			end
			
			-- Detecting item rooms and recording item room insertion.
			
			for _ , r in pairs(itemRooms) do
				if r == randomRoom then
					if dupeChecker == false and itemRoomChecker < itemRoomMax then
						table.insert(mainDungeonPath, randomRoom)
						dungeonSizeCounter = dungeonSizeCounter - 1
						itemRoomChecker = itemRoomChecker + 1
					end
					-- 'dupeChecker' is tipped here so that the item room is not inserted into the table twice.
					dupeChecker = true
				end
			end
			
			-- Inserting the room into the 'mainDungeonPath' table.
			
			if dupeChecker == false then
				table.insert(mainDungeonPath, randomRoom)
				dungeonSizeCounter = dungeonSizeCounter - 1
			end
			
			-- Resetting the 'dupeChecker'.
			
			dupeChecker = false
			
		end
		
	-- The code below will string the rooms listed in 'mainDungeonPath' together, bookending them with the starting room and a boss room.
		
		-- Creating consolidated dungeon path table.
		
		local completeDungeonPath = {}
		
		-- Inserting the starting room into 'completeDungeonPath'.
		
		table.insert(completeDungeonPath, startingRoom[1])
		
		-- Inserting the randomly selected generic rooms into 'completeDungeonPath'.
		
		for _ , r in pairs(mainDungeonPath) do
			table.insert(completeDungeonPath, r)
		end
		
		-- Inserting a boss room into 'completeDungeonPath'.
		
		local bossRoomCounter = 0
		
		for _ in pairs(bossRooms) do
			bossRoomCounter = bossRoomCounter + 1
		end
		
		table.insert(completeDungeonPath, bossRooms[math.random(1, bossRoomCounter)])
		
		-- Connecting the rooms in 'completeDungeonPath'.
		
		local roomOutboundItem = false
		local roomOutboundBoss = false
		
		local roomInboundItem = false
		local roomInboundBoss = false
		
		local dungeonPathBuilderCounter = dungeonSize - 1
		local completeDungeonPathTablePosition = 1
		
		while dungeonPathBuilderCounter ~= 0 do
			
			local roomOutboundName = 'Room' .. tostring(completeDungeonPath[completeDungeonPathTablePosition]) .. identifier
			local roomInboundName = 'Room' .. tostring(completeDungeonPath[completeDungeonPathTablePosition + 1]) .. identifier
			
			local roomOutbound = game.Workspace:FindFirstChild(roomOutboundName)
			local roomInbound = game.Workspace:FindFirstChild(roomInboundName)
			
			-- Checking if either room involved is an item room or a boss room, and tipping boolean values accordingly.
		
			for _ , r in pairs(itemRooms) do
				if r == completeDungeonPath[completeDungeonPathTablePosition] then
					roomOutboundItem = true
				end
			end
			
			for _ , r in pairs(bossRooms) do
				if r == completeDungeonPath[completeDungeonPathTablePosition] then
					roomOutboundBoss = true
				end
			end
			
			for _ , r in pairs(itemRooms) do
				if r == completeDungeonPath[completeDungeonPathTablePosition + 1] then
					roomInboundItem = true
				end
			end
			
			for _ , r in pairs(bossRooms) do
				if r == completeDungeonPath[completeDungeonPathTablePosition + 1] then
					roomInboundBoss = true
				end
			end
			
			roomOutbound.Doorway1.Doorway.DestinationRoom.Value = completeDungeonPath[completeDungeonPathTablePosition + 1]
			roomOutbound.Doorway1.Doorway.DestinationDoorway.Value = 3
			
			roomOutbound.DoorConnected1.Value = true
			
			if roomOutboundItem == true then
				roomInbound.DoorConnected3.ItemRoomConnection.Value = true
			end
		
			if roomOutboundBoss == true then
				roomInbound.DoorConnected3.BossRoomConnection.Value = true
			end
		
			roomInbound.Doorway3.Doorway.DestinationRoom.Value = completeDungeonPath[completeDungeonPathTablePosition]
			roomInbound.Doorway3.Doorway.DestinationDoorway.Value = 1
			
			roomInbound.DoorConnected3.Value = true
			
			if roomInboundItem == true then
				roomOutbound.DoorConnected1.ItemRoomConnection.Value = true
			end
			
			if roomInboundBoss == true then
				roomOutbound.DoorConnected1.BossRoomConnection.Value = true
			end
			
			roomOutboundItem = false
			roomOutboundBoss = false
			
			roomInboundItem = false
			roomInboundBoss = false
					
			dungeonPathBuilderCounter = dungeonPathBuilderCounter - 1
			completeDungeonPathTablePosition = completeDungeonPathTablePosition + 1
			
		end
		
	-- The code below will iterate over each applicable room in 'completeDungeonPath' and randomly generate offshoot rooms.
	
		local dungeonOffshootBuilderCounter = dungeonSize - 2
		local dungeonOffshootPositionCounter = 2
		
		local horizontalLimit = math.floor(dungeonSize / 2)
		
		local completeDungeonMap = {}
		
		for _ , r in pairs(completeDungeonPath) do
			table.insert(completeDungeonMap, r)
		end
		
		while dungeonOffshootBuilderCounter > 0 do
			
			local rootRoomName = 'Room' .. tostring(completeDungeonPath[dungeonOffshootPositionCounter]) .. identifier
			local rootRoom = game.Workspace:FindFirstChild(rootRoomName)

		-- Initializing functions for offshoot generation.
			
			local function leftOffshootGeneration()
				
				local offshootBlocker = false
				
				local leftOffshootCounter = 0
				local leftOffshootPositionCounter = 1
				
				local leftOffshootList = {completeDungeonPath[dungeonOffshootPositionCounter]}
				
				local leftOffshootCoinToss = coinToss(100)
				
				if leftOffshootCoinToss == false then
					leftOffshootCounter = horizontalLimit
				end
				
				while leftOffshootCounter < horizontalLimit and rootRoom ~= nil and offshootBlocker == false do

					local offshootDupeChecker = false
					local randomOffshoot = genericRooms[math.random(2, totalGenericRooms)]
					
					-- Filtering out duplicate values.
					
					for _ , r in pairs(completeDungeonMap) do
						if r == randomOffshoot then
							offshootDupeChecker = true
						end
					end
					
					-- Detecting item rooms, recording item room insertion, and connecting item rooms to the dungeon.
					
					for _ , r in pairs(itemRooms) do
						if r == randomOffshoot and offshootDupeChecker == false then
							if offshootDupeChecker == false and itemRoomChecker < itemRoomMax then
								table.insert(completeDungeonMap, randomOffshoot)
								table.insert(leftOffshootList, randomOffshoot)
								
								-- Connecting the new offshoot to the dungeon.
							
								local roomOutboundName = 'Room' .. tostring(leftOffshootList[leftOffshootPositionCounter]) .. identifier
								local roomInboundName = 'Room' .. tostring(leftOffshootList[leftOffshootPositionCounter + 1]) .. identifier
								
								local roomOutbound = game.Workspace:FindFirstChild(roomOutboundName)
								local roomInbound = game.Workspace:FindFirstChild(roomInboundName)
								
								local roomOutboundItem = false
								local roomOutboundBoss = false
				
								local roomInboundItem = false
								local roomInboundBoss = false
								
								-- Checking if either room involved is an item room or a boss room, and tipping boolean values accordingly.
				
								for _ , r in pairs(itemRooms) do
									if r == leftOffshootList[leftOffshootPositionCounter] then
										roomOutboundItem = true
									end
								end
								
								for _ , r in pairs(bossRooms) do
									if r == leftOffshootList[leftOffshootPositionCounter] then
										roomOutboundBoss = true
									end
								end
								
								for _ , r in pairs(itemRooms) do
									if r == leftOffshootList[leftOffshootPositionCounter + 1] then
										roomInboundItem = true
									end
								end
								
								for _ , r in pairs(bossRooms) do
									if r == leftOffshootList[leftOffshootPositionCounter + 1] then
										roomInboundBoss = true
									end
								end
								
								local toInsert = coinToss(75)
								
								if toInsert == false then
									offshootBlocker = true
								end
								
								if roomOutboundBoss == false then
									
									if toInsert == true then
										
										-- Connecting to the left.
									
										roomOutbound.Doorway4.Doorway.DestinationRoom.Value = leftOffshootList[leftOffshootPositionCounter + 1]
										roomOutbound.Doorway4.Doorway.DestinationDoorway.Value = 2
										
										roomOutbound.DoorConnected4.Value = true
										
										if roomOutboundItem == true then
											roomInbound.DoorConnected2.ItemRoomConnection.Value = true
										end
									
										if roomOutboundBoss == true then
											roomInbound.DoorConnected2.BossRoomConnection.Value = true
										end
									
										roomInbound.Doorway2.Doorway.DestinationRoom.Value = leftOffshootList[leftOffshootPositionCounter]
										roomInbound.Doorway2.Doorway.DestinationDoorway.Value = 4
										
										roomInbound.DoorConnected2.Value = true
										
										if roomInboundItem == true then
											roomOutbound.DoorConnected4.ItemRoomConnection.Value = true
										end
										
										if roomInboundBoss == true then
											roomOutbound.DoorConnected4.BossRoomConnection.Value = true
										end
										
										roomOutboundItem = false
										roomOutboundBoss = false
										
										roomInboundItem = false
										roomInboundBoss = false
										
									end
									
									-- Incrementing necessary counters.
									
									local firstOffshoot = false
									
									if toInsert == true then
										
										itemRoomChecker = itemRoomChecker + 1
										
										leftOffshootPositionCounter = leftOffshootPositionCounter + 1
										
										if leftOffshootCounter == 0 then
											firstOffshoot = true
										end
										
										leftOffshootCounter = leftOffshootCounter + 1
										
									end
									
									if firstOffshoot == true then
										dungeonOffshootPositionCounter = dungeonOffshootPositionCounter + 1
									end
								
								end
								
							end
							
							-- 'offshootDupeChecker' is tipped here so that the item room is not inserted into the table twice.
							
							offshootDupeChecker = true
							
						end
						
					end
					
					-- Inserting the room into the 'mainDungeonPath' table and connecting it to the dungeon.
					
					if offshootDupeChecker == false then
						
						-- Inserting the room into the 'mainDungeonPath' table.
						
						table.insert(completeDungeonMap, randomOffshoot)
						table.insert(leftOffshootList, randomOffshoot)
						
						-- Connecting the new offshoot to the dungeon.
					
						local roomOutboundName = 'Room' .. tostring(leftOffshootList[leftOffshootPositionCounter]) .. identifier
						local roomInboundName = 'Room' .. tostring(leftOffshootList[leftOffshootPositionCounter + 1]) .. identifier
						
						local roomOutbound = game.Workspace:FindFirstChild(roomOutboundName)
						local roomInbound = game.Workspace:FindFirstChild(roomInboundName)
						
						local roomOutboundItem = false
						local roomOutboundBoss = false
		
						local roomInboundItem = false
						local roomInboundBoss = false
						
						-- Checking if either room involved is an item room or a boss room, and tipping boolean values accordingly.
		
						for _ , r in pairs(itemRooms) do
							if r == leftOffshootList[leftOffshootPositionCounter] then
								roomOutboundItem = true
							end
						end
						
						for _ , r in pairs(bossRooms) do
							if r == leftOffshootList[leftOffshootPositionCounter] then
								roomOutboundBoss = true
							end
						end
						
						for _ , r in pairs(itemRooms) do
							if r == leftOffshootList[leftOffshootPositionCounter + 1] then
								roomInboundItem = true
							end
						end
						
						for _ , r in pairs(bossRooms) do
							if r == leftOffshootList[leftOffshootPositionCounter + 1] then
								roomInboundBoss = true
							end
						end
						
						local toInsert = coinToss(75)
						
						if toInsert == false then
							offshootBlocker = true
						end
						
						if roomOutboundBoss == false then
									
							if toInsert == true then
								
								-- Connecting to the left.
						
								roomOutbound.Doorway4.Doorway.DestinationRoom.Value = leftOffshootList[leftOffshootPositionCounter + 1]
								roomOutbound.Doorway4.Doorway.DestinationDoorway.Value = 2
								
								roomOutbound.DoorConnected4.Value = true
								
								if roomOutboundItem == true then
									roomInbound.DoorConnected2.ItemRoomConnection.Value = true
								end
							
								if roomOutboundBoss == true then
									roomInbound.DoorConnected2.BossRoomConnection.Value = true
								end
							
								roomInbound.Doorway2.Doorway.DestinationRoom.Value = leftOffshootList[leftOffshootPositionCounter]
								roomInbound.Doorway2.Doorway.DestinationDoorway.Value = 4
								
								roomInbound.DoorConnected2.Value = true
								
								if roomInboundItem == true then
									roomOutbound.DoorConnected4.ItemRoomConnection.Value = true
								end
								
								if roomInboundBoss == true then
									roomOutbound.DoorConnected4.BossRoomConnection.Value = true
								end
								
								roomOutboundItem = false
								roomOutboundBoss = false
								
								roomInboundItem = false
								roomInboundBoss = false
								
							end
							
							-- Incrementing necessary counters.
							
							local firstOffshoot = false
							
							if toInsert == true then
								
								leftOffshootPositionCounter = leftOffshootPositionCounter + 1
								
								if leftOffshootCounter == 0 then
									firstOffshoot = true
								end
								
								leftOffshootCounter = leftOffshootCounter + 1
								
							end
							
							if firstOffshoot == true then
								dungeonOffshootPositionCounter = dungeonOffshootPositionCounter + 1
							end
						
						end
						
					end
					
					-- Resetting the 'offshootDupeChecker'.
					
					offshootDupeChecker = false
				
				end
				
				-- Resetting the 'leftOffshootCounter'.
					
				leftOffshootCounter = 0
				
			end
			
			local function rightOffshootGeneration()
				
				local offshootBlocker = false
				
				local rightOffshootCounter = 0
				local rightOffshootPositionCounter = 1
				
				local rightOffshootList = {completeDungeonPath[dungeonOffshootPositionCounter]}
				
				local rightOffshootCoinToss = coinToss(100)
				
				if rightOffshootCoinToss == false then
					rightOffshootCounter = horizontalLimit
				end
				
				while rightOffshootCounter < horizontalLimit and rootRoom ~= nil and offshootBlocker == false do

					local offshootDupeChecker = false
					local randomOffshoot = genericRooms[math.random(2, totalGenericRooms)]
					
					-- Filtering out duplicate values.
					
					for _ , r in pairs(completeDungeonMap) do
						if r == randomOffshoot then
							offshootDupeChecker = true
						end
					end
					
					-- Detecting item rooms, recording item room insertion, and connecting item rooms to the dungeon.
					
					for _ , r in pairs(itemRooms) do
						if r == randomOffshoot and offshootDupeChecker == false then
							if offshootDupeChecker == false and itemRoomChecker < itemRoomMax then
								table.insert(completeDungeonMap, randomOffshoot)
								table.insert(rightOffshootList, randomOffshoot)
								
								-- Connecting the new offshoot to the dungeon.
							
								local roomOutboundName = 'Room' .. tostring(rightOffshootList[rightOffshootPositionCounter]) .. identifier
								local roomInboundName = 'Room' .. tostring(rightOffshootList[rightOffshootPositionCounter + 1]) .. identifier
								
								local roomOutbound = game.Workspace:FindFirstChild(roomOutboundName)
								local roomInbound = game.Workspace:FindFirstChild(roomInboundName)
								
								local roomOutboundItem = false
								local roomOutboundBoss = false
				
								local roomInboundItem = false
								local roomInboundBoss = false
								
								-- Checking if either room involved is an item room or a boss room, and tipping boolean values accordingly.
				
								for _ , r in pairs(itemRooms) do
									if r == rightOffshootList[rightOffshootPositionCounter] then
										roomOutboundItem = true
									end
								end
								
								for _ , r in pairs(bossRooms) do
									if r == rightOffshootList[rightOffshootPositionCounter] then
										roomOutboundBoss = true
									end
								end
								
								for _ , r in pairs(itemRooms) do
									if r == rightOffshootList[rightOffshootPositionCounter + 1] then
										roomInboundItem = true
									end
								end
								
								for _ , r in pairs(bossRooms) do
									if r == rightOffshootList[rightOffshootPositionCounter + 1] then
										roomInboundBoss = true
									end
								end
								
								local toInsert = coinToss(75)
								
								if toInsert == false then
									offshootBlocker = true
								end
								
								if roomOutboundBoss == false then
									
									if toInsert == true then
										
										-- Connecting to the right.
									
										roomOutbound.Doorway2.Doorway.DestinationRoom.Value = rightOffshootList[rightOffshootPositionCounter + 1]
										roomOutbound.Doorway2.Doorway.DestinationDoorway.Value = 4
										
										roomOutbound.DoorConnected2.Value = true
										
										if roomOutboundItem == true then
											roomInbound.DoorConnected4.ItemRoomConnection.Value = true
										end
									
										if roomOutboundBoss == true then
											roomInbound.DoorConnected4.BossRoomConnection.Value = true
										end
									
										roomInbound.Doorway4.Doorway.DestinationRoom.Value = rightOffshootList[rightOffshootPositionCounter]
										roomInbound.Doorway4.Doorway.DestinationDoorway.Value = 2
										
										roomInbound.DoorConnected4.Value = true
										
										if roomInboundItem == true then
											roomOutbound.DoorConnected2.ItemRoomConnection.Value = true
										end
										
										if roomInboundBoss == true then
											roomOutbound.DoorConnected2.BossRoomConnection.Value = true
										end
										
										roomOutboundItem = false
										roomOutboundBoss = false
										
										roomInboundItem = false
										roomInboundBoss = false
										
									end
									
									-- Incrementing necessary counters.
									
									local firstOffshoot = false
									
									if toInsert == true then
										
										itemRoomChecker = itemRoomChecker + 1
										
										rightOffshootPositionCounter = rightOffshootPositionCounter + 1
										
										if rightOffshootCounter == 0 then
											firstOffshoot = true
										end
										
										rightOffshootCounter = rightOffshootCounter + 1
										
									end
									
									if firstOffshoot == true then
										dungeonOffshootPositionCounter = dungeonOffshootPositionCounter + 1
									end
								
								end
								
							end
							
							-- 'offshootDupeChecker' is tipped here so that the item room is not inserted into the table twice.
							
							offshootDupeChecker = true
							
						end
						
					end
					
					-- Inserting the room into the 'mainDungeonPath' table and connecting it to the dungeon.
					
					if offshootDupeChecker == false then
						
						-- Inserting the room into the 'mainDungeonPath' table.
						
						table.insert(completeDungeonMap, randomOffshoot)
						table.insert(rightOffshootList, randomOffshoot)
						
						-- Connecting the new offshoot to the dungeon.
					
						local roomOutboundName = 'Room' .. tostring(rightOffshootList[rightOffshootPositionCounter]) .. identifier
						local roomInboundName = 'Room' .. tostring(rightOffshootList[rightOffshootPositionCounter + 1]) .. identifier
						
						local roomOutbound = game.Workspace:FindFirstChild(roomOutboundName)
						local roomInbound = game.Workspace:FindFirstChild(roomInboundName)
						
						local roomOutboundItem = false
						local roomOutboundBoss = false
		
						local roomInboundItem = false
						local roomInboundBoss = false
						
						-- Checking if either room involved is an item room or a boss room, and tipping boolean values accordingly.
		
						for _ , r in pairs(itemRooms) do
							if r == rightOffshootList[rightOffshootPositionCounter] then
								roomOutboundItem = true
							end
						end
						
						for _ , r in pairs(bossRooms) do
							if r == rightOffshootList[rightOffshootPositionCounter] then
								roomOutboundBoss = true
							end
						end
						
						for _ , r in pairs(itemRooms) do
							if r == rightOffshootList[rightOffshootPositionCounter + 1] then
								roomInboundItem = true
							end
						end
						
						for _ , r in pairs(bossRooms) do
							if r == rightOffshootList[rightOffshootPositionCounter + 1] then
								roomInboundBoss = true
							end
						end
						
						local toInsert = coinToss(75)
						
						if toInsert == false then
							offshootBlocker = true
						end
						
						if roomOutboundBoss == false then
									
							if toInsert == true then
								
								-- Connecting to the right.
						
								roomOutbound.Doorway2.Doorway.DestinationRoom.Value = rightOffshootList[rightOffshootPositionCounter + 1]
								roomOutbound.Doorway2.Doorway.DestinationDoorway.Value = 4
								
								roomOutbound.DoorConnected2.Value = true
								
								if roomOutboundItem == true then
									roomInbound.DoorConnected4.ItemRoomConnection.Value = true
								end
							
								if roomOutboundBoss == true then
									roomInbound.DoorConnected4.BossRoomConnection.Value = true
								end
							
								roomInbound.Doorway4.Doorway.DestinationRoom.Value = rightOffshootList[rightOffshootPositionCounter]
								roomInbound.Doorway4.Doorway.DestinationDoorway.Value = 2
								
								roomInbound.DoorConnected4.Value = true
								
								if roomInboundItem == true then
									roomOutbound.DoorConnected2.ItemRoomConnection.Value = true
								end
								
								if roomInboundBoss == true then
									roomOutbound.DoorConnected2.BossRoomConnection.Value = true
								end
								
								roomOutboundItem = false
								roomOutboundBoss = false
								
								roomInboundItem = false
								roomInboundBoss = false
								
							end
							
							-- Incrementing necessary counters.
							
							local firstOffshoot = false
							
							if toInsert == true then
								
								rightOffshootPositionCounter = rightOffshootPositionCounter + 1
								
								if rightOffshootCounter == 0 then
									firstOffshoot = true
								end
								
								rightOffshootCounter = rightOffshootCounter + 1
								
							end
							
							if firstOffshoot == true then
								dungeonOffshootPositionCounter = dungeonOffshootPositionCounter + 1
							end
						
						end
						
					end
					
					-- Resetting the 'offshootDupeChecker'.
					
					offshootDupeChecker = false
				
				end
				
				-- Resetting the 'rightOffshootCounter'.
					
				rightOffshootCounter = 0
				
			end
				
			-- Determining which side of 'rootRoom' to look at first.
			
			local leftOrRight = coinToss(50)
			
			if leftOrRight == true then
				leftOffshootGeneration()
				dungeonOffshootPositionCounter = 2
				rightOffshootGeneration()
			else
				rightOffshootGeneration()
				dungeonOffshootPositionCounter = 2
				leftOffshootGeneration()
			end
			
			dungeonOffshootBuilderCounter = dungeonOffshootBuilderCounter - 1
			
		end
		
	-- The code below will color each doorway in the dungeon appropriately and close off those that are unused.
	
		for _ , r in pairs(startingRoom) do
			
			local dungeonRoomName = 'Room' .. tostring(r) .. identifier
			local dungeonRoom = game.Workspace:FindFirstChild(dungeonRoomName)
			
			if dungeonRoom.DoorConnected1.Value == true then
				if dungeonRoom.DoorConnected1.BossRoomConnection.Value == true then
					dungeonRoom.Doorway1.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected1.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway1.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway1.Fog.CanCollide = true
				dungeonRoom.Doorway1.Fog.Transparency = 0
				dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway1.Fog.Material = Enum.Material.Marble
			end
		end
		
		for _ , r in pairs(bossRooms) do
			
			local dungeonRoomName = 'Room' .. tostring(r) .. identifier
			local dungeonRoom = game.Workspace:FindFirstChild(dungeonRoomName)
			
			if dungeonRoom.DoorConnected3.Value == true then
				if dungeonRoom.DoorConnected3.BossRoomConnection.Value == true then
					dungeonRoom.Doorway3.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected3.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway3.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway3.Fog.CanCollide = true
				dungeonRoom.Doorway3.Fog.Transparency = 0
				dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway3.Fog.Material = Enum.Material.Marble
			end
		end
	
		for _ , r in pairs(genericRooms) do
			
			local dungeonRoomName = 'Room' .. tostring(r) .. identifier
			local dungeonRoom = game.Workspace:FindFirstChild(dungeonRoomName)
			
			if dungeonRoom.DoorConnected1.Value == true then
				if dungeonRoom.DoorConnected1.BossRoomConnection.Value == true then
					dungeonRoom.Doorway1.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected1.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway1.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway1.Fog.CanCollide = true
				dungeonRoom.Doorway1.Fog.Transparency = 0
				dungeonRoom.Doorway1.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway1.Fog.Material = Enum.Material.Marble
			end
			
			if dungeonRoom.DoorConnected2.Value == true then
				if dungeonRoom.DoorConnected2.BossRoomConnection.Value == true then
					dungeonRoom.Doorway2.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway2.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected2.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway2.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway2.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway2.Fog.CanCollide = true
				dungeonRoom.Doorway2.Fog.Transparency = 0
				dungeonRoom.Doorway2.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway2.Fog.Material = Enum.Material.Marble
			end
			
			if dungeonRoom.DoorConnected3.Value == true then
				if dungeonRoom.DoorConnected3.BossRoomConnection.Value == true then
					dungeonRoom.Doorway3.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected3.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway3.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway3.Fog.CanCollide = true
				dungeonRoom.Doorway3.Fog.Transparency = 0
				dungeonRoom.Doorway3.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway3.Fog.Material = Enum.Material.Marble
			end
						
			if dungeonRoom.DoorConnected4.Value == true then
				if dungeonRoom.DoorConnected4.BossRoomConnection.Value == true then
					dungeonRoom.Doorway4.Doorway.BrickColor = BrickColor.new('Maroon')
					dungeonRoom.Doorway4.Fog.BrickColor = BrickColor.new('Maroon')
				end
				if dungeonRoom.DoorConnected4.ItemRoomConnection.Value == true then
					dungeonRoom.Doorway4.Doorway.BrickColor = BrickColor.new('Gold')
					dungeonRoom.Doorway4.Fog.BrickColor = BrickColor.new('Gold')
				end
			else
				dungeonRoom.Doorway4.Fog.CanCollide = true
				dungeonRoom.Doorway4.Fog.Transparency = 0
				dungeonRoom.Doorway4.Fog.BrickColor = BrickColor.new('Smoky grey')
				dungeonRoom.Doorway4.Fog.Material = Enum.Material.Marble
			end
			
		end
		
	end
	
end

script.Parent.Touched:Connect(generate)