class ChallengeCardView
  def initialize(challenge_card, event = nil)
    @challenge_card = challenge_card
    @event = event
  end

  def render
    render_previous_output

    puts "-------------#{@challenge_card.class.nr}-------------"
    puts '    A   B   C   D   E   F'

    ChallengeCard.rows.each do |row|
      render_row(row)
    end

    puts "End: 'E' - Audit: 'A' - Undo: 'U' - Redo: 'R' - Move: 'A1 B1':"
  end

  private

  def render_previous_output
    if @challenge_card.finished?
      puts '---- CONGRATIULATIONS -----'.bold.colorize(:green)
    elsif @event
      if @event.valid?
        puts @event.to_s.bold.colorize(:green)
      else
        puts @event.errors.map{|e| e.bold.colorize(:red)}
      end
    end
  end

  def render_row(row)
    rendered_row = "#{row.row_nr} "
    row_divider = '  '

    last_cell = nil
    row.cells.each do |cell|
      rendered_row += render_cell(cell)

      if cell == @challenge_card.exit.cell && @challenge_card.exit.vertical?
        row_divider += '    '
      else
        row_divider += '----'
      end

      last_cell = cell
    end

    unless last_cell == @challenge_card.exit.cell && @challenge_card.exit.horizontal?
     rendered_row += '|'
    end

    if row.row_nr == 0
      puts row_divider
    else
      puts '  ------------------------'
    end

    puts rendered_row
    puts row_divider if row.row_nr == 5
  end

  def render_cell(cell)
    vehicle_on_cell = @challenge_card.vehicle_on_cell(cell)

    if vehicle_on_cell
      if cell.col == 0 && cell == @challenge_card.exit.cell && @challenge_card.exit.horizontal?
        '  ' + 'O'.bold.colorize(vehicle_on_cell.color) + ' '
      else
        '| ' + 'O'.bold.colorize(vehicle_on_cell.color) + ' '
      end
    else
      if cell.col == 0 && cell == @challenge_card.exit.cell && @challenge_card.exit.horizontal?
        '    '
      else
        '|   '
      end
    end
  end
end
