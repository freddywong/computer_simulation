class InstructionError < StandardError
  def initialize(instruction)
    super("INSTRUCTION: #{instruction} does not exist in the CPU's Instruction Table")
  end
end