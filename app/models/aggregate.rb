require 'securerandom'

class Aggregate
  def initialize
    @events = []
    @undo_stack = []
    @redo_stack = []
  end

  def events
    @events.sort_by(&:recorded_at)
  end

  def handle_event(event)
    if event
      append(event)

      @undo_stack << event
    end

    event
  end

  def handle_undo
    return if @undo_stack.empty?

    event = @undo_stack.pop

    @redo_stack << event

    append(event.reverse)
  end

  def handle_redo
    return if @redo_stack.empty?

    event = @redo_stack.pop

    @undo_stack << event

    append(event.copy)
  end

  def current_state
    current_state = nil

    events.each do |event|
      current_state = event.process(current_state)
    end

    current_state
  end

  def audit
    events.map(&:to_s)
  end

  private

  def append(event)
    if event
      @events << event
    end

    event
  end
end
