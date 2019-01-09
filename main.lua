game_status = {
	action = "pause",
	timer = 0
}

game_board = {}

graphics = {
	air = nil,
	fire = nil,
	earth = nil,
	water = nil
}


function love.keypressed(key)
	if game_status.action == "pause" then
		if key == "escape" then
			game_status.action = "play"
		end
	elseif game_status.action == "play" then
		if key == "escape" then
			game_status.action = "pause"
		end
	elseif game_status.action == "quit" then
		if key == "return" or key == "y" then
			love.event.quit()
		elseif key == "escape" or key == "n" then
			game_status.action = "pause"
		end
	end
end

function love.quit()
	-- deal with the player trying to quit the game
	if game_status.action ~= "quit" then
		-- don't quit
		game_status.action = "quit"
		return true
	elseif game_status.action == "quit" then
		-- completely quit the game
		return false
	end
end


function love.load()
	love.graphics.setBackgroundColor(16, 16, 16)
	
	graphics.air = love.graphics.newImage("assets/air.png")
	graphics.fire = love.graphics.newImage("assets/fire.png")
	graphics.earth = love.graphics.newImage("assets/earth.png")
	graphics.water = love.graphics.newImage("assets/water.png")
	
	for row = 1, love.graphics.getWidth() / 16 do
		game_board[row] = {}
		for column = 1, love.graphics.getHeight() / 16 do
			game_board[row][column] = {
				element = "none",
				aspects = {
					hot = 0,
					dry = 0,
					cold = 0,
					wet = 0
				}
			}
			if row == 2 then
				game_board[row][column].element = "fire"
				game_board[row][column].aspects.hot = 4
				game_board[row][column].aspects.dry = 4
			elseif row == 4 then
				game_board[row][column].element = "earth"
				game_board[row][column].aspects.dry = 4
				game_board[row][column].aspects.cold = 4
			elseif row == 6 then
				game_board[row][column].element = "water"
				game_board[row][column].aspects.cold = 4
				game_board[row][column].aspects.wet = 4
			elseif row == 8 then
				game_board[row][column].element = "air"
				game_board[row][column].aspects.wet = 4
				game_board[row][column].aspects.hot = 4
			end
		end
	end
end


function love.update(dt)
	if game_status == "play" then
		-- affect the world
		if timer >= 0 and timer < 1 then
			timer = timer + dt
		elseif timer >= 1 then
			-- the cycle is complete
			for row_index, row_contents in pairs(game_board) do
				for column_index, tile_contents in pairs(game_board[row_index]) do
					-- iterate over cells
					
				end
			end
			timer = 0
		end
	end
end

function love.draw()
	local top = 0
	local side = 0
	
	if game_status.action == "play" then
		love.graphics.setColor(255, 255, 255, 255)
	elseif game_status.action == "pause" or game_status.action == "quit" then
		love.graphics.setColor(128, 128, 128, 255)
	end
	
	love.graphics.setLineWidth(2)
	for side = 0, 320, 16 do
		love.graphics.line(0, side, 480, side)
	end
	for top = 0, 480, 16 do
		love.graphics.line(top, 0, top, 320)
	end
	
	for row_index, row_contents in pairs(game_board) do
		for column_index, cell_contents in pairs(game_board[row_index]) do
			if cell_contents.element == "none" then
				-- leave the cell blank
			elseif cell_contents.element == "air" then
				love.graphics.draw(graphics.air, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif cell_contents.element == "fire" then
				love.graphics.draw(graphics.fire, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif cell_contents.element == "earth" then
				love.graphics.draw(graphics.earth, (row_index * 16 - 16), (column_index * 16 - 16))
			elseif cell_contents.element == "water" then
				love.graphics.draw(graphics.water, (row_index * 16 - 16), (column_index * 16 - 16))
			end
		end
	end
	
	love.graphics.setColor(255, 255, 255, 255)
	
	if game_status.action == "pause" then
		love.graphics.printf( { {240, 240, 240, 255}, "SIMULATION PAUSED" }, 0, 112, (love.graphics.getWidth()), "center")
	elseif game_status.action == "quit" then
		love.graphics.printf( { {240, 240, 240, 255}, "QUIT SIMULATION? (Y/N)" }, 0, 112, (love.graphics.getWidth()), "center")
	end
end
