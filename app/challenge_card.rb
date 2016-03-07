class ChallengeCard
  class Row
    attr_reader :row_nr

    def initialize(row_nr)
      @row_nr = row_nr
    end

    def cells
      @cells ||= [Cell.new(@row_nr, 0), Cell.new(@row_nr, 1), Cell.new(@row_nr, 2), Cell.new(@row_nr, 3), Cell.new(@row_nr, 4), Cell.new(@row_nr, 5)]
    end
  end

  class << self
    def rows
      @rows ||= [Row.new(0), Row.new(1), Row.new(2), Row.new(3), Row.new(4), Row.new(5)]
    end
  end

  attr_reader :exit
  attr_reader :vehicles

  def initialize
    @vehicles = []
  end

  def do_move(from_cell_as_string, to_cell_as_string)
    from_cell = Cell.from_string(from_cell_as_string)
    to_cell = Cell.from_string(to_cell_as_string)
    vehicle = vehicle_on_cell(from_cell)

    move = Move.new(self, vehicle, from_cell, to_cell)
    move.execute
    move
  end

  def vehicle_on_cell(cell)
    @vehicles.each do |vehicle|
      return vehicle if vehicle.cells.include?(cell)
    end

    nil
  end
end
