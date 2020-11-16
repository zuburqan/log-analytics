# frozen_string_literal: true

require 'orchestrate'

describe Orchestrate do
  describe '#call' do
    let(:sanitiser) { double :sanitiser }

    before do
      allow(Sanitiser).to receive(:new) { sanitiser }
    end

    context 'when log list is empty' do
      before do
        allow(sanitiser).to receive(:call).with('file') { [] }
      end

      it 'returns empty list' do
        expect(subject.call('file')).to eq ['### VISIT ###', '### UNIQUE VIEW ###']
      end
    end

    context 'when there is only one entry' do
      before do
        allow(sanitiser).to receive(:call).with('file') { ["foo 1.2.3.4\n"] }
      end

      it 'returns the same log entry' do
        expect(subject.call('file')).to eq [
          '### VISIT ###', 'foo 1 visit', '### UNIQUE VIEW ###', 'foo 1 unique view'
        ]
      end
    end

    context 'when there are multiple log lines' do
      let(:list) do
        [
          "bar 2.3.4.5\n",
          "foo 1.2.3.4\n",
          "foo 4.5.6.7\n"
        ]
      end

      before do
        allow(sanitiser).to receive(:call).with('file') { list }
      end

      it 'returns logs from most to least viewed & most to least unique views' do
        expect(subject.call('file')).to eq ['### VISIT ###',
                                            'foo 2 visits',
                                            'bar 1 visit',
                                            '### UNIQUE VIEW ###',
                                            'foo 2 unique views',
                                            'bar 1 unique view']
      end
    end
  end
end
