require 'securerandom'

class Aggregate
  attr_reader :id

  def initialize
    @id = SecureRandom.base64
    @events = []
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
    event = events.reverse.find{|e| !e.is_undo? }

    append(event.reverse)
  end

  def handle_redo
    event = events.find{|e| e.is_undo? }

    append(event.reverse)
  end

  def audit
    events.map(&:to_s)
  end
end
