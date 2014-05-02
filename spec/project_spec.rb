require 'spec_helper'
require 'pry'           #used to allow Pry debugger

describe 'Project' do   #describes what the Project class should do

  # 'TM::Project.reset_class_variables' is an example of using a Class method
  # '@project_1' is an example of using an instance method
  # the @ also indicates that it is a
  before(:each) do
    TM::Project.reset_class_variables         #class method
    @project_1 = TM::Project.new("proj1")     #Project intstance method
  end

  #it-statements are used to test different functionalities and methods
  #it 'exists' is a simple way of testing that TM::Project is a class
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  #this tests the initialize / .new method
  #the .name and .project_id values are accessible because of
  #the attr_reader in the project.rb code
  it "can a new project with a name and a unique ID number" do
    @project_1 = TM::Project.new("proj1")
    expect(@project_1.name).to eq ("proj1")
    expect(@project_1.project_id).to eq(1)
  end

  # it "" do
  # end

end
