require File.dirname(__FILE__) + "/lib/restflection"
ActionController::Base.send :include, Restflection::Restflect
ActionView::Base.delegate :restflect, :to => :controller