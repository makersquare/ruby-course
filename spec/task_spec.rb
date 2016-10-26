require 'spec_helper'

describe 'Task' do
  it "exists" do
    expect(TM::Task).to be_a(Class)
  end

 it "can create a new task with project id, description, and priorirty number" do
 	project = TM::Project.new("project")
 	task = TM::Task.new("red",2,project.id)

 	expect(task.description).to eq("red")
 	expect(task.priority_number).to eq(2)
 	expect(task.project_id).to eq(project.id)

 end

 it "can show if a task is complete, by id" do
 	project = TM::Project.new('project')
 	task = TM::Task.new("red",2,project.id)
 	task.complete_task

 	expect(task.task_complete).to eq(true)

 end
 
  
end

