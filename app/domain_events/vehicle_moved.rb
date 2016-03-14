class VehicleMoved < DomainEvent
  attr_reader :from_cell_as_string
  attr_reader :to_cell_as_string
  attr_reader :errors

  def initialize(from_cell_as_string, to_cell_as_string, is_undo = false)
    super(is_undo)

    @from_cell_as_string = from_cell_as_string
    @to_cell_as_string = to_cell_as_string
    @from_cell = Cell.from_string(from_cell_as_string)
    @to_cell = Cell.from_string(to_cell_as_string)
  end

  def process(game)
    vehicle = game.vehicle_on_cell(@from_cell)
    validate(game, vehicle)

    if valid?
      vehicle.from_cell = @to_cell
    end

    game
  end

  def reverse
    VehicleMoved.new(self.to_cell_as_string, self.from_cell_as_string, !self.is_undo?)
  end

  def valid?
    @errors.empty?
  end

  def direction
    return :vertical if @from_cell.row != @to_cell.row
    return :horizontal if @from_cell.col != @to_cell.col
  end

  def to_s
    "Vehicle moved from #{@from_cell_as_string} to #{@to_cell_as_string}."
  end

  private

  def validate(game, vehicle)
    @errors = []

    if vehicle
      @errors << 'Vehicle should move horizontal!' if vehicle.orientation == :horizontal && direction == :vertical
      @errors << 'Vehicle should move vertical!' if vehicle.orientation == :vertical && direction == :horizontal
      @errors << 'Vehicle should stay on the board!' if vehicle.orientation == :horizontal && (@to_cell.col + vehicle.nr_of_cells) > 6
      @errors << 'Vehicle should stay on the board' if vehicle.orientation == :vertical && (@to_cell.row + vehicle.nr_of_cells) > 6

      vehicle.cells.each do |cell|
        destination_row = cell.row + (@to_cell.row - @from_cell.row)
        destination_col = cell.col + (@to_cell.col - @from_cell.col)

        unless destination_row > 5 || destination_col > 5
          destination_cell = Cell.from_row_and_col(destination_row, destination_col)
          vehicle_on_destination_cell = game.vehicle_on_cell(destination_cell)

          if vehicle_on_destination_cell && vehicle_on_destination_cell != vehicle
            @errors << "#{vehicle_on_destination_cell.color.capitalize} #{vehicle_on_destination_cell.class.name} blocks the road!"
          end
        end
      end
    else
      @errors << 'There is no vehicle on this cell!' unless vehicle
    end
  end
end
