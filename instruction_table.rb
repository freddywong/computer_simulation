## DESCRIPTION ##
# Instruction Table is used as a reference for the actions to be taken depending on the command

module InstructionTable
  def push
    @memory.push({ value: value })
  end

  def show
    p pop_value
  end

  def call
    @program_counter = value
  end

  def mult
    @memory.push({ value: pop_value * pop_value })
  end

  def ret
    @program_counter = pop_value
  end

  private

  def pop_value
    @memory.pop[:value]
  end
end