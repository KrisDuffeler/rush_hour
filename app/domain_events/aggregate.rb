require 'securerandom'

class Aggregate
  attr_reader :id

  def initialize
    @id = SecureRandom.base64
    @events = []
    @undo_stack = []
  end

  def self.find_by_id(id)
  end

  def events
    @events.sort_by(&:recorded_at)
  end

  def append(event)
    @events << event if event

    event
  end

  def current_state
    current_state = nil

    events.each do |event|
      current_state = event.process(current_state)
    end

    current_state
  end

  def handle_undo
    event = events.last

    @undo_stack << event

    append(event.reverse)
  end

  def handle_redo
    event = @undo_stack.shift

    append(event.copy) if event
  end

  def audit
    events.map(&:to_s)
  end
end
