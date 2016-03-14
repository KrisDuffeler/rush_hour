class Row
  attr_reader :row_nr

  def initialize(row_nr)
    @row_nr = row_nr
  end

  def cells
    @cells ||= [Cell.new(@row_nr, 0), Cell.new(@row_nr, 1), Cell.new(@row_nr, 2), Cell.new(@row_nr, 3), Cell.new(@row_nr, 4), Cell.new(@row_nr, 5)]
  end
end
