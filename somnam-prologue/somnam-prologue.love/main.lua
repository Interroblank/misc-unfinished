-- Somnam: Prologue
-- Interroblank, 2020

-- Initializing.
love.window.setFullscreen(true)
love.mouse.setVisible(false)
-- love.window.setMode(1680, 1050) -- For resolution testing.
screen_w = love.graphics.getWidth()
screen_h = love.graphics.getHeight()
scale_w = screen_w / 1920
scale_h = screen_h / 1080
require('util')
require('colls')
require('zones')

-- TODO - Account for different aspect ratios.

-- Loading assets.
function love.load()
  som_font_main = love.graphics.newFont('interface/SONORM__.ttf', 48)
  user = love.graphics.newImage('entities/user.png')  -- The player character.
  menu = love.graphics.newImage('interface/menu.png') -- The main menu background.
end

-- Global variables.
user_x = (screen_w / 2) - 50; -- Centered.
user_y = (screen_h / 2) - 50; -- Centered.
state = {
  menu = true,
  game = false,
}

user_colls = {
  -- TODO - Account for scaling.
  -- Determined by the 100 x 100 dimensions of the player character.
  top_left =      {user_x, user_y},
  top_right =     {user_x + 100, user_y},
  bottom_left =   {user_x, user_y - 100},
  bottom_right =  {user_x + 100, user_y - 100}
}

-- Main menu variables.
local menu_state = {
  menu_start = true,
  menu_exit = false,
}

function love.draw()
  -- Scaling.
  love.graphics.push()
  love.graphics.scale(scale_w, scale_h)

    -- The main menu state.
    if state.menu == true then
      -- Drawing.
      local menu_start_txt = 'DESCEND'
      local menu_exit_txt = 'FLEE'
      -- local scaled_center_w = (screen_w / 2) * scale_w
      -- local scaled_center_h = (screen_h / 2) * scale_h
      love.graphics.setFont(som_font_main)
      love.graphics.draw(menu, 0, 0)
      if (menu_state.menu_start == true) then -- TODO - Account for different resolutions. This currently does not scale properly.
        love.graphics.printf('[ ' .. menu_start_txt .. ' ]', 0, (screen_h / 2) + 300, screen_w, 'center')
        love.graphics.printf(menu_exit_txt, 0, (screen_h / 2) + 375, screen_w, 'center')
      end
      if (menu_state.menu_exit == true) then -- TODO - Account for different resolutions. This currently does not scale properly.
        love.graphics.printf(menu_start_txt, 0, (screen_h / 2) + 300, screen_w, 'center')
        love.graphics.printf('[ ' .. menu_exit_txt .. ' ]', 0, (screen_h / 2) + 375, screen_w, 'center')
      end
    end

    -- The active game state.
    if state.game == true then
      -- Drawing.
      -- love.graphics.print('Detected Resolution:' .. screen_w .. 'x' .. screen_h, 0, 0)
      love.graphics.draw(user, user_x * scale_w, user_y * scale_h)
    end

  love.graphics.pop()
end

function love.update(dt)
  if (collisionCheck(user_colls, test_room)) == true then -- Check if the movement is allowed.
    if love.keyboard.isDown('w') then
      if love.keyboard.isDown('lshift') then
        user_y = user_y - (2 * scale_h)
      else
        user_y = user_y - (1 * scale_h)
      end
    end
    if love.keyboard.isDown('a') then
      if love.keyboard.isDown('lshift') then
        user_x = user_x - (2 * scale_w)
      else
        user_x = user_x - (1 * scale_w)
      end
    end
    if love.keyboard.isDown('s') then
      if love.keyboard.isDown('lshift') then
        user_y = user_y + (2 * scale_h)
      else
        user_y = user_y + (1 * scale_h)
      end
    end
    if love.keyboard.isDown('d') then
      if love.keyboard.isDown('lshift') then
        user_x = user_x + (2 * scale_w)
      else
        user_x = user_x + (1 * scale_w)
      end
    end
  end
end

function love.keypressed(key)
  -- Will close the game if 'ESC' is pressed.
  -- if key == 'escape' then
  --   love.event.quit()
  -- end
  -- For the main menu state.
  if state.menu == true then
    if key == 'w' or key == 'up' then
      if menu_state.menu_start == false then
        -- stateWipe(menu_state) -- TODO
        menu_state.menu_exit = false
        menu_state.menu_start = true
      end
    end
    if key == 's' or key == 'down' then
      if menu_state.menu_start == true then
        -- stateWipe(menu_state) -- TODO
        menu_state.menu_start = false
        menu_state.menu_exit = true
      end
    end
    if key == 'space' or key == 'return' then
      if menu_state.menu_start == true then
        -- stateWipe(state) -- TODO
        state.menu = false
        state.game = true
      end
      if menu_state.menu_exit == true then
        love.event.quit()
      end
    end
  end
end
