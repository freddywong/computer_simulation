require "./memory"
require 'spec_helper'

RSpec.describe Memory do
  let(:size) { 20 }
  let(:memory) { Memory.new(size) }
  describe '#initialize' do
    it 'initializes with a size' do
      expect(memory.instance_variable_get(:@size)).to eq size
    end
  end
  describe '#construct' do
    it 'returns an Array of a certain size' do
      expect(memory.construct).to eq(Array.new(size))
    end
  end
end