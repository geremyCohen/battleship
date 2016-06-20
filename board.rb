class Board < Hash

  MASQUERADE_SHIPS = false
  MAX_BOARD_LENGTH = 5
  MAX_BOARD_WIDTH = 5

  # TODO: Fix the legend, before and after of "MISS" is broken

  LEGEND = {"." => "Unknown", "I" => "Ship", "o" => "Miss", "+" => "Hit", "X" => "Entire Ship Sunk"}

  # on first turn, . is a unknown
  # on second turn, o is a miss

  attr_accessor :grave_yard
  attr_accessor :target_coordinates
  attr_accessor :my_name
  attr_accessor :opponents_name

  # TODO: Factor out a Player from the Board

  def initialize(player_map)

    # Layout Hash representation of grid, y's at a time

    MAX_BOARD_WIDTH.times do |x|
      MAX_BOARD_LENGTH.times do |y|

        # player_map[x] - represents the starting offset on the y-axis to lay down a 3 unit ship
        # y = column pointer for laying down ship

        # if we're not in an empty column, and our y is within the interval to lay down a ship, then lay down a ship unit
        if player_map[x] > -1 && (player_map[x] .. player_map[x] + 2).cover?(y)
          self[[x,y]] = 'I'
        else
          self[[x,y]] = '.'
        end
      end
    end

    @grave_yard = {}
    @grave_yard["total"] = 0
    @my_name = self.object_id # Name is by default the object_id -- can be overwritten as needed for human names

  end

  def render

    puts "\nCurrent Game Board\n\n"
    pp LEGEND.to_a

    puts "\n\n   0  1  2  3  4"

    MAX_BOARD_WIDTH.times do |x|
      row = x.to_s

      MAX_BOARD_LENGTH.times do |y|
        row << "  " << (MASQUERADE_SHIPS ? (self[[y,x]]).gsub("I", ".") : self[[y,x]])
      end

      puts row

    end
  end

  def attack

    inital_value = self[@target_coordinates]

    case self[@target_coordinates]
      when '.'
        self[@target_coordinates] = 'o'
        print "(#{@target_coordinates}): #{LEGEND[self[@target_coordinates]]}!"

      when 'o'
        print "(#{@target_coordinates}): #{LEGEND[self[@target_coordinates]]}!"

      when '+'
        print "(#{@target_coordinates}): #{LEGEND[self[@target_coordinates]]}!"

      when 'X'
        print "(#{@target_coordinates}): #{LEGEND[self[@target_coordinates]]}!"

      when 'I'
        self[@target_coordinates] = '+'
        print "Attacking (#{@target_coordinates}): #{LEGEND[self[@target_coordinates]]}!"


        # figure out if we sunk the whole ship yet
        # if so, mark the whole ship sunk with 'X' char

        # Add the y element of the dead ship to the hash keyed by the x coordinate
        x = @target_coordinates[0]
        y = @target_coordinates[1]

        @grave_yard[x] = [] if @grave_yard[x].nil?
        @grave_yard[x].push(y)

        # TODO: Factor out the logic here, too fat

        # If there are 3 hits in this x, that means the whole ship is hit
        if @grave_yard[x].length == 3

          # Mark the whole ship as destroyed
          puts " Ship Destroyed!"
          @grave_yard[x].each do |i|
            self[[x,i]] = "X"
          end

          # Add the tally to the grave
          @grave_yard["total"] += 1
          puts "Incrementing grave total. Total sunk ships: #{@grave_yard["total"]}"

          # If the grave count is 3, end the game as a victory!
          if @grave_yard["total"] == 3
            puts "\n\n\n*** Player #{self.opponents_name} is the winner! ***"
            puts "All Ships Sunk, Game Over Man!\n\n\n"
            exit
          end
        end
    end

    print " -- (But Already Taken!)" if inital_value == self[@target_coordinates]

  end

  def target
    print "\nEnter a coordinate pair to attack in the format: x,y "
    @target_coordinates = gets.split(",").map! {|x| x.to_i}
  end


end