game_status = {
	action = "pause",
	selected_menu_item = 1,
	timer = 0
}

game_board = {}

graphics = {
	cell = nil,
	cell_sprite_batch = nil,
	cell_quad = nil,
	font = nil,
	air = nil,
	fire = nil,
	earth = nil,
	water = nil
}


function love.keypressed(key)
	if game_status.action == "play" then
		if key == "escape" then
			game_status.action = "pause"
		end
	elseif game_status.action == "pause" then
		if key == "return" then
			if game_status.selected_menu_item == 1 then
				game_status.action = "play"
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
				game_status.action = "quit"
			end
		elseif key == "escape" then
			game_status.action = "play"
		elseif key == "up" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		elseif key == "down" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		end
	elseif game_status.action == "quit" then
		if key == "return" then
			if game_status.selected_menu_item == 1 then
				game_status.action = "pause"
			elseif game_status.selected_menu_item == 2 then
				love.event.quit()
			end
		elseif key == "y" then
			love.event.quit()
		elseif key == "escape" or key == "n" then
			game_status.action = "pause"
		elseif key == "up" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		elseif key == "down" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
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
	
	graphics.cell = love.graphics.newImage("assets/cell.png")
	graphics.air = love.graphics.newImage("assets/air.png")
	graphics.fire = love.graphics.newImage("assets/fire.png")
	graphics.earth = love.graphics.newImage("assets/earth.png")
	graphics.water = love.graphics.newImage("assets/water.png")
	
	graphics.font = love.graphics.newFont("assets/DejaVuSans.ttf")
	
	graphics.cell_sprite_batch = love.graphics.newSpriteBatch(graphics.cell)
	graphics.cell_quad = love.graphics.newQuad(2, 2, 16, 16, 20, 20)
	
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
			graphics.cell_sprite_batch:add(graphics.cell_quad, (row * 16) - 16, (column * 16) - 16)
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
	love.graphics.setFont(graphics.font)
	
	if game_status.action == "play" then
		love.graphics.setColor(255, 255, 255, 255)
	elseif game_status.action == "pause" or game_status.action == "quit" then
		love.graphics.setColor(128, 128, 128, 255)
	end
	
	love.graphics.draw(graphics.cell_sprite_batch)
	
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
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", (love.graphics.getWidth() / 4), 96, (love.graphics.getWidth() / 2), 96)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf( { {240, 240, 192, 255}, "SIMULATION PAUSED" }, 0, 114, (love.graphics.getWidth()), "center")
		if game_status.selected_menu_item == 1 then
			love.graphics.printf( { {224, 255, 208, 255}, "▶RESUME" }, -5, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 156, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 2 then
			love.graphics.printf( { {208, 208, 208, 255}, "RESUME" }, 0, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {224, 255, 208, 255}, "▶QUIT" }, -4, 156, (love.graphics.getWidth()), "center")
		end
	elseif game_status.action == "quit" then
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", (love.graphics.getWidth() / 4), 96, (love.graphics.getWidth() / 2), 96)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf( { {240, 240, 192, 255}, "QUIT SIMULATION?" }, 0, 114, (love.graphics.getWidth()), "center")
		if game_status.selected_menu_item == 1 then
			love.graphics.printf( { {224, 255, 208, 255}, "▶CANCEL" }, -5, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 156, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 2 then
			love.graphics.printf( { {208, 208, 208, 255}, "CANCEL" }, 0, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {224, 255, 208, 255}, "▶QUIT" }, -4, 156, (love.graphics.getWidth()), "center")
		end
	end
end
