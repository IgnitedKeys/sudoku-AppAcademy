class Sudoku 
    require_relative "./board.rb"
    require_relative "./tile.rb"
    
    def self.from_file(filename='/puzzles/sudoku_1.txt')
        board = Board.from_file(filename)
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    def play
        until solved?
            board.render
            # prompt => get a pos and value
            pos = get_pos
            val = get_val
            board[pos] = val
        end
        board.render
        puts "SOLVED"
    end

    def solved?
        board.solved?
    end

    def get_pos
        pos = nil
        until pos && valid?(pos)
            puts "Enter a postion as num1, num2"
            pos = parse_pos(gets.chomp)
        end
        pos
    end

    def parse_pos(string)
        string.split(",").map {|i| Integer(i)}
    end

    def get_val(pos)
        val = nil
        until val && valid_val?(val)
            puts "Enter a value from 1-9 for #{pos} (0 will clear the spot)"
            val = parse_val(gets.chomp)
        end
        val
    end

    def parse_val(value)
        Integer(value)
    end

    def valid?(pos)
        pos.length == 2 &&
        pos.all? {|p| p.between?(0, board.size - 1)}
    end

    def valid_val?(value)
        value.between?(0,9)
    end

    private
    attr_reader :board

end

if $PROGRAM_NAME == __FILE__
    Sudoku.new(Board.new)
end