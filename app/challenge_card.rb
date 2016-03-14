class ChallengeCard < Aggregate
  attr_reader :challenge_card
  attr_reader :vehicles
  attr_reader :exit

  def initialize
    super

    @vehicles = []
  end

  def self.rows
    @rows ||= [Row.new(0), Row.new(1), Row.new(2), Row.new(3), Row.new(4), Row.new(5)]
  end

  def finished?
    red_car.cells.each do |red_car_cell|
      return true if red_car_cell == exit.cell && exit.orientation == red_car.orientation
    end

    false
  end

  def red_car
    @red_car ||= @vehicles.find{|vehicle| vehicle.is_a?(Car) && vehicle.color == :red}
  end

  def handle_challenge_card_chosen(input_string)
    append(ChallengeCardChosen.new(input_string))
  end

  def handle_move(from_cell_as_string, to_cell_as_string)
    append(VehicleMoved.new(from_cell_as_string, to_cell_as_string))
  end

  def vehicle_on_cell(cell)
    @vehicles.each do |vehicle|
      return vehicle if vehicle.cells.include?(cell)
    end

    nil
  end
end
