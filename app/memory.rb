## DESCRIPTION ##
# Memory refers to the stack of instructions that the computer needs to run through.

class Memory
  def initialize(size)
    @size = size
  end

  def construct
    Array.new(@size)
  end
end
