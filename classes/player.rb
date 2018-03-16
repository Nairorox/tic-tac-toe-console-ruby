class Player
	$playercount = 0;
	attr_accessor :symbol

	def initialize(player_name, symbol)
		@name = player_name;
		@symbol = symbol
		$playercount += 1
	end

	def get_coords(grid)
		puts "Current player: #{@symbol}"
		puts "Please enter which row (1-#{grid.length})"
		while (row = gets.to_i)
			if(row > 0 && row <= grid.length) #succesful row
				puts "Please enter which column (1-#{grid.length})"
				while (column = gets.to_i)
					if(column > 0 && column <= grid.length ) #succesful column, main
						return [row - 1, column - 1]
					else #unsuccesful column
						puts "Please enter correct column"
					end
				end	
			else #unsucessful row
				puts "Please enter correct row"
			end
		end
	end

	def win
		puts "~~~~~~~ #{self.symbol} won ~~~~~~~"
	end

end