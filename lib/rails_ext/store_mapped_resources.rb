require 'action_controller'
require 'singleton'

module ActionController
  module Resources

    def self.resources
      @resources ||= {}
    end

    class Resource

      def initialize_with_resource_storage(*args)
        initialize_without_resource_storage(*args)
        ::ActionController::Resources.resources[controller] = self
      end

      alias_method_chain :initialize, :resource_storage

    end
    
  end
end
