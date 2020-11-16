# frozen_string_literal: true

module Errors
  class FileNotFound < StandardError
    def initialize(msg = 'No log file to analyse!')
      super
    end
  end
end
