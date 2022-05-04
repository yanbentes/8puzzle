--[[
   1,1 | 2,1 | 3,1
   1,2 | 2,2 | 3,2
   1,3 | 2,3 | 3,3
]]--
function love.load()
   love.window.setMode(400, 500, {resizable = false})
   love.graphics.setFont(love.graphics.newFont(14))

   source = love.graphics.newImage("img/board.png")
   
   tiles = {}
   solved = {} -- tiles in their original positions
   cols = 3
   rows = 3
   -- tiles width and heigth
   w = math.floor(source:getWidth()/3)
   h = math.floor(source:getHeight()/3)

   --[[ f(n) = g(n) + h(n)
   fn = 0
   gn = 0
   hn = 0
   ]]--
   
   cropImage()

   tiles[cols][rows] = -1 -- blank piece position
   solved[cols][rows] = -1 -- blank piece position

   shuffleTiles(tiles)
end

function love.draw()
   for i=1, cols do
      for j=1, rows do
	 local x = (i-1) * w
	 local y = (j-1) * h
	 
	 if tiles[i][j] ~= -1 then
	    love.graphics.draw(source, tiles[i][j], x, y)
	 end
      end
   end

   if isSolved() then
      love.graphics.print("You solved it!!!", 150, 450)
   --[[
   else
      love.graphics.print("f(n)  = " .. fn, 20, 410)
      love.graphics.print("g(n) = " .. gn, 20, 440)
      love.graphics.print("h(n) = " .. hn, 20, 470)
   ]]--
   end
   
end

function love.mousepressed(x, y, button, istouch, presses)
   if button == 1 then
      -- need the plus 1 because in lua the iterator starts at 1
      -- i and j are the position in the table
      -- x and y are the position in the window
      i = math.floor(x/w) + 1
      j = math.floor(y/h) + 1
      
      move(tiles, i, j)
   end
end

-- crop source image into tiles
function cropImage()
   for i=1, cols do
      tiles[i] = {}
      solved[i] = {}
      for j=1, rows do
	 local x = (i-1) * w
	 local y = (j-1) * h

	 tile = love.graphics.newQuad(x, y, w, h, source:getDimensions())
	 tiles[i][j] = tile
	 solved[i][j] = tile
      end
   end
end

-- shuffle the tiles position in the table
function shuffleTiles(arr)
   for i=1, cols do
      for j=1, rows do
	 math.randomseed(os.time())
	 i1 = math.random(1, cols)
	 j1 = math.random(1, rows)

	 swap(arr, i, j, i1, j1)
      end
   end
end

-- utility function to swap elements in the table
function swap(arr, i1, j1, i2, j2)
   temp = arr[i1][j1]
   arr[i1][j1] = arr[i2][j2]
   arr[i2][j2] = temp
end

-- move piece with next to the blank piece
function move(arr, i, j)
   blankCol, blankRow = findBlank()

   if isNeighbor(i, j, blankCol, blankRow) then
      swap(arr, i, j, blankCol, blankRow)
   end
end

function findBlank()
   for i=1, cols do
      for j=1, rows do
	 if tiles[i][j] == -1 then
	    return i, j
	 end
      end
   end
end

function isNeighbor(i, j, x, y)
   if i ~= x and j ~= y then
      return false
   end

  if math.abs(i - x) == 1 or math.abs(j - y) == 1 then
     return true
  end
  
  return false;
end

function isSolved()
   for i=1, cols do
      for j=1, rows do
	 if solved[i][j] ~= tiles[i][j] then
	    return false
	 end
      end
   end

   return true
end
