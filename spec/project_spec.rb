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
  	current_time = Time.now
  	Time.stub(:now).and_return(current_time)
  	newproject = TM::Project.new("cp")
  	newtask = TM::Task.new("red",1,TM::Project.id)

  	expect(newtask.task_completion).to eq([newtask.project_id, "no", Time.now])
  	expect(newtask.complete).to eq([newtask.project_id, "yes", Time.now])
  end
it 'can retrieve a list of all complete tasks, sorted by date' do
	current_time = Time.parse('3pm')
	Time.stub(:now).and_return(current_time)
  	newproject = TM::Project.new('cp')
	newtask = TM::Task.new('red',2,TM::Project.id)
	newtask.complete
	newtask2 = TM::Task.new('red',2,TM::Project.id)
	newtask2.complete
	
	
	expect(newproject.completed_tasks(newtask)).to eq([[newtask.project_id,"yes",Time.now]])

	end

end

