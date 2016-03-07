class Vehicle
  attr_accessor :from_cell
  attr_reader :color
  attr_reader :orientation
  attr_reader :nr_of_cells

  def initialize(color, orientation, from_cell, nr_of_cells)
    @color = color
    @orientation = orientation
    @from_cell = from_cell
    @nr_of_cells = nr_of_cells
  end

  def cells
    cells = [@from_cell]

    case @orientation
      when :horizontal
        1.upto(@nr_of_cells - 1) {|i| cells << ChallengeCard.rows[@from_cell.row].cells[@from_cell.col + i]}
      when :vertical
        1.upto(@nr_of_cells - 1) {|i| cells << ChallengeCard.rows[@from_cell.row + i].cells[@from_cell.col]}
    end

    cells
  end
end
