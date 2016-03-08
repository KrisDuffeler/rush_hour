class ChallengeCard
  attr_reader :vehicles
  attr_reader :exit

  def initialize
    @vehicles = []
  end

  def self.rows
    @rows ||= [Row.new(0), Row.new(1), Row.new(2), Row.new(3), Row.new(4), Row.new(5)]
  end

  def red_car
    @red_car ||= @vehicles.find{|vehicle| vehicle.is_a?(Car) && vehicle.color == :red}
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
