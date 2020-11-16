# frozen_string_literal: true

class LogProcess
  def initialize(tracker)
    @tracker = tracker
  end

  def call(logs)
    groups = group_by_pages(logs)

    sort_by_visits(groups).map do |page, visits|
      page + @tracker.call(visits)
    end.unshift(header)
  end

  private

  def group_by_pages(logs)
    logs.group_by { |entry| entry.split.first }
  end

  def sort_by_visits(logs)
    logs.sort_by { |_, visits| visits.length }.reverse
  end

  def header
    "### #{@tracker.type.upcase} ###"
  end
end
