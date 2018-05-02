class CpuError < StandardError
  def initialize(error, opts={})
    @error = error
    @opts = opts
  end

  def explain
    puts """
      ======== ERROR_TYPE ========
      #{self.class}

      ======== LOCATION ========
      CLASS: #{@opts[:class_method]}
      METHOD: #{@opts[:method]}
      
      ======== MESSAGE ========
      #{@error.message}
      
      ======== BACKTRACE ========
      #{@error.backtrace.join("\n")}
    """
    puts "#{variables}"
  end

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