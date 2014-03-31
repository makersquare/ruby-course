describe TM::MarkTaskAsComplete do
  before do
    @database = TM.database
  end

  it "allows you to complete the task" do
    project = @database.create_new_project("project")
    task = @database.add_task(project.id, 5, "yellow task")
    expect(task.status).to eq("incomplete")
    result = subject.run({:task_id => task.id})
    expect(result.success?).to eq(true)
    expect(task.status).to eq("complete")
  end

  it "gives you an error if task not exist" do
    result = subject.run({:task_id => 30})
    expect(result.error).to eq(:task_not_found)
  end
end
