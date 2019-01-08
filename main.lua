game_status = "pause"

game_board = {}

for row = 1, love.graphics.getWidth() / 16 do
	game_board[row] = {}
	for column = 1, love.graphics.getHeight() / 16 do
		if row == 1 then
			game_board[row][column] = "fire"
		else
			game_board[row][column] = "empty"
		end
	end
end

function love.load()
	love.graphics.setBackgroundColor(16, 16, 16)
	
	air = love.graphics.newImage("assets/air.png")
	fire = love.graphics.newImage("assets/fire.png")
	earth = love.graphics.newImage("assets/earth.png")
	water = love.graphics.newImage("assets/water.png")
end

function love.keypressed(key)
	if key == "p" then
		if game_status == "pause" then
			game_status = "play"
		elseif game_status == "play" then
			game_status = "pause"
		end
	end
end

function love.update(dt)
	if game_status == "play" then
		-- affect the world
	end
end

function love.draw()
	local top = 0
	local side = 0
	local screen = {}
	
	love.graphics.setColor(224, 224, 224, 255)
	love.graphics.setLineWidth(2)
	
	for side = 0, 320, 16 do
		love.graphics.line(0, side, 480, side)
	end
	
	for top = 0, 480, 16 do
		love.graphics.line(top, 0, top, 320)
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	
	
	if game_status == "play" then
		screen = {255, 255, 255, 255}
	elseif game_status == "pause" then
		screen = {128, 128, 128, 255}
	end
	
	for row_index, row_contents in pairs(game_board) do
		for column_index, tile_contents in pairs(game_board[row_index]) do
			if tile_contents == "empty" then
				love.graphics.setColor(16, 16, 16, 255)
				love.graphics.rectangle("fill", (row_index * 16 - 16) + 1, (column_index * 16 - 16) + 1, 14, 14)
				love.graphics.setColor(255, 255, 255, 255)
			elseif tile_contents == "air" then
				love.graphics.setColor(screen)
				love.graphics.draw(air, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif tile_contents == "fire" then
				love.graphics.setColor(screen)
				love.graphics.draw(fire, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif tile_contents == "earth" then
				love.graphics.setColor(screen)
				love.graphics.draw(earth, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif tile_contents == "water" then
				love.graphics.setColor(screen)
				love.graphics.draw(water, (row_index * 16 - 16), (column_index * 16 - 16))
			end
		end
	end
	
	if game_status == "pause" then
		love.graphics.printf( { {255, 255, 255, 255}, "G A M E   P A U S E D" }, 0, 112, (love.graphics.getWidth()), "center")
	end
end