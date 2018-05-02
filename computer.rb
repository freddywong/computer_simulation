## DESCRIPTION ##
# The Computer runs in three separate phases:
# 1. Construction Phase
# => Computer is initialized 
# => Memory is allocated to a certain size
# => Cpu's program counter is set to 0 as the starting point

# 2. Setup Phase
# => The program counter is set a certain address in memory
# => Insertion of various instructions and values into memory

# 3. Execution Phase (CPU)
# => Instruction table is referenced to decode what actions to perform
# => Performs various actions on the memory stack:
#    - Stores values
#    - Removes values
#    - Multiplies values
#    - Moves the program counter
#    - Prints values as output
#    - Stops the program

require_relative 'memory'
require_relative 'cpu'

class Computer
  def initialize(memory_size)
    @memory = Memory.new(memory_size).construct
    @cpu = Cpu.new
  end

  def set_address(address)
    @cpu.program_counter = address
    self
  end

  def insert(instruction, value=nil)
    @memory[@cpu.program_counter] = input_data(instruction, value)
    @cpu.program_counter += 1
    self
  end

  def execute
    @cpu.process(@memory)
  end

  private

  def input_data(instruction, value)
    if value
      { instruction: instruction, value: value }
    else
      { instruction: instruction }
    end
  end
end