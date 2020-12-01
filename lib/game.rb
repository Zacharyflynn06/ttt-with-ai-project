require 'pry'

class Game

    attr_accessor :board, :player_1, :player_2, :winner, :user_input

    WIN_COMBINATIONS = [
        [6,7,8],
        [3,4,5],
        [0,1,2],
        [0,4,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [2,4,6],
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        board.turn_count.odd? ? player_2 : player_1
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            if @board.cells[combo[0]] == @board.cells[combo[1]] &&
              @board.cells[combo[1]] == @board.cells[combo[2]] &&
              @board.taken?(combo[0]+1)
              return combo
            end
          end
        return false
    end

    def draw?
        if @board.full? && !won?
            true
        else 
            false
        end
    end

    def over?
        if won? || draw? 
            true
        else 
            false
        end
    end

    def winner
        if won?
            winning_combo = won?
            @board.cells[winning_combo[0]]
        end
    end

    def turn
        puts "Please enter a number 1-9:"
        @user_input = current_player.move(@board)
        if @board.valid_move?(@user_input)
          @board.update(@user_input, current_player)
        else puts "Please enter a number 1-9:"
          turn
        end
    end

    def play
        turn until over?
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
    end
end