# frozen_string_literal: true

require 'track'
require 'sanitiser'
require 'orchestrate'
require 'log_process'

describe 'analysing logs' do
  let(:expected) do
    <<~LOG
      ### VISIT ###
      /about/2 90 visits
      /contact 89 visits
      /index 82 visits
      /about 81 visits
      /help_page/1 80 visits
      /home 78 visits
      ### UNIQUE VIEW ###
      /index 23 unique views
      /home 23 unique views
      /contact 23 unique views
      /help_page/1 23 unique views
      /about/2 22 unique views
      /about 21 unique views
    LOG
  end

  let(:file) { './webserver.log' }

  it 'analyses the log file and returns results' do
    logs = Sanitiser.new.call(File.read(file))
    result = Orchestrate.new.call(logs)
    expect(result.join("\n")).to eq expected.chomp
  end
end
