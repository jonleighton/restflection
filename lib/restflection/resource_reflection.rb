module Restflection
  class ResourceReflection

    attr_reader :name
    attr_accessor :name_prefix

    def initialize(controller, name)
      @controller, @name = controller, name
      @name_prefix = ""
    end

    def it
      @controller.instance_variable_get(instance_variable_name)
    end

    def it=(resource)
      @controller.instance_variable_set(instance_variable_name, resource)
    end

    def human_name
      name.humanize.downcase
    end

    def titleized_name
      name.titleize
    end

    def instance_variable_name
      "@#{name}"
    end

    def klass
      name.singularize.classify.constantize
    end

    URL_HELPER_FORMAT = /(?:hash_for_formatted|hash_for|formatted)/
    URL_HELPER_ACTION = /.*?/
    URL_HELPER_SUFFIX = /url|path/
    
    URL_HELPER = /\A(?:(#{URL_HELPER_FORMAT})_)?(?:(#{URL_HELPER_ACTION})_)?(#{URL_HELPER_SUFFIX})\Z/
    
    def method_missing(method_name, *args)
      if method_name.to_s =~ URL_HELPER
        format, action, suffix = parse_url_helper(method_name)
        
        url_helper = build_helper_method(format, action, suffix)
        args << it if args.empty? && member? && member_action?(action)
        
        @controller.send(url_helper, *args)
      else
        raise NoMethodError.new("undefined method '#{method_name}'", method_name, args)
      end
    end

    private

      def member?
        name == name.singularize
      end

      def member_action?(name)
        if name.blank? # action is "show"
          member_action = true
        else
          member_action = false
          resource = ::ActionController::Resources.resources[@controller.controller_name]
          if resource
            Array(resource.member_methods).each do |method|
              member_action = true if method.include?(name.to_sym)
            end
          end
        end
      end

      def parse_url_helper(name)
        returning parts = [] do
          3.times do |i|
            part = name.to_s.sub(URL_HELPER, "\\#{i + 1}")
            part = nil if part.blank?
            parts << part
          end
        end
      end

      def build_helper_method(format, action, suffix)
        returning url_helper = "" do
          url_helper << format + "_" if format
          url_helper << name_prefix
          url_helper << action + "_" if action
          url_helper << name + "_" + suffix
        end
      end
    
  end
end
