require File.dirname(__FILE__) + "/../spec_helper"

module Restflection
  
  describe ResourceReflection, "with a name of 'account' and an unspecified name prefix" do

    include SharedStubs

    before do
      @reflection = ResourceReflection.new(controller_stub, "account")
    end

    it "should have an empty name prefix" do
      @reflection.name_prefix.should be_empty
    end

    it "should have an instance variable name of @account" do
      @reflection.instance_variable_name.should == "@account"
    end

    it "should return the controller's @account variable when asked for 'it'" do
      @controller.expects(:instance_variable_get).with("@account")
      @reflection.it
    end

    it "should assign the value to the controller's @account variable when asked to assign to 'it'" do
      @controller.expects(:instance_variable_set).with("@account", "Volcano")
      (@reflection.it = "Volcano").should == "Volcano"
    end

    it "should call the controller's account_path, passing along arguments, when asked for the path" do
      @controller.expects(:account_path).with("Carbon", "Monoxide")
      @reflection.path("Carbon", "Monoxide")
    end

    it "should call the controller's account_url, passing along arguments, when asked for the url" do
      @controller.expects(:account_url).with("Walka", "Walka", "Walka", "Way")
      @reflection.url("Walka", "Walka", "Walka", "Way")
    end

    it "should call the controller's hash_for_formatted_edit_account_url when asked for hash_for_formatted_edit_url" do
      @controller.expects(:hash_for_formatted_edit_account_url).with("Fire")
      @reflection.hash_for_formatted_edit_url("Fire")
    end

    it "should call the controller's formatted_new_account_path when asked for formatted_new_path" do
      @controller.expects(:formatted_new_account_path)
      @reflection.formatted_new_path
    end
    
  end

  describe ResourceReflection, "with a name of 'comment' and a name prefix of 'article_'" do

    include SharedStubs

    before do
      @reflection = ResourceReflection.new(controller_stub, "comment")
      @reflection.name_prefix = "article_"
    end

    it "should have an instance variable name of @comment" do
      @reflection.instance_variable_name.should == "@comment"
    end

    it "should call the controller's formatted_article_new_comment_path when asked for formatted_new_path" do
      @controller.expects(:formatted_article_new_comment_path)
      @reflection.formatted_new_path
    end

    it "should call the controller's hash_for_formatted_article_edit_comment_url when asked for hash_for_formatted_edit_url" do
      @controller.expects(:hash_for_formatted_article_edit_comment_url).with("Fire")
      @reflection.hash_for_formatted_edit_url("Fire")
    end

  end
  
end
