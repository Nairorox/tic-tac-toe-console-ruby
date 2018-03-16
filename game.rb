require "./classes/gamefield.rb"
require "./classes/player.rb"

class Game
	def initialize()
		init_game()
		@finished = false;
		@fields_taken = 0
	end

	def make_move(y, x)
		if(@grid[y][x].status == "_")
			@grid[y][x].change_status(@cur_player);
			@fields_taken += 1;
			@moved = true
		else
			puts "This field is already taken"
		end 
	end

	def start
		init_game()
		while(true) # main loop
			@moved = false
			display();
	
			coords = @cur_player.get_coords(@grid)
			make_move(coords[0], coords[1])	
			if(won?) #someone won
				@cur_player.win();
				display();
				return
			elsif( @fields_taken >= @grid.length**2) #draw
				puts "Draw!"
				display();
				return
			end
			if(@moved)
				get_next_player();
			end
		end
	end


	private ##private methods


	def init_game()
		reset();
		create_fields();
		create_standard_players();
	end

	def create_standard_players()
		@players.push(player1 = Player.new("Player 1", "X"));
		@players.push(player2 = Player.new("Player 2", "O"));
		@cur_player_index = 0;
		@cur_player = @players[@cur_player_index];
	end

	def create_fields()
		counter = 0
		3.times do
		temp_array = []
			3.times do
			@fields.push(Gamefield.new);
			temp_array.push(@fields[counter]);
			counter += 1;
			end
			@grid.push(temp_array)
		end
	end

	def reset()
		@players = [];
		@fields = [];
		@grid = [];
	end

	def get_next_player
		@cur_player_index = @players[@cur_player_index + 1].nil? ? 0 : @cur_player_index + 1
		@cur_player = @players[@cur_player_index];
		@players[@cur_player_index]
	end

	def display
		print "\n"
		@grid.length.times do |i|
			@grid.length.times do |j|
				print @grid[i][j].status.ljust(2)
			end
			print "\n"
		end
		print "\n"
		return
	end

	def won?()
	player = @cur_player
		@grid.length.times do |i|
			horizontal_winner = true
			vertical_winner = true
			cross_l_winner = true
			cross_r_winner = true
			reverse_column = @grid.length - 1 #for cross_r
			@grid.length.times do |j| 
				if (@grid[i][j].status != player.symbol) #hor
					horizontal_winner = false
				end
				if (@grid[j][i].status != player.symbol) #ver
					vertical_winner = false
				end
				if (@grid[j][j].status != player.symbol) #cross from upper left
					cross_l_winner = false
				end
				if(@grid[j][reverse_column].status != player.symbol) #cross from upper right
					cross_r_winner = false;
				end
				reverse_column -= 1
			end
			if(horizontal_winner || vertical_winner || cross_l_winner || cross_r_winner) #winner
				return true
			end
		end
		return false
	end
end

game = Game.new()

game.start()