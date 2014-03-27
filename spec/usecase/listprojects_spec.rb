describe TM::ListProjects do
  before do
    @database = TM.database
  end

  it "adds a task to a project" do
    # Set up our data
    project = @database.create_new_project("project")
    result = subject.run("yes")
    expect(result.success?).to eq true
    expect(result.projects[project.id].name).to eq(project.name)
  end

  it "errors if projects do not exist" do
    # Set up our data
    @database.projects = {}
    result = subject.run("yes")
    expect(result.error?).to eq true
    expect(result.error).to eq (:no_projects_found)
  end
end
