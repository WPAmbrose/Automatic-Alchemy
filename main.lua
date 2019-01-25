game_status = {
	menu = "none",
	action = nil,
	selected_menu_item = 1,
	selector_x = 1,
	selector_y = 1,
	grid_size_x = 0,
	grid_size_y = 0,
	current_element = nil,
	timer = 0
}

game_board = {}

graphics = {
	cell = nil,
	cell_sprite_batch = nil,
	cell_quad = nil,
	selected_cell = nil,
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
			elseif key == "up" or scancode == "w" or scancode == "k" then
				if game_status.selector_y > 1 then
					game_status.selector_y = game_status.selector_y - 1
				elseif game_status.selector_y <= 1 then
					game_status.selector_y = game_status.grid_size_y
				end
			elseif key == "down" or scancode == "s" or scancode == "j" then
				if game_status.selector_y < game_status.grid_size_y then
					game_status.selector_y = game_status.selector_y + 1
				elseif game_status.selector_y >= game_status.grid_size_y then
					game_status.selector_y = 1
				end
			elseif key == "left" or scancode == "a" or scancode == "h" then
				if game_status.selector_x > 1 then
					game_status.selector_x = game_status.selector_x - 1
				elseif game_status.selector_x <= 1 then
					game_status.selector_x = game_status.grid_size_x
				end
			elseif key == "right" or scancode == "d" or scancode == "l" then
				if game_status.selector_x < game_status.grid_size_x then
					game_status.selector_x = game_status.selector_x + 1
				elseif game_status.selector_x >= game_status.grid_size_x then
					game_status.selector_x = 1
				end
			elseif key == "space" or scancode == "=" or scancode == "+" or scancode == "kp+" or key == "return" or scancode == "kpenter" or scancode == "pageup" then
				if game_board[game_status.selector_x][game_status.selector_y].element == "earth" then
					game_status.current_element = "water"
					game_board[game_status.selector_x][game_status.selector_y].element = "water"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "water" then
					game_status.current_element = "air"
					game_board[game_status.selector_x][game_status.selector_y].element = "air"
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "air" then
					game_status.current_element = "fire"
					game_board[game_status.selector_x][game_status.selector_y].element = "fire"
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "fire" then
					game_status.current_element = "none"
					game_board[game_status.selector_x][game_status.selector_y].element = "none"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "none" then
					if game_status.current_element == "none" then
						game_status.current_element = "earth"
						game_board[game_status.selector_x][game_status.selector_y].element = "earth"
					else
						game_board[game_status.selector_x][game_status.selector_y].element = game_status.current_element
					end
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
				end
			elseif scancode == "-" or scancode == "kp-" or key == "backspace" or scancode == "pagedown" then
				if game_board[game_status.selector_x][game_status.selector_y].element == "none" then
					if game_status.current_element == "none" then
						game_status.current_element = "fire"
						game_board[game_status.selector_x][game_status.selector_y].element = "fire"
					else
						game_board[game_status.selector_x][game_status.selector_y].element = game_status.current_element
					end
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "fire" then
					game_status.current_element = "air"
					game_board[game_status.selector_x][game_status.selector_y].element = "air"
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "air" then
					game_status.current_element = "water"
					game_board[game_status.selector_x][game_status.selector_y].element = "water"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "water" then
					game_status.current_element = "earth"
					game_board[game_status.selector_x][game_status.selector_y].element = "earth"
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 4
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
				elseif game_board[game_status.selector_x][game_status.selector_y].element == "earth" then
					game_status.current_element = "none"
					game_board[game_status.selector_x][game_status.selector_y].element = "none"
					game_board[game_status.selector_x][game_status.selector_y].aspects.hot = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.dry = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.cold = 1
					game_board[game_status.selector_x][game_status.selector_y].aspects.wet = 1
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
				if game_status.action == "edit" then
					game_status.action = "live"
				elseif game_status.action == "live" then
					game_status.action = "edit"
				end
			elseif game_status.selected_menu_item == 3 then
				game_status.selected_menu_item = 1
				game_status.menu = "quit"
			end
		elseif scancode == "escape" then
			game_status.menu = "none"
			game_status.selected_menu_item = 1
		elseif scancode == "up" then
			if game_status.selected_menu_item == 1 then
				game_status.selected_menu_item = 3
			else
				game_status.selected_menu_item = game_status.selected_menu_item - 1
			end
		elseif scancode == "down" then
			if game_status.selected_menu_item == 3 then
				game_status.selected_menu_item = 1
			else
				game_status.selected_menu_item = game_status.selected_menu_item + 1
			end
		end
	elseif game_status.menu == "quit" then
		if key == "return" then
			if game_status.selected_menu_item == 1 then
				game_status.menu = "pause"
			elseif game_status.selected_menu_item == 2 then
				love.event.quit()
			end
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
		elseif key == "escape" or key == "backspace" then
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
					hot = 1,
					wet = 1,
					cold = 1,
					dry = 1
				}
			}
			if (row == 6 or row == 7) and (column >= 4 and column <= 10) then
				game_board[row][column].element = "fire"
				game_board[row][column].aspects.hot = 4
				game_board[row][column].aspects.dry = 4
				game_board[row][column].aspects.cold = 1
				game_board[row][column].aspects.wet = 1
			elseif (row == 10 or row == 11) and (column >= 7 and column <= 13) then
				game_board[row][column].element = "earth"
				game_board[row][column].aspects.dry = 4
				game_board[row][column].aspects.cold = 4
				game_board[row][column].aspects.wet = 1
				game_board[row][column].aspects.hot = 1
			elseif (row == 14 or row == 15) and (column >= 10 and column <= 16) then
				game_board[row][column].element = "water"
				game_board[row][column].aspects.cold = 4
				game_board[row][column].aspects.wet = 4
				game_board[row][column].aspects.hot = 1
				game_board[row][column].aspects.dry = 1
			elseif (row == 18 or row == 19) and (column >= 13 and column <= 19) then
				game_board[row][column].element = "air"
				game_board[row][column].aspects.wet = 4
				game_board[row][column].aspects.hot = 4
				game_board[row][column].aspects.dry = 1
				game_board[row][column].aspects.cold = 1
			end
			graphics.cell_sprite_batch:add(graphics.cell_quad, (row * 16) - 16, (column * 16) - 16)
		end
	end
	
	game_status.grid_size_x = #game_board
	game_status.grid_size_y = #game_board[1]
	
	game_status.selector_x = math.floor(game_status.grid_size_x / 2)
	game_status.selector_y = math.floor(game_status.grid_size_y / 2)
	
	game_status.current_element = "earth"
	
	game_status.action = "edit"
