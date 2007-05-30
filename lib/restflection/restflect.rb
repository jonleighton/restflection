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
      reflection = ResourceReflection.new(self, name)
      
      if resource = ::ActionController::Resources.resources[controller_name]
        reflection.name_prefix = resource.name_prefix
      end

      reflection
    end
    
  end
end
