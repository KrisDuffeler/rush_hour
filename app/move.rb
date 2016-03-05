class Move
  attr_reader :errors

  def initialize(challenge_card, vehicle, from_cell, to_cell)
    @challenge_card = challenge_card
    @vehicle = vehicle
    @from_cell = from_cell
    @to_cell = to_cell

    validate
  end

  def execute
    @vehicle.from_cell = @to_cell if valid?
  end

  def valid?
    @errors.empty?
  end

  private

  def validate
    @errors = []

    if @vehicle
      @errors << 'Wagen mag enkel horizontaal bewegen!' if @vehicle.orientation == :horizontal && @from_cell.row != @to_cell.row
      @errors << 'Wagen mag enkel verticaal bewegen!' if @vehicle.orientation == :vertical && @from_cell.col != @to_cell.col

      @vehicle.cells.each do |cell|
        destination_row = cell.row + (@to_cell.row - @from_cell.row)
        destination_col = cell.col + (@to_cell.col - @from_cell.col)

        destination_cell = Cell.from_row_and_col(destination_row, destination_col)
        vehicle_on_destination_cell = @challenge_card.vehicle_on_cell(destination_cell)

        if vehicle_on_destination_cell && vehicle_on_destination_cell != @vehicle
          @errors << "#{vehicle_on_destination_cell.color.capitalize} #{vehicle_on_destination_cell.class.name} staat in de weg!"
        end
      end
    else
      @errors << 'Er staat geen wagen op de deze cell!' unless @vehicle
    end
  end
end
