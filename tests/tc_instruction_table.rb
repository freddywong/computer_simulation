require "./instruction_table"
require "test/unit"

class CpuForTestInstructionTable
  include InstructionTable
  attr_accessor :memory, :program_counter
  def initialize
    @memory = test_memory
    @program_counter = 0
  end

  def value
    23
  end

  private

  def test_memory
    [ 
      {instruction: "PUSH", value: 13}, {instruction: "PUSH", value: 24}, {instruction: "PRINT"},  
      nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, {value: 4}, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
      {value: 20}
    ]
  end  
end

class TestInstructionTable < Test::Unit::TestCase
  def setup
    @cpu = CpuForTestInstructionTable.new
  end

  def test_push
    assert_equal(@cpu.memory.concat([{value: 23}]), @cpu.push)
  end

  def test_show
    assert_equal(20, @cpu.show)
  end

  def test_call
    assert_equal(23, @cpu.call)
  end

  def test_mult
    result_memory = @cpu.memory.slice(0..@cpu.memory.size-2)
    result_memory.concat([{value: 2040}])
    @cpu.memory.concat([value: 102])
    assert_equal(result_memory, @cpu.mult)
  end

  def test_ret
    @cpu.memory.concat([value: 14])
    assert_equal(14, @cpu.ret)
  end
end