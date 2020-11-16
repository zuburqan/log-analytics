# frozen_string_literal: true

require 'log_process'

describe LogProcess do
  describe '#call' do
    let(:tracker) { double(:tracker) }

    context 'analysing visits' do
      subject { described_class.new(tracker) }

      context 'when log list is empty' do
        before do
          allow(tracker).to receive(:type) { 'visit' }
        end

        it 'returns empty list' do
          expect(subject.call([])).to eq ['### VISIT ###']
        end
      end

      context 'when there is only one log' do
        before do
          allow(tracker).to receive(:call).with(['foo 1.2.3.4']) { ' 1 visit' }
          allow(tracker).to receive(:type) { 'visit' }
        end

        it 'returns the same log entry' do
          expect(subject.call(['foo 1.2.3.4'])).to eq ['### VISIT ###', 'foo 1 visit']
        end
      end

      context 'when there are multiple logs' do
        before do
          allow(tracker).to receive(:call).with(['foo 1.2.3.4', 'foo 4.5.6.7']) { ' 2 visits' }
          allow(tracker).to receive(:call).with(['bar 2.3.4.5']) { ' 1 visit' }
          allow(tracker).to receive(:type) { 'visit' }
        end

        it 'returns a list of logs from most viewed to least viewed' do
          list = ['bar 2.3.4.5', 'foo 1.2.3.4', 'foo 4.5.6.7']
          expect(subject.call(list)).to eq ['### VISIT ###', 'foo 2 visits', 'bar 1 visit']
        end
      end
    end

    context 'analysing unique views' do
      let(:list) do
        ['foo 1.2.3.4', 'foo 1.2.3.4',
         'bar 1.2.3.4', 'bar 5.6.7.8']
      end
      let(:expected) { ['### UNIQUE VIEW ###', 'bar 2 unique views', 'foo 1 unique view'] }

      subject { described_class.new(tracker) }

      before do
        allow(tracker).to receive(:type) { 'unique view' }
        allow(tracker).to receive(:call).with(['foo 1.2.3.4']) { ' 1 unique view' }
        allow(tracker).to receive(:call).with(['bar 1.2.3.4', 'bar 5.6.7.8']) { ' 2 unique views' }
      end

      it 'returns the page visits by unique views' do
        expect(subject.call(list.uniq)).to eq expected
      end
    end
  end
end
