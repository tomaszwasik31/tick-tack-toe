class Game
  def initialize
    @round = 0
    @mark = 'X'
    @array_grid = Array(1..9)
    @mark_index = 1
    @game_draw = false
    @game_won = false
  end

  def message_round
    puts "This is round #{@round} Please choose number to insert #{@mark}"
  end

  def print_3x3
    @array_grid.each_slice(3) { |trio| puts '           %s|%s|%s' % trio }
  end

  def input_get
    @mark_index = gets.chomp.to_i
  end

  def input_validation
    if @mark_index.positive? && @mark_index < 10
    else

      print "\nInvalid input. Select number from 1-9.\n"
      @round -= 1
      change_mark
    end
  end

  def put_mark
    @array_grid.map! { |e| e == @mark_index ? @mark : e }
  end

  def change_mark
    if @mark == 'X'
      @mark = '0'
      return
    end
    @mark = 'X'
  end

  def draw?
    if @round > 9
      puts "\nGame draw, play again or press ctr+z to close a game.... Or play again \n"
      @game_draw = true
      print_3x3
    end
  end

  def won?
    if [@array_grid[0], @array_grid[1], @array_grid[2]].uniq.size == 1 ||
       [@array_grid[3], @array_grid[4], @array_grid[5]].uniq.size == 1 ||
       [@array_grid[6], @array_grid[7], @array_grid[8]].uniq.size == 1 ||
       [@array_grid[0], @array_grid[3], @array_grid[6]].uniq.size == 1 ||
       [@array_grid[1], @array_grid[4], @array_grid[7]].uniq.size == 1 ||
       [@array_grid[2], @array_grid[5], @array_grid[8]].uniq.size == 1 ||
       [@array_grid[0], @array_grid[4], @array_grid[8]].uniq.size == 1 ||
       [@array_grid[2], @array_grid[4], @array_grid[6]].uniq.size == 1

      message_won
    end
  end

  def message_won
    change_mark
    puts "\n#{@mark} Won a game. Another game started!\n Press ctr+z to close a game \n "
    @game_won = true
    print_3x3
  end

  def play_game
    until @game_draw || @game_won
      message_round
      print_3x3
      input_get
      input_validation
      put_mark
      change_mark
      @round += 1
      draw?
      won?
    end
  end
end

loop do
  obj = Game.new
  obj.play_game
end