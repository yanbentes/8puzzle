function love.load()

   -- window title
   love.window.setTitle("8 PUZZLE")

   -- window icon
   iconData = love.window.getIcon()
   love.window.setIcon(iconData)

   -- window and font size
   love.window.setMode(400, 500, {resizable = false, vsync = false})
   love.graphics.setFont(love.graphics.newFont(22))

   require("src/board")
   loadBoard()

   Pause = false
   Moves = 0 -- number of movements
   Timer = 0 -- game time
   
end

function love.update(dt)

   if not Pause then
      Timer = Timer + dt
   end
   
end

function love.draw()
   
   drawBoard()

   if isSolved() then

      Pause = true
      time = Timer
      moves = Moves
      
      love.graphics.setFont(love.graphics.newFont(16))
      love.graphics.print("You solved it!!!", 144, 10)
      love.graphics.print("moves: " .. moves .. string.format(" time: %.1f", time), 120, 35)
      love.graphics.print("Press <r> to restart", 120, 60)
   else
      love.graphics.print(Moves, 0, 10)
      love.graphics.print(string.format("%.1f", Timer), 180, 10)
   end
   
end

function love.mousepressed(x, y, button, istouch, presses)
   
   if button == 1 and y >= 100 and not Pause then
      pressed(x, y, Moves)
   end
   
end

function love.keypressed(key, scancode, isrepeat)
   
   if key == "q" then
      love.event.quit()
   elseif key == "r" then
      love.load()
   end
   
end
