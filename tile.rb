require "colorize"
class Tile
    # represents each position on the sudoku board
    attr_reader :value
    
    def initialize(value)
        @value = value
        @given = value == 0 ? false : true
    end

    def color
        given? ? :blue : :red
    end

    def to_s
        value == 0 ? " " : value.to_s.colorize(color)
    end

    def given?
        @given
    end

    def value=(new_value)
        if given?
            puts "you can't change a given starting tile"
        else
            @value = new_value
        end
    end
end