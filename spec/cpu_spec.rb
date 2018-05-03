require "./app/cpu"
require 'spec_helper'

RSpec.describe Cpu do
  let(:cpu) { Cpu.new }

  describe '#initialize' do
    it 'sets the program_counter to 0' do
      expect(cpu.program_counter).to eq 0
    end
  end
  describe "#process" do
    context 'instruction is STOP' do
      let(:memory) { instance_double("Memory") }
      it "does not call execute" do
        allow(cpu).to receive(:instruction) { 'STOP' }
        expect(cpu).not_to receive(:execute)
        cpu.process(memory)
      end
    end
    context 'instruction is not STOP' do
      let(:memory) { [{ instruction: 'PUSH', value: 4 }, { instruction: 'STOP' }] }
      it 'calls execute' do
        expect(cpu).to receive(:execute) { cpu.instance_variable_set(:@program_counter, 1) }
        cpu.process(memory)
      end
      context 'instruction is PUSH' do
        it 'executes instruction to #push' do
          expect(cpu).to receive(:push)
          cpu.process(memory)
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(1)
        end
      end
      context 'instruction is PRINT' do
        let(:memory) { [{ instruction: 'PRINT' }, { instruction: 'STOP' }, { value: 10 }] }
        it 'executes instruction to #show' do
          expect(cpu).to receive(:show)
          cpu.process(memory)
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(1)
        end
      end
      context 'instruction is CALL' do
        let(:memory) { [{ instruction: 'CALL', value: 3 }, nil, nil, { instruction: 'STOP' }, 
          { instruction: 'PUSH', value: 5 }] }
        it 'executes instruction to #call' do
          expect(cpu).to receive(:call) { cpu.instance_variable_set(:@program_counter, 3) }
          cpu.process(memory)
        end
        it 'jumps to STOP address' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
        end
      end
      context 'instruction is MULT' do
        let(:memory) { [{ instruction: 'PUSH', value: 4 }, { instruction: 'PUSH', value: 4 }, 
          { instruction: 'MULT' }, { instruction: 'STOP' }] }
        it 'executes instruction to #mult' do
          expect(cpu).to receive(:mult)
          cpu.process(memory)
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
        end
      end
      context 'instruction is RET' do
        let(:memory) { [{ instruction: 'RET' }, nil, nil, { instruction: 'STOP' }, { value: 3 }] }
        it 'executes instruction to #ret' do
          expect(cpu).to receive(:ret) { cpu.instance_variable_set(:@program_counter, 3) }
          cpu.process(memory)
        end
        it 'replaces the counter with the popped value' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
        end
      end
    end
  end
end