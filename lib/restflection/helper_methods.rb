module Restflection
  module HelperMethods

    def collection
      restflect(:collection).it
    end

    def member
      restflect(:member).it
    end

  end
end
