require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "has project name" do
  project1 = TM::Project.new("NYC Project")
  project1.name.should == "NYC Project"
end

 it "has a string representaion" do
  project1 = TM::Project.new("NYC Project")
  project1.should == "Welcome to Project Manager Pro®. What can I do for you today?"
 end


end
