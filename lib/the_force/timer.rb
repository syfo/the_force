#CRZ - Have been thinking making this something you mixin...that may solve the binding issue in self.timer...
#CRZ - or just make Timer a class and you create it and then start/stop etc...multiple timers at once?
#    - lets wait til I need to do that

###CRZ - just use the benchmark module...this is redundant

module TheForce
  module Timer
    @timers = []
    @timer_depth = 0
  
    #CRZ - for mixin; expects just a symbol and list of args
    #    - helps solve passing symbol problem
    def timer(*args, &b); 
      if block_given?
      	Force::Timer.timer(*args, &b)
      else
        Force::Timer.timer args[0] do
          send(args.shift, *args)
        end
      end
    end
    def report_timers(*args); Force::Timer.report_timers(*args); end
  
    # CRZ - totally not thread coherent, but still useful
    #     - I wanted to allow you to pass in a symbol which was the method to time...but when I send(symbol) from inside this module, 
    #       the method loses its binding. for example, a method in another class which you time now wouldnt havent access to its
    #       instance variables...
    def self.timer(*args)
      name = args.shift if args.length > 0
  
      puts "TIMER #{name || ""} starting..."
      @timer_depth += 1
      start_time = Time.now
      yield
      end_time = Time.now
      @timer_depth -= 1
      puts "TIMER #{name || ""} ended: #{seconds_to_time(end_time - start_time)} elapsed"
    
      @timers << [name || "", (end_time - start_time), @timer_depth]
    end
  
    def self.report_timers
      puts 
      puts "-- TIMER REPORT IN ORDER OF timer METHOD *FINISHING*, NOT STARTING --"
      @timers.each do |x| 
        puts "#{'  ' * x[2]}#{x[0].to_s.ljust(50-(2*x[2]), " ")} : #{seconds_to_time(x[1])}"
      end
      puts
    end

    ###CRZ - might be nice to metaprogrammize and auto wrap the list of methods
    #def assign_timer(*methods)
    #end

    private
    #CRZ - prints a minimal string of type 1d1h1m1.001s
    #    - always prints seconds, but won't print other units of time unless they are relevant
    #    - hard to make this pretty...too many special cases; isn't this built already somewhere?
    def self.seconds_to_time(secs)
      units, suffixes, widths = [86400000, 3600000, 60000, 1000, 1], %w(d h m . s), [0,0,0,0,3]

      rest, times = (secs * 1000).to_i, [] #start with millis
      units.each do |x|
        times << (rest / x)
        rest %= x
      end

      time, started = "", false
      suffixes.each_with_index do |x, i|
        next if times[i] == 0 and not started and not i == (suffixes.length - 2)
      
        started = true
        time += times[i].to_s.rjust(widths[i], '0') + x
      end
  
      time
    end
  end
end  
