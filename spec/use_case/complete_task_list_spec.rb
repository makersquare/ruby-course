require 'spec_helper.rb'
describe TM::CompleteTaskList do
  before do
    @db = TM.db
    @project = @db.create_project("Test")
  end

  it "Lists all complete projects" do
    task1 = @db.create_task("A fun task", 5, @project.project_id)
    task2 = @db.create_task("A fun task", 5, @project.project_id)
    task3 = @db.create_task("A fun task", 5, @project.project_id)
    task4 = @db.create_task("A fun task", 5, @project.project_id)
    task5 = @db.create_task("A fun task", 5, @project.project_id)

    task1.complete = true
    task3.complete = true
    task5.complete = true

    result = subject.run({ :project_id => @project.project_id })
    expect(result.success?).to eq(true)
    expect(result.tasks.last.task_id).to eq(task5.task_id)
  end

  it "returns error if project does not exist" do
    result = subject.run({ :project_id => 1000 })
    expect(result.error?).to eq(true)
    expect(result.error).to eq(:project_does_not_exist)
  end
end
