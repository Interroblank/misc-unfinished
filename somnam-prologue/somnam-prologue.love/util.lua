-- Somnam: Prologue
-- Interroblank, 2020

-- Will turn every state in a state table to 'false'. (?)
function stateWipe(stateTable)
  for name, state in pairs(stateTable) do
    state = false
  end
end

-- Will determine whether or not a movement is allowed and return true or false.
function collisionCheck(toMove_collTable, currRoom_collTable)
  -- TODO
end
