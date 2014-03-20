require 'spec_helper'

describe 'Project List' do
  before do
    @pl = TM::ProjectList.new
    @project = TM::Project.new("New Project")
    @new_project = @pl.add_project('nato')
    @new_task = @pl.add_tasks(1, "Stop", 1)
   # @new_project.add_tasks(1, "drop", 2)
   # @new_project.add_tasks(1, "roll", 4)
   # @new_project.mark_complete(1, 2)


  end


  it "exists" do
    expect(TM::ProjectList).to be_a(Class)
  end

  it 'can get a project' do
    expect(@pl.get_project(1)).to eq(@new_project[0])

  end

  it 'create an create a project' do
    expect(@new_project[0]).to eq(@pl.project_list[0])
  end


  it 'can add a task' do
    expect(@pl.project_list[0].tasks).to eq(@new_task)
  end





end
