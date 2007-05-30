require File.dirname(__FILE__) + "/../spec_helper"

module ActionController

  describe Resources, "when no resources have been added" do

    it "should return an empty hash when asked for resources" do
      Resources.resources.should == {}
    end
  
  end

  module Resources

    describe Resource, "when initialized" do

      include SharedStubs

      PeopleController = Class.new
      
      it "should add itself to the list of resources, using the controller as the key" do
        resource = Resource.new(:people, {})
        Resources.resources.should == { "people" => resource }
      end

    end

  end
  
end
