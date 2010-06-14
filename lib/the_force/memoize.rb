#CRZ - any reason to support parameters in the block? would need instance_exec, and maybe some compat instance_exec for pre-1.8.7 rubies...
#    - for example this one: http://eigenclass.org/hiki/bounded+space+instance_exec

module TheForce
  module ObjectSupport
    module Memoization
      def attr_memoize(attribute, &b)
        raise ArgumentError, "attr_memoize requires a block" unless block_given?
        
        ivar = "@#{attribute}"
        self.class_eval do
          define_method attribute.to_sym do |*args|
            refresh = !!args[0]
            if not instance_variable_defined?(ivar) or refresh
              instance_variable_set(ivar, instance_eval(&b))
            else
              instance_variable_get(ivar)
            end
          end
        end
      end
    end
  end
end

class Object
  extend TheForce::ObjectSupport::Memoization 
end
