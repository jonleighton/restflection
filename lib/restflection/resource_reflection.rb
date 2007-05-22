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

    URL_HELPER_FORMAT = /(?:hash_for_formatted|hash_for|formatted)_/
    URL_HELPER_ACTION = /.*?_/
    URL_HELPER_SUFFIX = /url|path/
    
    URL_HELPER = /\A(#{URL_HELPER_FORMAT})?(#{URL_HELPER_ACTION})?(#{URL_HELPER_SUFFIX})\Z/
    
    def method_missing(method_name, *args)
      parts = []
      3.times { |i| parts << method_name.to_s.sub(URL_HELPER, "\\#{i + 1}") }
      url_helper = parts[0] + name_prefix + parts[1] + name + "_" + parts[2]
      @controller.send(url_helper, *args)
    end

    def instance_variable_name
      "@#{name}"
    end
    
  end
end
