module Restflection
  module Restflect

    def restflect(on)
      name = case on
               when :member
                 controller_name.singularize
               when :collection
                 controller_name
               else
                 raise ArgumentError, "You can only call restflect with :member or :collection"
             end
      ResourceReflection.new(self, name)
    end
    
  end
end
