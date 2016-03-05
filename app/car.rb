require_relative 'vehicle.rb'

class Car < Vehicle
  def initialize(color, orientation, from_cell)
    super(color, orientation, from_cell, 2)
  end
end
