module Reflections
    extend ActiveSupport::Concern

    module ClassMethods
      def association_for(s)
        reflect_on_association(s.to_sym)
      end

      def class_for(association)
        reflect_on_association(association.to_s).try(:klass)
      end
    
    end

    def association_for(s)
      self.class.association_for(s)
    end

    def class_for(association)
      self.class.class_for(association)
    end
  end
