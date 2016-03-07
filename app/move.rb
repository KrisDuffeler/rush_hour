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

  def direction
    return :vertical if @from_cell.row != @to_cell.row
    return :horizontal if @from_cell.col != @to_cell.col
  end

  private

  def validate
    @errors = []

    if @vehicle
      @errors << 'Wagen mag enkel horizontaal bewegen!' if @vehicle.orientation == :horizontal && direction == :vertical
      @errors << 'Wagen mag enkel verticaal bewegen!' if @vehicle.orientation == :vertical && direction == :horizontal
      @errors << 'Wagen moet op het bord blijven!' if @vehicle.orientation == :horizontal && (@to_cell.col + @vehicle.nr_of_cells) > 6
      @errors << 'Wagen moet op het bord blijven!' if @vehicle.orientation == :vertical && (@to_cell.row + @vehicle.nr_of_cells) > 6

      @vehicle.cells.each do |cell|
        destination_row = cell.row + (@to_cell.row - @from_cell.row)
        destination_col = cell.col + (@to_cell.col - @from_cell.col)

        unless destination_row > 5 || destination_col > 5
          destination_cell = Cell.from_row_and_col(destination_row, destination_col)
          vehicle_on_destination_cell = @challenge_card.vehicle_on_cell(destination_cell)

          if vehicle_on_destination_cell && vehicle_on_destination_cell != @vehicle
            @errors << "#{vehicle_on_destination_cell.color.capitalize} #{vehicle_on_destination_cell.class.name} staat in de weg!"
          end
        end
      end
    else
      @errors << 'Er staat geen wagen op de deze cell!' unless @vehicle
    end
  end
end
