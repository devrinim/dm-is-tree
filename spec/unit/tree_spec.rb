require 'spec_helper'

describe DataMapper::Is::Tree do

  before do
    class ::Category
      include DataMapper::Resource

      property :id, Serial
      property :parent_id, Integer
      property :name, String
    end
  end

  it "should create a parent relationship" do
    Category.is :tree
    Category.relationships.should have_key(:parent)
  end

  it "should create a children relationship" do
    Category.is :tree
    Category.relationships.should have_key(:children)
  end

  it "should create a class method called roots" do
    Category.is :tree
    Category.should respond_to(:roots)
  end

  it "should create a class method called first_root" do
    Category.is :tree
    Category.should respond_to(:first_root)
  end

  it "should create an alias of class method first_root called root (ActiveRecord compatability)" do
    Category.is :tree
    Category.method(:root).should be_kind_of(Method)
  end

  it "should create an instance method called ancestors" do
    Category.is :tree
    Category.new.should respond_to(:ancestors)
  end

  it "should create an instance method called root" do
    Category.is :tree
    Category.new.should respond_to(:root)
  end

  it "should create an instance method called siblings" do
    Category.is :tree
    Category.new.should respond_to(:siblings)
  end

  it "should create an instance method called generation" do
    Category.is :tree
    Category.new.should respond_to(:generation)
  end

  describe "parent relationship" do

    it "should set the model from the current class" do
      # Internals of relationships has changed
      Category.is :tree
      Category.relationships[:parent].child_model.should == Category
    end

    it "should use the default child_key of :parent_id if none is supplied in the options" do
      # Internals of relationships has changed
      Category.is :tree
      Category.relationships[:parent].options[:child_key].should == [ :parent_id ]
    end

    it "should use the child_key from the options if it is supplied" do
      # Internals of relationships has changed
      Category.is :tree, :child_key => :other_id
      Category.relationships[:parent].options[:child_key].should == [ :other_id ]
    end

    it "should not set any order" do
      # Internals of relationships has changed
      Category.is :tree, :order => :name
      Category.relationships[:parent].options.should_not have_key(:order)
    end

    it 'should allow a constraint option to be specified' do
      Category.is :tree, :constraint => :destroy
      Category.relationships[:parent].options.should have_key(:constraint)
    end

  end

  describe "children relationship" do

    it "should set the model from the current class" do
      # Internals of relationships has changed
      Category.is :tree
      Category.relationships[:children].child_model.should == Category
    end

    it "should use the default child_key of :parent_id if none is supplied in the options" do
      # Internals of relationships has changed
      Category.is :tree
      Category.relationships[:children].options[:child_key].should == [ :parent_id ]
    end

    it "should use the child_key from the options if it is supplied" do
      # Internals of relationships has changed
      Category.is :tree, :child_key => :other_id
      Category.relationships[:children].options[:child_key].should == [ :other_id ]
    end

    it "should not set any order if none is supplied in the options" do
      # Internals of relationships has changed
      Category.is :tree
      Category.relationships[:children].options.should_not have_key(:order)
    end

    it "should use the order from the options if it is supplied" do
      # Internals of relationships has changed
      Category.is :tree, :order => :name
      Category.relationships[:children].options[:order].should == [ :name ]
    end

  end

end
