require 'date'

class DomainEvent
  attr_reader :recorded_at

  def initialize
    @recorded_at = DateTime.now
  end

  def process(current_state)
  end

  def reverse
  end

  def copy
  end
end
