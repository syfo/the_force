#CRZ - imitate andand to a great degree. 
#      Could have something more complex than if or unless, but they're enough, and didnt want to introduce proc overhead.
#    - logic duplication, three ""inverted^ return ? caller : nil""s
###  - better behavior for args WITH a block?

if Module.constants.include?('BasicObject')
  class ConditionalReturningMe < BasicObject
  end
else
  class ConditionalReturningMe
    instance_methods.reject { |m| m =~ /^__/ }.each { |m| undef_method m }
  end
end

class ConditionalReturningMe
  def initialize(me, inverted)
    super()
    @me = me
    @inverted = inverted
  end

  def method_missing(sym, *args, &b)
    (@inverted ^ @me.send(sym, *args, &b)) ? @me : nil
  end
end

module TheForce
  module ObjectSupport
    def if(*args, &b)
      ObjectSupport.conditional(self, false, *args, &b)
    end

    def unless(*args, &b)
      ObjectSupport.conditional(self, true, *args, &b)
    end

    private
    def self.conditional(who, inverted, *args, &b)
      if block_given?
        (inverted ^ yield(who)) ? who : nil
      elsif args.length > 0
        (inverted ^ who.send(*args)) ? who : nil
      else
        ConditionalReturningMe.new(who, inverted)
      end
    end
  end
end

class Object
  include TheForce::ObjectSupport
end