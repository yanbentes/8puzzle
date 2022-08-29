function loadBoard()
   
   -- board image
   source = love.graphics.newImage("assets/board.png")
   
   tiles = {}
   solved = {} -- tiles in their original positions
   cols = 3
   rows = 3
   
   -- tiles width and heigth
   w = math.floor(source:getWidth()/3)
   h = math.floor(source:getHeight()/3)
   
   cropImage()

   tiles[cols][rows] = -1 -- blank piece position
   solved[cols][rows] = -1 -- blank piece position

   shuffleTiles(tiles)
   
end

function drawBoard()

   for i=1, cols do
      for j=1, rows do
	 local x = (i-1) * w
	 local y = ((j-1) * h) + 100
	 
	 if tiles[i][j] ~= -1 then
	    love.graphics.draw(source, tiles[i][j], x, y)
	 end
      end
   end

   if isSolved() then
      local result = start - love.timer.getTime()
      
      love.graphics.setFont(love.graphics.newFont(16))
      love.graphics.print("You solved it!!!", 144, 10)
      -- love.graphics.print("moves: " .. moves .. " time: " .. result, 120, 35)
      love.graphics.print("Press <r> to restart", 120, 60)
   else
      love.graphics.print(moves)
   end
   
end

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

function pressed(pos_x, pos_y, mov)
   
   -- need the plus 1 because in lua the iterator starts at 1
   -- i and j are the position in the table
   -- x and y are the position in the window
   i = math.floor(pos_x/w) + 1
   j = math.floor((pos_y-100)/h) + 1
   
   moveTiles(tiles, i, j, mov)
   
end

function moveTiles(arr, i, j, mov)
   
   blankCol, blankRow = findBlank()

   if isNeighbor(i, j, blankCol, blankRow) then
      swap(arr, i, j, blankCol, blankRow)

      moves = moves + 1
   end
   
end

function swap(arr, i1, j1, i2, j2)
   
   temp = arr[i1][j1]
   arr[i1][j1] = arr[i2][j2]
   arr[i2][j2] = temp
   
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
