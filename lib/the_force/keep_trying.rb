module TheForce; end

begin
  require 'system_timer'
  def TheForce.timeout(*args, &b)
    SystemTimer.timeout_after(*args, &b)
  end
rescue LoadError => e
  puts "WARNING - SystemTimer gem not found...reverting to Timeout::timeout"
  require 'timeout'
  def TheForce.timeout(*args, &b)
    Timeout.timeout(*args, &b)
  end
end

#CRZ - :exceptions uses is_a? not instance_of?
module TheForce
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