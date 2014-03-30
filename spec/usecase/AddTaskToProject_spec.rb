describe TM::AddTaskToProject do
  before do
    @database = TM.database
  end

  it "adds a task to a project" do
    # Set up our data
    project = @database.create_new_project("project")
    result = subject.run({ :project_id => project.id, :priority => 3, :description => ["yellow", "task"]})
    expect(result.success?).to eq true
    expect(result.task.project_id).to eq(project.id)
  end

  it "errors if the project does not exist" do
    # Set up our data
    result = subject.run({ :project_id => 5, :priority => 3, :description => "yellow task" })
    expect(result.error?).to eq true
    expect(result.error).to eq (:project_not_found)
  end

  it "gives error if no task description is given" do
    project = @database.create_new_project("project")
    result = subject.run({ :project_id => project.id, :priority => 3, :description => [] })
    expect(result.error).to eq (:no_description_given)
  end
end
