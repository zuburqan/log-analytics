# frozen_string_literal: true

class Track
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def call(visits)
    " #{visits.length} #{@type}#{plularise(visits.length)}"
  end

  private

  def plularise(num_of_entries)
    's' if num_of_entries > 1
  end
end
