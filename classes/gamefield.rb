class Gamefield
	$game_field_counter = 0;
	attr_reader :position_x, :position_y, :status
	def initialize()
		@position_x = $game_field_counter%3;
		@position_y = $game_field_counter/3;
		$game_field_counter += 1;
		@status = "_"
	end

	def change_status(player)
		@status = player.symbol
	end

end