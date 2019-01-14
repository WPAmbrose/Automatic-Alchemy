game_status = {
	menu = "none",
	action = nil,
	selected_menu_item = 1,
	selector_x = 1,
	selector_y = 1,
	timer = 0
}

game_board = {}

graphics = {
	cell = nil,
	cell_sprite_batch = nil,
	cell_quad = nil,
	selected_cell = nil,
	grid_size_x = 0,
	grid_size_y = 0,
	font = nil,
	air = nil,
	fire = nil,
	earth = nil,
	water = nil
}


function love.keypressed(key, scancode)
	if game_status.menu == "none" then
		if game_status.action == "edit" then
			if scancode == "escape" then
				game_status.menu = "pause"
			elseif scancode == "up" or scancode == "w" or scancode == "k" then
				if game_status.selector_y > 1 then
					game_status.selector_y = game_status.selector_y - 1
				elseif game_status.selector_y <= 1 then
					game_status.selector_y = game_status.grid_size_y
				end
			elseif scancode == "down" or scancode == "s" or scancode == "j" then
				if game_status.selector_y < game_status.grid_size_y then
					game_status.selector_y = game_status.selector_y + 1
				elseif game_status.selector_y >= game_status.grid_size_y then
					game_status.selector_y = 1
				end
			elseif scancode == "left" or scancode == "a" or scancode == "h" then
				if game_status.selector_x > 1 then
					game_status.selector_x = game_status.selector_x - 1
				elseif game_status.selector_x <= 1 then
					game_status.selector_x = game_status.grid_size_x
				end
			elseif scancode == "right" or scancode == "d" or scancode == "l" then
				if game_status.selector_x < game_status.grid_size_x then
					game_status.selector_x = game_status.selector_x + 1
				elseif game_status.selector_x >= game_status.grid_size_x then
					game_status.selector_x = 1
				end
			elseif scancode == "space" or scancode == "=" or scancode == "+" or scancode == "kp+" or scancode == "return" or scancode == "kpenter" then
				if game_board[game_status.selector_x][game_status.selector_y].element == "earth" then
					game_board[game_status.selector_x][game_status.selector_y].element = "water"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "water" then
					game_board[game_status.selector_x][game_status.selector_y].element = "air"
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "air" then
					game_board[game_status.selector_x][game_status.selector_y].element = "fire"
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "fire" then
					game_board[game_status.selector_x][game_status.selector_y].element = "none"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "none" then
					game_board[game_status.selector_x][game_status.selector_y].element = "earth"
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
				end
			elseif scancode == "-" or scancode == "kp-" or scancode == "backspace" then
				if game_board[game_status.selector_x][game_status.selector_y].element == "none" then
					game_board[game_status.selector_x][game_status.selector_y].element = "fire"
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "fire" then
					game_board[game_status.selector_x][game_status.selector_y].element = "air"
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "air" then
					game_board[game_status.selector_x][game_status.selector_y].element = "water"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "water" then
					game_board[game_status.selector_x][game_status.selector_y].element = "earth"
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "earth" then
					game_board[game_status.selector_x][game_status.selector_y].element = "none"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 0
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 0
				end
			end
		elseif game_status.action == "live" then
			if scancode == "escape" then
				game_status.menu = "pause"
			end
		end
	elseif game_status.menu == "pause" then
		if scancode == "return" then
			if game_status.selected_menu_item == 1 then
				game_status.menu = "none"
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
				game_status.menu = "quit"
			end
		elseif scancode == "escape" then
			game_status.menu = "none"
		elseif scancode == "up" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		elseif scancode == "down" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		end
	elseif game_status.menu == "quit" then
		if scancode == "return" then
			if game_status.selected_menu_item == 1 then
				game_status.menu = "pause"
			elseif game_status.selected_menu_item == 2 then
				love.event.quit()
			end
		elseif scancode == "up" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		elseif scancode == "down" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 2
			elseif game_status.selected_menu_item == 2 then
				game_status.selected_menu_item = 1
			end
		elseif scancode == "escape" or scancode == "backspace" then
			game_status.selected_menu_item = 1
			game_status.menu = "pause"
		end
	end
