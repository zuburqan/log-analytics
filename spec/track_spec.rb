# frozen_string_literal: true

require 'track'

describe Track do
  describe '#call' do
    subject { described_class.new('foo_type') }

    context 'when list size is more than 1' do
      it 'returns the size along with its plural type' do
        expect(subject.call([2, 6, 7])).to eq ' 3 foo_types'
      end
    end

    context 'when list size is 1' do
      it 'returns the size along with its singular type' do
        expect(subject.call([2])).to eq ' 1 foo_type'
      end
    end
  end
end
