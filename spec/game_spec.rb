require 'spec_helper'

describe Game do

  describe ".initialize" do

    before do
      @game = Game.new
      @p1_map = [-1, 1, 2, 1, -1]
      @p2_map = [0, -1, 1, -1, 2]

    end


    it "should be an instance of type Game" do
      expect(@game).to be_a Game
    end

    it "should instantiate with default maps" do
      expect(@game.p1_map).to eql(@p1_map)
      expect(@game.p2_map).to eql(@p2_map)
    end

    it "should instantiate with default maps" do
      expect(@game.p1_map).to eql(@p1_map)
      expect(@game.p2_map).to eql(@p2_map)
    end

    # TODO: Player should be factored out because having this
    # tested via the Game class for board player's name seems smelly

    it "should assign default names" do
      expect(@game.p1_board.opponents_name).to eql(@game.p2_board.my_name)
      expect(@game.p2_board.opponents_name).to eql(@game.p1_board.my_name)
    end


  end

end