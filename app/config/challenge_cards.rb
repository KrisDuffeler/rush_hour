class ChallengeCards
  def self.all
    @@all ||= {
      ChallengeCardOne.nr => ChallengeCardOne,
      ChallengeCardTwo.nr  => ChallengeCardTwo
    }
  end

  class ChallengeCardOne < ChallengeCard
    def initialize
      super

      @exit = Exit.new(ChallengeCard.rows[2].cells[5], :horizontal)
      @vehicles << Truck.new(:magenta, :vertical, ChallengeCard.rows[0].cells[0])
      @vehicles << Truck.new(:light_yellow, :vertical, ChallengeCard.rows[3].cells[5])
      @vehicles << Truck.new(:light_green, :horizontal, ChallengeCard.rows[5].cells[2])
      @vehicles << Truck.new(:blue, :vertical, ChallengeCard.rows[1].cells[3])
      @vehicles << Car.new(:green, :horizontal, ChallengeCard.rows[0].cells[1])
      @vehicles << Car.new(:red, :horizontal, ChallengeCard.rows[2].cells[1])
      @vehicles << Car.new(:yellow, :vertical, ChallengeCard.rows[3].cells[0])
      @vehicles << Car.new(:cyan, :horizontal, ChallengeCard.rows[4].cells[1])
    end

    def self.nr
      '1'
    end
  end

  class ChallengeCardTwo < ChallengeCard
    def initialize
      super

      @exit = Exit.new(ChallengeCard.rows[2].cells[5], :horizontal)
      @vehicles << Truck.new(:magenta, :vertical, ChallengeCard.rows[0].cells[0])
      @vehicles << Truck.new(:light_yellow, :vertical, ChallengeCard.rows[3].cells[5])
      @vehicles << Truck.new(:light_green, :horizontal, ChallengeCard.rows[5].cells[2])
      @vehicles << Truck.new(:blue, :vertical, ChallengeCard.rows[1].cells[3])
      @vehicles << Car.new(:green, :horizontal, ChallengeCard.rows[0].cells[1])
      @vehicles << Car.new(:red, :horizontal, ChallengeCard.rows[2].cells[1])
      @vehicles << Car.new(:yellow, :vertical, ChallengeCard.rows[3].cells[0])
      @vehicles << Car.new(:cyan, :horizontal, ChallengeCard.rows[4].cells[1])
    end

    def self.nr
      '2'
    end
  end
end
