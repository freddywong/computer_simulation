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
end