require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

  xit 'can be created with project id, description, and priority number' do
  	newproject = TM::Project.new("cp")

  	newtask = TM::Task.new("red",2,TM::Project.id)
  	expect(newtask.project_id).to eq(TM::Project.id)
  end

  
end
