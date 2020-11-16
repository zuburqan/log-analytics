# frozen_string_literal: true

class Sanitiser
  def call(file)
    raise Errors::FileNotFound if file.nil?

    filter_invalid file
  end

  private

  def filter_invalid(file)
    File.open(file, 'r').map.with_index do |line, index|
      if line.split(' ').count != 2
        puts "Invalid log at line #{index + 1}, ignoring..."
        next
      end
      line.squeeze(' ')
    end.compact
  end
end
