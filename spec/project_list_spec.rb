require 'spec_helper'

describe 'Project List' do
  before do
    @pl = TM::ProjectList.new
    @new_project = @pl.add_project('nato')
    @new_project.add_task("stop", 3)
    # @project = TM::Project.new("New Project")
    #@pl.add_tasks(1, "drop", 2)


  end


  it "exists" do
    expect(TM::ProjectList).to be_a(Class)
  end

  it 'can add a project' do
    expect(@pl.project_list[0].name).to eq('nato')
  end

  it 'can get a project' do
    new_project = @pl.add_project('nato')
    expect(@pl.get_project(new_project.project_id)).to eq(new_project)
  end

  it 'can add a task based on project id' do
    added_task = @new_project.add_task(@new_project.project_id, "roll")
    expect(@pl.project_list[0].tasks).to eq(@new_project.tasks)
  end

  xit 'can mark task completed' do
    # binding.pry
    TM::Task.class_variable_set :@@task_id, 1
    #@new_project.add_task("drop", 2)
    @new_project.complete_task(1)
    expect(@new_project.completed_task.status).to eq('complete')
  end






end
