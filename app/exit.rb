class Exit
  attr_reader :cell
  attr_reader :orientation

  def initialize(cell, orientation)
    @cell = cell
    @orientation = orientation
  end

  def horizontal?
    @orientation == :horizontal
  end

  def vertical?
    @orientation == :vertical
  end
end
