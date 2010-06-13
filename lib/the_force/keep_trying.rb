#CRZ - :exceptions uses is_a? not instance_of?
module TheForce
  class << self
    attr_accessor :timeout_class
  end

  if defined? ::SystemTimer
    @timeout_class = SystemTimer
  else
    require 'timeout'
    @timeout_class = Timeout
  end

  def TheForce.timeout(*args, &b)
    case @timeout_class
    when Timeout then Timeout.timeout(*args, &b)
    when SystemTimer then SystemTimer.timeout_after(*args, &b)
    end
  end
  
  def keep_trying(options = {}, &b)
    options = {:exceptions => [StandardError], :timeout => false}.merge(options)
    options[:exceptions] = [options[:exceptions]] unless options[:exceptions].is_a? Array
    options[:exceptions] << Timeout::Error if options[:timeout]
    options[:times] ||= 3

    try = 0;
    loop do
      begin
        try += 1
        if options[:timeout]
          TheForce.timeout(options[:timeout]) do
            return yield(try)
          end
        else
          return yield(try)
        end
      rescue Exception => e
        raise if (try >= options[:times]) or not options[:exceptions].any? {|exception| e.is_a? exception}
      end
    end
  end
  
  module_function :keep_trying
end