require 'system_timer'

#CRZ - :exceptions uses is_a? not instance_of?
module TheForce
  def self.keep_trying(times = 3, options = {}, &b)
    options = {:exceptions => [StandardError], :timeout => false}.merge(options)
    options[:exceptions] = [options[:exceptions]] unless options[:exceptions].is_a? Array
    options[:exceptions] << Timeout::Error if options[:timeout]

    try = 0;
    loop do
      begin
        try += 1
        if options[:timeout]
          SystemTimer.timeout_after(options[:timeout]) do
            return yield(try)
          end
        else
          return yield(try)
        end
      rescue Exception => e
        raise if (try >= times) or not options[:exceptions].any? {|exception| e.is_a? exception}
      end
    end
  end
end