--[[
   1,1 | 2,1 | 3,1
   1,2 | 2,2 | 3,2
   1,3 | 2,3 | 3,3
]]--
require("src/board")
require("src/menu")

function love.load()

    -- window title
   love.window.setTitle("8 PUZZLE")

   -- window icon TODO

   -- window and font size
   love.window.setMode(400, 500, {resizable = false, vsync = false})
   love.graphics.setFont(love.graphics.newFont(22))
   
   loadBoard()

   moves = 0 -- number of movements
   timer = 0 -- game time
   
end

function love.update(dt)
   
   timer = timer + dt
   
end

function love.draw()
   
   drawBoard()

   -- love.graphics.print(timer, 120, 10)
   
end

function love.mousepressed(x, y, button, istouch, presses)
   
   if button == 1 and y >= 100 then
      pressed(x, y, moves)
   end
   
end

function love.keypressed(key, scancode, isrepeat)
   
   if key == "q" then
      love.event.quit()
   elseif key == "r" then
      love.load()
   end
   
end
