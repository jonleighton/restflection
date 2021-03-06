require File.dirname(__FILE__) + "/../spec_helper"

module Restflection

  describe Restflect, "when included in a CarsController" do

    include SharedStubs

    before do
      controller_stub(:controller_name => "cars")
      ActionController::Resources.stubs(:resource).returns("cars" => stub(:name_prefix => ""))
      (class << @controller; self; end).send :include, Restflect
    end

    it "should initialize and return a ResourceReflection with a name of 'car' when restflect(:member) is called" do
      ResourceReflection.expects(:new).with(@controller, "car").returns(reflection_stub)
      @controller.restflect(:member).should == @reflection
    end

    it "should initialize and return a ResourceReflection with a name of 'cars' when restflect(:collection) is called" do
      ResourceReflection.expects(:new).with(@controller, "cars").returns(reflection_stub)
      @controller.restflect(:collection).should == @reflection
    end

    it "should raise an ArgumentError when restflect is called with something other than :collection or :member" do
      lambda { @controller.restflect(:peruvian_skies) }.should raise_error(ArgumentError)
    end

    after do
      @controller = nil
    end
  
  end

  describe Restflect, "when included in a DucksController which has a name prefix of 'quack'" do

    include SharedStubs

    before do
      controller_stub(:controller_name => "ducks")
      ::ActionController::Resources.stubs(:resources).returns("ducks" => stub(:name_prefix => "quack"))
      (class << @controller; self; end).send :include, Restflect
    end

    it "should set the name prefix on the reflection" do
      reflection_stub.expects(:name_prefix=).with("quack")
      ResourceReflection.stubs(:new).with(@controller, "ducks").returns(@reflection)
      @controller.restflect(:collection).should == @reflection
    end

    after do
      @controller = nil
    end

  end

end
