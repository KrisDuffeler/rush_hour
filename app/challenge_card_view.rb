class ChallengeCardView
  def initialize(challenge_card)
    @challenge_card = challenge_card
  end

  def render
    puts "-------------#{@challenge_card.class.nr}-------------"
    puts '    A   B   C   D   E   F'

    ChallengeCard.rows.each do |row|
      render_row(row)
    end

    puts "End: 'E' - Audit: 'A' - Undo: 'U' - Move: 'A1 B1':"
  end

  private

  def render_row(row)
    rendered_row = "#{row.row_nr} "
    row_divider = '  '

    last_cell = nil
    row.cells.each do |cell|
      rendered_row += render_cell(cell)

      if cell == @challenge_card.exit
        row_divider += '    '
      else
        row_divider += '----'
      end

      last_cell = cell
    end

    unless last_cell == @challenge_card.exit
     rendered_row += '|'
    end

    puts row_divider
    puts rendered_row
    puts row_divider if row.row_nr == 5
  end

  def render_cell(cell)
    vehicle_on_cell = @challenge_card.vehicle_on_cell(cell)

    if vehicle_on_cell
      if cell == @challenge_card.exit
        '  ' + 'O'.bold.colorize(vehicle_on_cell.color) + ' '
      else
        '| ' + 'O'.bold.colorize(vehicle_on_cell.color) + ' '
      end
    else
      if cell == @challenge_card.exit
        '    '
      else
        '|   '
      end
    end
  end
end
