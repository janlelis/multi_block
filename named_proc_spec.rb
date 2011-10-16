# encoding: utf-8
require_relative 'named_proc'

describe "proc" do
  it "creates a new proc as usual when called with a block" do
    a = proc{}
    a.should be_instance_of Proc
    a.lambda?.should == false
  end
  
  it "creates a named proc when a method gets called on it" do
    a = proc.brawl{}
    a.should be_a Proc
    a.should be_instance_of NamedProc
    a.lambda?.should == false
    a.name == :brawl
  end
end

describe "lambda" do
  it "creates a new lambda as usual when called with a block" do
    a = lambda{}
    a.should be_instance_of Proc
    a.lambda?.should == true
  end
  
  it "creates a named lambda when a method gets called on it" do
    a = lambda.brawl{}
    a.should be_a Proc
    a.should be_instance_of NamedProc
    a.lambda?.should == true
    a.name == :brawl
  end
end
