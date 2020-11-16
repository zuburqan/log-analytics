# frozen_string_literal: true

class Orchestrate
  def call(file)
    valid_logs = Sanitiser.new.call(file)
    visit_tracker.call(valid_logs) + unique_view_tracker.call(valid_logs.uniq)
  end

  private

  def visit_tracker
    LogProcess.new(Track.new('visit'))
  end

  def unique_view_tracker
    LogProcess.new(Track.new('unique view'))
  end
end
