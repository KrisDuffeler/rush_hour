require 'colorize'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/domain_events/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/*.rb'].each {|file| require file }

#TODO
#====
#1. RushHourService
#   a. return all challenge cards
#   b: start game
#   c: ...

input = Input.new('', false)
challenge_card = nil

while !input.exit?
  if input.valid?
    if challenge_card
      if input.audit?
         puts challenge_card.audit
      elsif input.undo?
        challenge_card.handle_undo

        ChallengeCardView.new(challenge_card.current_state).render
      elsif input.redo?
        challenge_card.handle_redo

        ChallengeCardView.new(challenge_card.current_state).render
      elsif input.move?
        move = challenge_card.handle_move(input.cells_as_string[0], input.cells_as_string[1])

        ChallengeCardView.new(challenge_card.current_state, move).render
      end
    elsif input.challenge_card_selection?
      challenge_card = ChallengeCard.new
      challenge_card.handle_challenge_card_chosen(input.input_string)

      ChallengeCardView.new(challenge_card.current_state).render
    else
      ChallengeCards.all.each {|nr, challenge_card_class|
        ChallengeCardView.new(challenge_card_class.new).render
      }

      puts 'Choose challenge card (1 - 2):'
    end
  else
    puts input.errors.map{|e| e.bold.colorize(:red)}
  end

  input = Input.new(STDIN.gets.strip, challenge_card != nil)
end