end -- love.load


function love.update(dt)
	if game_status.menu == "none" then
		if game_status.action == "live" then
			-- apply the rules to affect the world
			if game_status.timer >= 0 and game_status.timer < 0.65 then
				game_status.timer = game_status.timer + dt
			elseif game_status.timer >= 0.65 then
				-- the cycle is complete
				for row_index, row_contents in pairs(game_board) do
					for column_index, cell_contents in pairs(game_board[row_index]) do
						-- iterate over cells
						
						-- set up useful shortcuts to data
						local neighbors = {
							top_cell = {},
							bottom_cell = {},
							left_cell = {},
							right_cell = {},
							top_left_cell = {},
							top_right_cell = {},
							bottom_left_cell = {},
							bottom_right_cell = {}
						}
						local top_free = column_index > 1
						local bottom_free = column_index < game_status.grid_size_y
						local left_free = row_index > 1
						local right_free = row_index < game_status.grid_size_x
						
						local top_reference = 0
						local bottom_reference = 0
						local left_reference = 0
						local right_reference = 0
						
						if top_free then
							top_reference = column_index - 1
						else
							top_reference = game_status.grid_size_y
						end
						if bottom_free then
							bottom_reference = column_index + 1
						else
							bottom_reference = 1
						end
						if left_free then
							left_reference = row_index - 1
						else
							left_reference = game_status.grid_size_x
						end
						if right_free then
							right_reference = row_index + 1
						else
							right_reference = 1
						end
						
						neighbors.top_cell = game_board[row_index][top_reference]
						neighbors.bottom_cell = game_board[row_index][bottom_reference]
						neighbors.left_cell = game_board[left_reference][column_index]
						neighbors.right_cell = game_board[right_reference][column_index]
						neighbors.top_left_cell = game_board[left_reference][top_reference]
						neighbors.bottom_left_cell = game_board[left_reference][bottom_reference]
						neighbors.top_right_cell = game_board[right_reference][top_reference]
						neighbors.bottom_right_cell = game_board[right_reference][bottom_reference]
						
						for neighbor_name, neighbor_contents in pairs(neighbors) do
							for name, aspect in pairs(neighbor_contents.aspects) do
								if aspect >= 4 then
									cell_contents.aspects[name] = cell_contents.aspects[name] + (1 / 4)
									if name == "hot" then
										cell_contents.aspects.cold = cell_contents.aspects.cold - (1 / 4)
									elseif name == "wet" then
										cell_contents.aspects.dry = cell_contents.aspects.dry - (1 / 4)
									elseif name == "cold" then
										cell_contents.aspects.hot = cell_contents.aspects.hot - (1 / 4)
									elseif name == "dry" then
										cell_contents.aspects.wet = cell_contents.aspects.wet - (1 / 4)
									end
								elseif aspect == 3 then
									cell_contents.aspects[name] = cell_contents.aspects[name] + (1 / 8)
									if name == "hot" then
										cell_contents.aspects.cold = cell_contents.aspects.cold - (1 / 8)
									elseif name == "wet" then
										cell_contents.aspects.dry = cell_contents.aspects.dry - (1 / 8)
									elseif name == "cold" then
										cell_contents.aspects.hot = cell_contents.aspects.hot - (1 / 8)
									elseif name == "dry" then
										cell_contents.aspects.wet = cell_contents.aspects.wet - (1 / 8)
									end
								elseif aspect == 2 then
									cell_contents.aspects[name] = cell_contents.aspects[name] + (1 / 16)
									if name == "hot" then
										cell_contents.aspects.cold = cell_contents.aspects.cold - (1 / 16)
									elseif name == "wet" then
										cell_contents.aspects.dry = cell_contents.aspects.dry - (1 / 16)
									elseif name == "cold" then
										cell_contents.aspects.hot = cell_contents.aspects.hot - (1 / 16)
									elseif name == "dry" then
										cell_contents.aspects.wet = cell_contents.aspects.wet - (1 / 16)
									end
								end
							end
						end
						
						
						if cell_contents.aspects.cold > 4 then
							cell_contents.aspects.hot = cell_contents.aspects.hot - (1 / 4)
							cell_contents.aspects.cold = 4
						elseif cell_contents.aspects.wet > 4 then
							cell_contents.aspects.dry = cell_contents.aspects.dry - (1 / 4)
							cell_contents.aspects.wet = 4
						elseif cell_contents.aspects.dry > 4 then
							cell_contents.aspects.wet = cell_contents.aspects.wet - (1 / 4)
							cell_contents.aspects.dry = 4
						elseif cell_contents.aspects.hot > 4 then
							cell_contents.aspects.cold = cell_contents.aspects.cold - (1 / 4)
							cell_contents.aspects.hot = 4
						end
						
						for name, aspect in pairs(cell_contents.aspects) do
							aspect = math.floor(aspect + 0.5)
							if aspect > 4 then
								aspect = 4
							elseif aspect < 1 then
								aspect = 1
							end
						end
						
						
						if cell_contents.aspects.hot > 2 and cell_contents.aspects.dry > 2 and cell_contents.aspects.wet <= 2 and cell_contents.aspects.cold <= 2 then
							cell_contents.element = "fire"
						elseif cell_contents.aspects.hot > 2 and cell_contents.aspects.wet > 2 and cell_contents.aspects.cold <= 2 and cell_contents.aspects.dry <= 2 then
							cell_contents.element = "air"
						elseif cell_contents.aspects.cold > 2 and cell_contents.aspects.wet > 2 and cell_contents.aspects.hot <= 2 and cell_contents.aspects.dry <= 2 then
							cell_contents.element = "water"
						elseif cell_contents.aspects.cold > 2 and cell_contents.aspects.dry > 2 and cell_contents.aspects.hot <= 2 and cell_contents.aspects.wet <= 2 then
							cell_contents.element = "earth"
						end
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
		love.graphics.rectangle("fill", (love.graphics.getWidth() / 4), 96, (love.graphics.getWidth() / 2), 114)
		love.graphics.setColor(255, 255, 255, 255)
		if game_status.action == "live" then
			love.graphics.printf( { {240, 240, 160, 255}, "REACTION PAUSED" }, 0, 114, (love.graphics.getWidth()), "center")
		elseif game_status.action == "edit" then
			love.graphics.printf( { {240, 240, 160, 255}, "EDITING PAUSED" }, 0, 114, (love.graphics.getWidth()), "center")
		end
		if game_status.selected_menu_item == 1 then
			love.graphics.printf( { {208, 255, 176, 255}, "▶RESUME" }, -5, 138, (love.graphics.getWidth()), "center")
			if game_status.action == "edit" then
				love.graphics.printf( { {208, 208, 208, 255}, "START REACTION" }, 0, 156, (love.graphics.getWidth()), "center")
			elseif game_status.action == "live" then
				love.graphics.printf( { {208, 208, 208, 255}, "ENTER EDIT MODE" }, 0, 156, (love.graphics.getWidth()), "center")
			end
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 174, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 2 then
			love.graphics.printf( { {208, 208, 208, 255}, "RESUME" }, 0, 138, (love.graphics.getWidth()), "center")
			if game_status.action == "edit" then
				love.graphics.printf( { {208, 255, 176, 255}, "▶START REACTION" }, -4, 156, (love.graphics.getWidth()), "center")
			elseif game_status.action == "live" then
				love.graphics.printf( { {208, 255, 176, 255}, "▶ENTER EDIT MODE" }, -5, 156, (love.graphics.getWidth()), "center")
			end
			love.graphics.printf( { {208, 208, 208, 255}, "QUIT" }, 0, 174, (love.graphics.getWidth()), "center")
		elseif game_status.selected_menu_item == 3 then
			love.graphics.printf( { {208, 208, 208, 255}, "RESUME" }, 0, 138, (love.graphics.getWidth()), "center")
			if game_status.action == "edit" then
				love.graphics.printf( { {208, 208, 208, 255}, "START REACTION" }, 0, 156, (love.graphics.getWidth()), "center")
			elseif game_status.action == "live" then
				love.graphics.printf( { {208, 208, 208, 255}, "ENTER EDIT MODE" }, 0, 156, (love.graphics.getWidth()), "center")
			end
			love.graphics.printf( { {208, 255, 176, 255}, "▶QUIT" }, -4, 174, (love.graphics.getWidth()), "center")
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
