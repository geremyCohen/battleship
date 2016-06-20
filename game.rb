class Game

  attr_accessor :p1_map, :p2_map
  attr_accessor :p1_board, :p2_board

  def initialize

    @p1_map = [-1, 1, 2, 1, -1]
    @p2_map = [0, -1, 1, -1, 2]

    @p1_board = Board.new(@p1_map)
    @p2_board = Board.new(@p2_map)

    @p1_board.opponents_name = @p2_board.my_name
    @p2_board.opponents_name = @p1_board.my_name

  end

  def play

    while true

      [@p1_board, @p2_board].each do |p|
        puts "\n\n\n*********************************************************"
        puts "***************** Player #{p.opponents_name}'s turn! ***************"
        puts "*********************************************************"

        p.render
        p.target
        p.attack
      end
    end
  end

end