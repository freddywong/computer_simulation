## DESCRIPTION ##
# Cpu processes the data loaded into memory to produce actions.
# The CPU runs in three separate phases to form a cycle:
# 1. Fetch Phase
# => Uses the program counter as a reference for the address of the data (instruction, value) on the stack
# => If the instruction is 'STOP' the cycle halts and the program is stopped

# 2. Decode Phase
# => An instruction table is included into the CPU.
# => The fetched instruction from memory is referenced to the instruction table which provides the actions.

# 3. Execute Phase
# => The action is taken from the instruction table and takes place in the CPU
# => Certain instructions (PUSH, PRINT, RET) require an incrementation to occur on the program counter
# => Some instructions (CALL, RET) do not require a program counter incrementation because their corresponding actions have already included them.
# => The process starts again with the Fetch Phase.

require_relative 'instruction_table'
require './errors/execute_error'
require './errors/cpu_error'

class Cpu
  include InstructionTable
  attr_accessor :program_counter

  def initialize
    @program_counter = 0
  end

  def process(memory)
    @memory = memory
    while instruction != 'STOP'
      execute
    end 
  end

  private

  def fetch
    @memory[@program_counter]
  end

  def execute
    case instruction
    when 'PUSH'
      push
      increment_counter
    when 'PRINT'
      show
      increment_counter
    when 'CALL'
      call
    when 'MULT'
      mult
      increment_counter
    when 'RET'
      ret
    end
  end

  def instruction
    fetch[:instruction]
  end

  def value
    fetch[:value]
  end

  def increment_counter
    @program_counter += 1
  end
end