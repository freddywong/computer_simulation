require_relative 'cpu_error'

class ProcessError < CpuError
  private

  def variables
    """
      ======== VARIABLES ========
      MEMORY: #{@opts[:memory]}
      PROGRAM COUNTER: #{@opts[:program_counter]}
      MEMORY STORE: #{@opts[:memory_store]}
    """
  end
end