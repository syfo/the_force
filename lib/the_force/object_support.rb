#--
#CRZ - imitate andand to a great degree. 
#      Could have something more complex than if or unless, but they're enough, and didnt want to introduce proc overhead.
#    - logic duplication, three ""inverted^ return ? caller : nil""s
###  - better behavior for args WITH a block?

module TheForce
  module ObjectSupport
    if Module.constants.include?('BasicObject')
      class ConditionalReturningMe < BasicObject
      end
    else
      class ConditionalReturningMe
        instance_methods.reject { |m| m =~ /^__/ }.each { |m| undef_method m }
      end
    end
    
    def self.conditional(who, inverted, *args, &b) # :doc:
      if block_given?
        (inverted ^ yield(who)) ? who : nil
      elsif args.length > 0
        (inverted ^ who.send(*args)) ? who : nil
      else
        ConditionalReturningMe.new(who, inverted)
      end
    end

    # This is the blankslate object returned by the Object#if and Object#unless methods when called with no arguments or block.
    class ConditionalReturningMe
      def initialize(me, inverted)
        super()
        @me = me
        @inverted = inverted
      end

      def method_missing(sym, *args, &b) # :doc:
        (@inverted ^ @me.send(sym, *args, &b)) ? @me : nil
      end
    end

    module InstanceMethods
      # Will return a nil if the condition is false, otherwise it will return the receiver. The condition 
      # can be specified in 3 ways, as a list of arguments which are sent to Object#send, a block, or via essentially a 
      # delegate object, ala the andand gem.
      #
      # == Examples
      # - 10.if(:>, 5)            => 10
      # - 10.if {|x| x == 5)      => nil
      # - 10.if.nonzero?          => 10
      #
      # == Usage
      # This becomes useful to simplify logic when you want to specify a default value,
      # (particularly in Rails views) or you have a receiver which is the result of a lengthy expression.
      #
      # * number_of_products.if.nonzero? || "Don't you want to buy something?"
      # * lovers.sort.reverse.unless.empty? || "Where's the fever? :("
      #
      # == Warning
      # Do not try to do:
      #   
      # * title.if.length > 20 || title.truncate[0,17] + "..."
      #
      # This would evaluate to:
      #
      # * title > 20 || title.truncate(17) + "..."
      def if(*args, &b)
        TheForce::ObjectSupport.conditional(self, false, *args, &b)
      end

      # Same as +if+, only with the predictably inverse logic.
      #
      # == Usage
      # * title.unless.blank? || suggestion_html "please set your title on the edit page"
      def unless(*args, &b)
        TheForce::ObjectSupport.conditional(self, true, *args, &b)
      end

      def eigenclass #this could also be labeled 'self'?
        class << self; self; end
      end

    end
  end
end

class Object
  include TheForce::ObjectSupport::InstanceMethods
end