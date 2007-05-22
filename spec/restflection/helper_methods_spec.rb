require File.dirname(__FILE__) + "/../spec_helper"

module Restflection

  describe HelperMethods, "when included in a helper" do

    before do
      @helper = Class.new
      (class << @helper; self; end).send :include, HelperMethods
    end

    it "should should reflect the collection variable when asked for the collection" do
      @helper.expects(:restflect).with(:collection).returns(mock(:it => true))
      @helper.collection
    end

    it "should should reflect the member variable when asked for the member" do
      @helper.expects(:restflect).with(:member).returns(mock(:it => true))
      @helper.member
    end

  end

end
