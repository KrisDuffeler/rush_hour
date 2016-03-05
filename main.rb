require 'colorize'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/*.rb'].each {|file| require file }

#Event Sourcing
#=============
#1. Show audit
#2. Acties kan undone worden (door tegen actie te doen)
#3. ChallengeCardFactory met alle mogelijke opgaves
#4. API:
#       a: alle mogelijke opgaves
#       b: move
#5. HTML representatie
#7. validate cell: cell op bord, cell is eerste van een vehicle?
#10. Kan Board.cells niet als instance variabele?
#11. English output
#MoveService
#MoveEvent < DomainEvent
#Board.HandleMove: Move::save --> Marshal.dump, Marshal.load

input = Input.new('', false)
challenge_card = nil

while !input.exit?
  if input.valid?
    if challenge_card
      if input.audit?
         puts 'Audit'
      elsif input.undo?
        puts 'Undo'
      elsif input.move?
        puts "\n\n"
        move = challenge_card.do_move(input.cells_as_string[0], input.cells_as_string[1])

        if move.valid?
          puts '----------- OK ------------'.bold.colorize(:green)
        else
          puts move.errors.map{|e| e.bold.colorize(:red)}
        end

        ChallengeCardView.new(challenge_card).render
      end
    elsif input.challenge_card_selection?
      challenge_card = ChallengeCards.all[input.input_string].new
      ChallengeCardView.new(challenge_card).render
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
