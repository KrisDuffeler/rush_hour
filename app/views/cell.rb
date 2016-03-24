class Cell
  attr_reader :row
  attr_reader :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def self.from_string(cell_as_string)
    row = (cell_as_string[1]).to_i
    col = cell_as_string[0].ord - 65

    ChallengeCard.rows[row].cells[col]
  end

  def self.from_row_and_col(row, col)
    ChallengeCard.rows[row].cells[col]
  end
end
