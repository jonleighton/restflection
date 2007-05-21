%w(active_support).each { |r| require r }
$LOAD_PATH << File.dirname(__FILE__)
Dir[File.dirname(__FILE__) + "/restflection/*.rb"].each { |r| require r }
