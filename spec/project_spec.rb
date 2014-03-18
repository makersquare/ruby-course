require 'spec_helper'

describe 'Project' do
  it "exists" do
    expect(TM::Project).to be_a(Class)
  end

  it "can be created with a name and unique id" do
	newproject = TM::Project.new ('project1')
	expect(newproject.name).to eq('project1')

	id = (0...8).map { (65 + rand(26)).chr }.join
	expect(TM::Project.id).not_to be_empty
	end

  it "can mark test as completed based on id" do
  	newproject = TM::Project.new("cp")
  	newtask = TM::Task.new("red",1,TM::Project.id)

  	expect(newtask.task_completion).to eq([newtask.project_id, "no"])
  	expect(newtask.complete).to eq([newtask.project_id, "yes"])
  end
end

