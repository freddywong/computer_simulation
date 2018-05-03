require "./app/computer"
require 'spec_helper'

RSpec.describe Computer do
  let(:memory_size) { 50 }
  let(:computer) { Computer.new(memory_size) }
  let(:cpu) { computer.instance_variable_get(:@cpu) }

  describe '#initialize' do
    let(:memory) { computer.instance_variable_get(:@memory) }
    let(:cpu) { computer.instance_variable_get(:@cpu) }

    it 'creates the memory to be certain sized array' do
      computer
      expect(memory).to eq(Array.new(memory_size))
    end
    it 'initializes the cpu' do
      computer
      cpu.equal?(Cpu.new)
    end
  end

  describe '#set_address' do
    it "sets the cpu's program_counter to an address" do
      expect(cpu.instance_variable_get(:@program_counter)).to eq(0)
      computer.set_address(20)
      expect(cpu.instance_variable_get(:@program_counter)).to eq(20)
    end
    it "returns itself" do
      expect(computer.set_address(20)).to eq(computer)
    end
  end
  describe '#insert' do
    let(:address) { 5 }
    let(:memory) { computer.instance_variable_get(:@memory) }
    before :each do
      cpu.instance_variable_set(:@program_counter, address)
    end

    context "when instruction and value are present" do
      it "inputs both into memory at a certain address" do
        expect(memory[address]).to eq nil
        computer.insert('PUSH', 4)
        expect(memory[address]).to eq ({ instruction: 'PUSH', value: 4 })
      end
    end
    context 'when only instruction is present' do
      it "inputs instruction into memory" do
        expect(memory[address]).to eq nil
        computer.insert('RET')
        expect(memory[address]).to eq ({ instruction: 'RET' })
      end
    end
    it "increments the program_counter" do
      expect(cpu.instance_variable_get(:@program_counter)).to eq 5
      computer.insert('PUSH', 30)
      expect(cpu.instance_variable_get(:@program_counter)).to eq 6
    end
    it "returns itself" do
      expect(computer.insert('PUSH', 20)).to eq(computer)
    end
  end
  describe '#execute' do
    let(:memory) { computer.instance_variable_get(:@memory) }
    it "calls process with message" do
      expect(cpu).to receive(:process).with(memory)
      computer.execute
    end
  end
end