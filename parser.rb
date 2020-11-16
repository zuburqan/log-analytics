# frozen_string_literal: true

require './lib/sanitiser'
require './lib/orchestrate'
require './lib/log_process'
require './lib/track'
require './lib/errors/file_not_found'

puts Orchestrate.new.call(ARGV[0])
