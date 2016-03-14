require 'date'

class DomainEvent
  attr_reader :recorded_at

  def initialize(is_undo)
    @is_undo = is_undo
    @recorded_at = DateTime.now
  end

  def is_undo?
    @is_undo
  end

  def process(current_state)
  end

  def reverse
  end
end
