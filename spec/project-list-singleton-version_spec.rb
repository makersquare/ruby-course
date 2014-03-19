require 'spec_helper'

# this spec uses the singleton version of the ProjectList

describe 'ProjectList' do
  before do
    @pl = TM::ProjectList
  end

  describe '.initialize' do
    it "defaults the Project List with an empty projects array" do
      expect(@pl.instance.projects).to eq([])
    end
  end

  it "can create a project and add it to the projects array" do

    result = @pl.instance.create_project("The Best Project")
    projects_array = @pl.instance.projects

    expect(projects_array.first).to be_a(TM::Project)
    # expect the return value to be the created project
    expect(result).to be_a(TM::Project)
  end

  it "can add a task to a project given project id, task priority, and task description" do
    # will uncomment this if want proj id to definitely equal 1
    # expect(TM::Project).to receive(:gen_id).and_return(1)

    project_1 = @pl.instance.create_project("The Best Project")
    @pl.instance.add_task_to_proj(project_1.id, "Eat Tacos", 3)
    # project_1 = @pl.instance.projects.first
    # puts project_1.id
    project_1_tasks = project_1.tasks
    project_1_task_1 = project_1.tasks.first

    expect(project_1_tasks.size).to eq(1)
    expect(project_1_task_1.description).to eq("Eat Tacos")

    expect(@pl.instance)
  end

  xit "can show remaining tasks for a project given PID" do

  end
end