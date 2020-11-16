# frozen_string_literal: true

require 'sanitiser'
require 'errors/file_not_found'

describe Sanitiser do
  describe '#call' do
    context 'when the file does not exist' do
      it 'raises file not found error' do
        expect { subject.call(nil) }.to raise_error(Errors::FileNotFound)
      end
    end

    context 'when file exists' do
      let(:file) { './test.log' }

      it 'sanitises the content' do
        expect(subject.call(file)).to eq ["foo 1.2.3.4\n", "bar 2.3.4.5\n", "foo 1.2.3.4\n"]
      end
    end
  end
end
