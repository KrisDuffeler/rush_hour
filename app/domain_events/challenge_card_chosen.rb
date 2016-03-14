require_relative 'domain_event.rb'

class ChallengeCardChosen < DomainEvent
  attr_reader :challenge_card_nr

  def initialize(challenge_card_nr)
    super(false)

    @challenge_card_nr = challenge_card_nr
  end

  def process(game)
    ChallengeCards.all[@challenge_card_nr].new
  end

  def to_s
    "Challenge card #{@challenge_card_nr} chosen."
  end
end
