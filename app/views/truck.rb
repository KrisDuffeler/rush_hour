require_relative 'vehicle.rb'

class Truck < Vehicle
  def initialize(color, orientation, from_cell)
    super(color, orientation, from_cell, 3)
  end
end
