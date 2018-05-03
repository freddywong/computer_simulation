require "./app/cpu"
require 'spec_helper'

RSpec.describe InstructionTable do
  let(:cpu) { Cpu.new }
  
  describe '#push' do
    it 'pushes new values to memory' do
      cpu.instance_variable_set(:@memory, Array.new)
      allow(cpu).to receive(:value) { 2 }
      cpu.push
      expect(cpu.instance_variable_get(:@memory)).to eq([{ value: 2 }])
    end
  end
  describe '#show' do
    before :each do
      cpu.instance_variable_set(:@memory, [{ value: 2 }, { value: 4 }])
    end
    it 'pops the value from memory' do
      cpu.show
      expect(cpu.instance_variable_get(:@memory))
        .to eq([{ value: 2 }])
    end
    it 'prints out the popped value' do
      expect do  
        cpu.show
      end.to output("4\n").to_stdout
    end   
  end
  describe '#call' do
    it 'sets the program counter to a value' do
      expect(cpu.instance_variable_set(:@program_counter, 0))
      allow(cpu).to receive(:value) { 10 }
      cpu.call
      expect(cpu.instance_variable_get(:@program_counter)).to eq(10)
    end
  end
  describe '#mult' do
    it 'pops the last two values, multiples them and pushes to memory' do
      cpu.instance_variable_set(:@memory, [{ value: 30 }, { value: 6 }, { value: 70 }])
      cpu.mult
      expect(cpu.instance_variable_get(:@memory))
        .to eq([{ value: 30 }, { value: 420 }])
    end
  end
  describe '#ret' do
    it 'replaces the counter with the popped value' do
      cpu.instance_variable_set(:@memory, [{ value: 3 }])
      expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
      cpu.ret
      expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
    end
  end
end