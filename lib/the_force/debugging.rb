module TheForce
  module Debugging
    def peval(&b)
      return unless block_given?
      
      printf "#{params}:", eval("#{params}", b.binding)
    rescue NameError => e
      puts "peval: error: Could not eval argument"
    end
    
    def ppeval(&b)
      unless params.nil? or not params.respond_to? :to_s
        params.map do |x|
          pp x, eval(x, mr_binding)
        end
      end      
    rescue NameError => e
      puts "peval: error: Could not eval argument"
    end
  end
end