end -- love.keypressed


function love.quit()
	-- deal with the player trying to quit the game
	if game_status.menu ~= "quit" then
		-- don't quit
		game_status.menu = "quit"
		return true
	elseif game_status.menu == "quit" then
		-- completely quit the game
		return false
	end
end


function love.load()
	love.graphics.setBackgroundColor(32, 32, 32)
	
	graphics.cell = love.graphics.newImage("assets/cell.png")
	graphics.selected_cell = love.graphics.newImage("assets/selected_cell.png")
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
	
	game_status.grid_size_x = #game_board
	game_status.grid_size_y = #game_board[1]
	
	game_status.selector_x = math.floor(game_status.grid_size_x / 2)
	game_status.selector_y = math.floor(game_status.grid_size_y / 2)
	
	game_status.action = "edit"
end -- love.load


function love.update(dt)
	if game_status.menu == "none" then
		if game_status.action == "live" then
			-- apply the rules affect the world
			if game_status.timer >= 0 and game_status.timer < 1 then
				game_status.timer = game_status.timer + dt
			elseif game_status.timer >= 1 then
				-- the cycle is complete
				for row_index, row_contents in pairs(game_board) do
					for column_index, tile_contents in pairs(game_board[row_index]) do
						-- iterate over cells
					end
				end
				game_status.timer = 0
			end
		elseif game_status.action == "edit" then
			-- let the user place cells
		end
	end
end


function love.draw()
	love.graphics.setFont(graphics.font)
	
	-- dim the screen if paused
	if game_status.menu == "none" then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(128, 128, 128, 255)
	end
	
	-- draw the cell outlines
	love.graphics.draw(graphics.cell_sprite_batch)
	
	-- show the cell selector if in edit mode
	if game_status.action == "edit" then
		love.graphics.draw(graphics.selected_cell, game_status.selector_x * 16 - 16, game_status.selector_y * 16 - 16)
	end
	
	-- draw the cell contents
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
	
	-- draw menus
	if game_status.menu == "pause" then
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", (love.graphics.getWidth() / 4), 96, (love.graphics.getWidth() / 2), 96)
		love.graphics.setColor(255, 255, 255, 255)
		if game_status.action == "live" then
			love.graphics.printf( { {240, 240, 160, 255}, "REACTION PAUSED" }, 0, 114, (love.graphics.getWidth()), "center")
		elseif game_status.action == "edit" then
			love.graphics.printf( { {240, 240, 160, 255}, "EDITING PAUSED" }, 0, 114, (love.graphics.getWidth()), "center")
		end
		if game_status.selected_menu_item == 1 then
			love.graphics.printf( { {208, 255, 176, 255}, "▶RESUME" }, -5, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 156, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 2 then
			love.graphics.printf( { {208, 208, 208, 255}, "RESUME" }, 0, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 255, 176, 255}, "▶QUIT" }, -4, 156, (love.graphics.getWidth()), "center")
		end
	elseif game_status.menu == "quit" then
		love.graphics.setColor(0, 0, 0, 192)
		love.graphics.rectangle("fill", (love.graphics.getWidth() / 4), 96, (love.graphics.getWidth() / 2), 96)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf( { {240, 240, 160, 255}, "QUIT SIMULATION?" }, 0, 114, (love.graphics.getWidth()), "center")
		if game_status.selected_menu_item == 1 then
			love.graphics.printf( { {208, 255, 176, 255}, "▶CANCEL" }, -5, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 156, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 2 then
			love.graphics.printf( { {208, 208, 208, 255}, "CANCEL" }, 0, 138, (love.graphics.getWidth()), "center")
			love.graphics.printf( { {208, 255, 176, 255}, "▶QUIT" }, -4, 156, (love.graphics.getWidth()), "center")
		end
	end
end -- love.draw
