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
require './errors/cpu/execute_error'
require './errors/cpu/process_error'

class Cpu
  include InstructionTable
  attr_accessor :program_counter

  def initialize
    @program_counter = 0
  end

  def process(memory)
    @memory = memory
    while instruction != INSTRUCTIONS[:stop]
      execute
    end
  rescue => @e
    error_checkpoint('process')
  end

  private

  def execute
    case instruction
    when INSTRUCTIONS[:push]
      push
      increment_counter
    when INSTRUCTIONS[:print]
      show
      increment_counter
    when INSTRUCTIONS[:call]
      call
    when INSTRUCTIONS[:mult]
      mult
      increment_counter
    when INSTRUCTIONS[:ret]
      ret
    end
  rescue => @e  
    error_checkpoint('execute')
  end

  def fetch
    @memory[@program_counter]
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

  def error_checkpoint(type)
    case type
    when 'process'      
      ProcessError
        .new(@e, class_method: self.class, method: 'process', 
          memory: @memory, program_counter: @program_counter)
        .explain
      exit 
    when 'execute'
      ExecuteError
        .new(@e, class_method: self.class, method: 'execute',
          instruction: instruction, value: value)
        .explain
      exit
    end
  end
end