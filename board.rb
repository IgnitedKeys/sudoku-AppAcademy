class Board
    require_relative './tile.rb'
    # stores a grid of tiles
    def self.empty_grid
        Array.new(9) do
            Array.new(9) {Tile.new(0)}
        end
    end
    
    def self.from_file(filename='/puzzles/sudoku_1.txt')
        rows = File.readlines(filename).map(&:chomp)
        tiles = rows.map do |row|
            nums = row.split("").map {|char| Integer(char)}
            nums.map {|num| Tile.new(num)}
        end
        self.new(tiles)
    end

    def initialize(grid=Board.empty_grid)
        @grid = grid
    end

    def [](position)
        row, col = position
        grid[row][col]
    end

    def []=(position,value)
        row, col = position
        tile = grid[row][col]
        tile.value = value
    end

    def render
        puts "#{(0..8).to_a.join(' ')}"
        grid.each_with_index do |row, i|
            puts "#{i} #{row.join(' ')}"
        end
    end

    def solved?
        rows.all? {|row| solved_set?(row)} &&
        columns.all? {|col| solved_set?(col)} &&
        squares.all?{|square| solved_set?(square)}
    end

    def solved_set?(tiles)
        nums = tiles.map(&:value)
        nums.sort == (1..9).to_a
    end

    def rows
        @grid
    end

    def size
        grid.size
    end

    def columns
        rows.transpose
    end

    def squares
        #change to_a for [] method
        (0..8).to_a.map {|i| square(i)}
        # 00 01 02  03 04 05   06 07 08
        # 10 11 12  13 14 15   16 17 18  
        # 20 21 22  23 24 25   26 27 28

        # 30 31 32  33 34 35   36 37 38
        # 40 41 42  43 44 45   46 47 48  
        # 50 51 52  53 54 55   56 57 58

        # 60 61 62  63 64 65   66 67 68
        # 70 71 72  73 74 75   76 77 78
        # 80 81 82  83 84 85   86 87 88

    end

    def square(index)
        sq_tiles = []
        x = index#(index / 3) * 3 # ?? is this necessary??
        y = index#(index % 3) * 3

        (x...x + 3).each do |i|
            (y...y + 3).each do |j|
                sq_tiles << self[[i][j]]
            end
        end
        sq_tiles
    end

    attr_reader :grid
end