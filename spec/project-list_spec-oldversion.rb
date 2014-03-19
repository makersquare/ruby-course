require 'spec_helper'

describe 'ProjectList' do
  before do
    @pl = TM::ProjectList.new
  end
  describe '.initialize' do
    it "defaults the Project List with an empty projects array" do
      expect(@pl.projects).to eq([])
    end
  end

  it "can create a project and add it to the projects array" do

    result = @pl.create_project("The Best Project")
    projects_array = @pl.projects

    expect(projects_array.size).to eq(1)
    expect(projects_array.first).to be_a(TM::Project)
    # expect the return value to be the created project
    expect(result).to be_a(TM::Project)
  end

  it "can add a task to a project given project id, task priority, and task description" do
    @pl.create_project("The Best Project")
    @pl.add_task_to_proj("Eat Tacos", 3)
    project_1 = @pl.projects.first
    project_1_tasks = project_1.tasks

    expect(project_1_tasks.size).to eq(1)
    expect(project_1_tasks.description).to eq("Eat Tacos")
  end
end