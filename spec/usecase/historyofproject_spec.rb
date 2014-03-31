describe TM::HistoryOfProject do
  before do
    @database = TM.database
  end

  it "gives you back history of project, completed tasks" do
    # Set up our data
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    task.status = "complete"
    result = subject.run( :project_id => project.id )
     expect(result.success?).to eq true
  end

  it "errors if no completed tasks are found" do
    project = @database.create_new_project("project")
    task = @database.add_task(1, 5, "yellow task")
    result = subject.run({ :project_id => project.id })
    expect(result.success?).to eq false
    expect(result.error).to eq(:no_completed_tasks_found)
  end

  it "errors if no project is found" do
     result = subject.run({ :project_id => nil })
     expect(result.success?).to eq false
    expect(result.error).to eq(:project_not_found)
  end
end


