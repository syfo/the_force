module TheForce
  module ActiveRecordSupport
    module DelimitedAttribute
      def attr_delimited(*args)
        options = {:delim => ','}
        options.merge(args.pop) if args.last.is_a? Hash
        
        args.each do |attr|
          define_method attr.to_sym do
            self.read_attribute(attr.to_sym).split(options[:delim])
          end
          
          define_method "#{attr}=".to_sym do |list|
            self.write_attribute(attr.to_sym, list.join(options[:delim]))
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  extend TheForce::ActiveRecordSupport::DelimitedAttribute
end