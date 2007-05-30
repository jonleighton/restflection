module Restflection
  
  def self.setup
    %w(active_support).each { |r| require r }
    $LOAD_PATH << File.dirname(__FILE__)
    %w(restflection rails_ext).each do |dir|
      Dir[File.dirname(__FILE__) + "/#{dir}/*.rb"].each { |r| require r }
    end
  end
  
end

Restflection.setup
