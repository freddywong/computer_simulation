require_relative 'cpu_error'

class ExecuteError < CpuError
  private

  def variables
    puts """
      ======== VARIABLES ========
      INSTRUCTION: #{@opts[:instruction]}
      VALUE: #{@opts[:value]}
    """
  end
end