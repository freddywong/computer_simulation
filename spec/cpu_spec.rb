require "./cpu"
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
      xit 'calls execute' do
        # need to figure out how to test this without causing an infinite loop"
        # expect(cpu).to receive(:execute) causes an infinite loop
      end
      context 'instruction is PUSH' do
        let(:memory) { [{ instruction: 'PUSH', value: 4 }, { instruction: 'STOP' }] }
        it 'pushes instruction to memory' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@memory))
            .to eq([{ instruction: 'PUSH', value: 4 }, { instruction: 'STOP' }, { value: 4 }])
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(1)
        end
      end
      context 'instruction is PRINT' do
        let(:memory) { [{ instruction: 'PRINT' }, { instruction: 'STOP' }, { value: 10 }] }
        it 'pops the value from memory' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@memory))
            .to eq([{ instruction: 'PRINT' }, { instruction: 'STOP' }])
        end
        it 'prints out the popped value' do
          expect do  
            cpu.process(memory)
          end.to output("10\n").to_stdout
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(1)
        end
      end
      context 'instruction is CALL' do
        let(:memory) { [{ instruction: 'CALL', value: 3 }, nil, nil, { instruction: 'STOP' }] }
        it 'jumps to STOP address' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
        end
      end
      context 'instruction is MULT' do
        let(:memory) { [{ instruction: 'PUSH', value: 4 }, { instruction: 'PUSH', value: 4 }, 
          { instruction: 'MULT' }, { instruction: 'STOP' }] }
        it 'pops the last two values, multiples them and pushes to stack' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@memory))
            .to eq([{ instruction: 'PUSH', value: 4 }, { instruction: 'PUSH', value: 4 },
            { instruction: 'MULT' }, { instruction: 'STOP' }, { value: 16 }])
        end
        it 'increments the counter' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(3)
        end
      end
      context 'instruction is RET' do
        let(:memory) { [{ instruction: 'RET' }, { instruction: 'STOP' }, { value: 1 }] }
        it 'pops the last value' do
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@memory))
            .to eq([{ instruction: 'RET' }, { instruction: 'STOP' }])
        end
        it 'replaces the counter with the popped value' do
          expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
          cpu.process(memory)
          expect(cpu.instance_variable_get(:@program_counter)).to eq(1)
        end
      end
    end
  end
end