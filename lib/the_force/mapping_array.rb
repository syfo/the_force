#Ex. ~[1, 2] * 10 => [10, 20]
### inherit from basicobject or use blankslate
# default to keep mapping or one off?
# should we just get rid of the ~/+ unary operator invocation?
# include enumerable?
module TheForce
  class MappingArray
    def each(*args, &b)
      @array.each(*args, &b)
    end
  
    def initialize(array, keep_mapping=false)
      raise ArgumentError, "argument does not respond to map and each" unless array.respond_to? :map and array.respond_to? :each
      
      @array = array
      @keep_mapping = !!keep_mapping
    end

    def method_missing(sym, *args, &b); 
      a = @array.map {|element| element.send(sym, *args, &b)};
      if @keep_mapping
        a.to_ma(true)
      else
        a
      end
    end
  
    def to_ma
      self
    end
  
    def to_a
      @array
    end
  end

  module MappingArraySupport
    def to_ma(keep_mapping=false)
      MappingArray.new(self, keep_mapping)
    end
  
    def ~
      to_ma(false)
    end

    def +@
      to_ma(true)
    end
  end
end
  
class Array
  include TheForce::MappingArraySupport
end