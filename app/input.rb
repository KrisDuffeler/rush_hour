class Input
  attr_reader :input_string
  attr_reader :errors

  def initialize(input_string, ongoing_game)
    @input_string = input_string
    @ongoing_game = ongoing_game

    validate
  end

  def valid?
    @errors.empty?
  end

  def move?
    /[A-F][0-5]\s[A-F][0-5]/ =~ @input_string
  end

  def challenge_card_selection?
    ChallengeCards.all.keys.include?(@input_string)
  end

  def audit?
    @input_string == 'A'
  end

  def undo?
    @input_string == 'U'
  end

  def redo?
    @input_string == 'R'
  end

  def exit?
    @input_string == 'E'
  end

  def empty?
    @input_string == ''
  end

  def cells_as_string
    @cells_as_string ||= @input_string.split(' ')
  end

  private

  def validate
    @errors = []

    if !move? && !challenge_card_selection? && !audit? && !undo? && !redo? && !exit? && !empty?
      @errors << 'Invalid command given!'
    else
      if !@ongoing_game && !challenge_card_selection? && !empty?
        @errors << 'Choose a challenge card first!'
      end

      if @ongoing_game && challenge_card_selection?
        @errors << 'You should finish the current game before you start a new one!'
      end
    end
  end
end
