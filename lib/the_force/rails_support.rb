module TheForce
  module ActiveRecordSupport
    module InstanceMethods
      def collect_column(column_name, conditions = {})
        collection = []
        column_name = column_name.to_s

        self.find_each(:select => column_name, :conditions => conditions) do |record|
          collection << record.attributes[column_name]
        end

        collection
      end
    end
  end
end

class Object
  include TheForce::ActiveRecordSupport::InstanceMethods
end